@CLASS
person

@auto[]
	$db[$MAIN:connect_db]
	$TABLES[
		$.PERSON[${MAIN:TABLES_PREFIX}person]
	]
	$IMG_PATH[/img/persons]
	$escapeXml(false)


@persons[_params]
	^db{
		$__persons[^table::sql{
			SELECT
				`id`,
				`name`,
				`duty`,
				`body`,
				`date`,
				`email`,
				`city`,
				`photo`,
				`published`
			FROM
				`${TABLES.PERSON}`
			WHERE
				1 = 1
				^if(^_params.id.int(0)){
					AND `id` = $_params.id
				}
				^if(def $_params.city){
					AND `city` = '$_params.city'
				}
				^if($_params.published){
					AND `published` = ^_params.published.int(0)
				}
			ORDER BY
				^if(def $params.order){`$params.order`}{`date`} ^if(def $params.dir && ^params.dir.upper[] eq "DESC"){ DESC }{ ASC }
		}]
	}

@GET_table[]
	^if($__persons is table){
		$result[$__persons]
	}

@updatePerson[_params][sql;extension]
	^if(def $_params && $_params is hash){
		$result(^_params.id.int(0))
		$sql[
			`name` = ^if(def $_params.name){'$_params.name'}{NULL},
			`duty` = ^if(def $_params.duty){'$_params.duty'}{NULL},
			`body` = ^if(def $_params.body){'$_params.body'}{NULL},
			`date` = ^if(def $_params.date){'$_params.date'}{NOW()},
			`email` = ^if(def $_params.email){'$_params.email'}{NULL},
			^if(def $_params.city){`city` = '$_params.city',}
			`published` = ^_params.published.int(0)
		]
		^db{
			^void:sql{
				INSERT INTO `${TABLES.PERSON}` SET
					^if(^_params.id.int(0)){`id` = ^_params.id.int(0),}
					$sql
				ON DUPLICATE KEY UPDATE
					$sql
			}
			^if(!$result){
				$result(^int:sql{ SELECT LAST_INSERT_ID() FROM `${TABLES.PERSON}` }[ $.limit(1) $.default{0} ])
			}
			^if(def $_params.photo || def $_params.delete_photo){
				$extension[^string:sql{SELECT `photo` FROM `${TABLES.PERSON}` WHERE id = $result}]
				^deletePhoto[$result;$extension]
				
				$extension[]
				
				^if($_params.photo is file){
					$extension[^file:justext[$_params.photo.name]]
					$extension[^extension.lower[]]
					^uploadPhoto[$_params.photo;$result;$extension]
				}
				^void:sql{UPDATE `${TABLES.PERSON}` SET `photo` = '$extension' WHERE `id` = $result}
			}
		}
	}{
		$result(0)
	}

@deletePerson[_id][extension]
	^if(^_id.int(0)){
		^db{
			$extension[^string:sql{SELECT `photo` FROM `${TABLES.PERSON}` WHERE `id` = $_id}]
			^deletePhoto[$_id;$extension]
			
			^void:sql{DELETE FROM `${TABLES.PERSON}` WHERE `id` = '$_id'}
		}
	}

@uploadPhoto[_file;_id;_extension][resizedPicture]
	^useModule[picture]
	
	$resizedPicture[^picture:resize[$_file](1000;1000)]
	^resizedPicture.save[binary;$IMG_PATH/${_id}.${_extension}]
	
	$resizedPicture[^picture:resize[$_file](128;500)]
	^resizedPicture.save[binary;$IMG_PATH/${_id}_128.${_extension}]

@deletePhoto[_id;_extension]
	^if(-f "$IMG_PATH/${_id}.${_extension}"){
		^file:delete[$IMG_PATH/${_id}.${_extension}]
	}
	^if(-f "$IMG_PATH/${_id}_128.${_extension}"){
		^file:delete[$IMG_PATH/${_id}_128.${_extension}]
	}


@xmlString[_node;_attr][k;v]
	$result[]
	^if(def $__persons){
		$result[
			^__persons.menu{
				<person id="$__persons.id" date="$__persons.date" city="$__persons.city" ^if($__persons.published){ published="true"}>
					^if(def $__persons.name){<name>^toXml[$__persons.name]</name>}
					^if(def $__persons.duty){<duty>^toXml[$__persons.duty]</duty>}
					^if(def $__persons.body){<body>^toXml[$__persons.body]</body>}
					^if(def $__persons.email){<email>^toXml[$__persons.email]</email>}
					^if(def $__persons.photo){<photo>^toXml[$__persons.photo]</photo>}
				</person>
			}
		]
	}
	^if(def $_node){$result[<${_node} ^if(def $_attr && $_attr is hash){^_attr.foreach[k;v]{ $k="^taint[xml][$v]"}}>$result</${_node}>]}

@toXml[_text]
	^if($escapeXml){
		$result[^taint[xml][$_text]]
	}{
		$result[^taint[as-is][$_text]]
	}