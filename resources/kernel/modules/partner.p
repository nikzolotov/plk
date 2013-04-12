################################################################################
#	Организации-партнёры
#	Автор: Золотов Никита (nikita@infolio.ru)
#	Дата создания: 12.04.2013
################################################################################

@CLASS
partner

@auto[]
	$db[$MAIN:connect_db]
	$TABLES[
		$.PARTNER[${MAIN:TABLES_PREFIX}partner]
		$.CITY[${MAIN:TABLES_PREFIX}city]
	]
	$IMG_PATH[/img/partners]
	$escape-xml(false)


@partners[_params]
	^db{
		$__partners[^table::sql{
			SELECT
				`id`,
				`city_id`,
				`title`,
				`desc`,
				`image`,
				`type`,
				`published`
			FROM
				`${TABLES.PARTNER}`
			WHERE
				1 = 1
				^if(^_params.id.int(0)){
					AND `id` = $_params.id
				}
				^if(^_params.cityId.int(0)){
					AND `city_id` = $_params.cityId
				}
				^if(def $_params.type){
					AND `type` = '$_params.type'
				}
				^if($_params.published){
					AND `published` = ^_params.published.int(0)
				}
		}]
	}

@cities[_params]
	^db{
		$__cities[^table::sql{
			SELECT
				`id`,
				`key`,
				`title`
			FROM
				`${TABLES.CITY}`
			ORDER BY
				`order`
		}]
	}

@GET_table[]
	^if($__partners is table){
		$result[$__partners]
	}


@updatePartner[_params][sql]
	^if(def $_params && $_params is hash){
		$result(^_params.id.int(0))
		$sql[
			`city_id` = ^_params.city_id.int(0),
			`title` = ^if(def $_params.title){'$_params.title'}{NULL},
			`desc` = ^if(def $_params.desc){'$_params.desc'}{NULL},
			^if(def $_params.type){`type` = '$_params.type',}
			`published` = ^_params.published.int(0)
		]
		^db{
			^void:sql{
				INSERT INTO `${TABLES.PARTNER}` SET
					^if(^_params.id.int(0)){`id` = ^_params.id.int(0),}
					$sql
				ON DUPLICATE KEY UPDATE
					$sql
			}
			^if(!$result){
				$result(^int:sql{ SELECT LAST_INSERT_ID() FROM `${TABLES.PARTNER}` }[ $.limit(1) $.default{0} ])
				^void:sql{
					UPDATE `${TABLES.PARTNER}` SET `order` = `id` WHERE `id` = '$result'
				}
			}
			^if(def $_params.image || def $_params.delete_image){
				$extension[^string:sql{SELECT `image` FROM `${TABLES.PARTNER}` WHERE id = $result}]
				^deleteImage[$result;$extension]
				
				$extension[]
				
				^if($_params.image is file){
					$extension[^file:justext[$_params.image.name]]
					$extension[^extension.lower[]]
					^uploadImage[$_params.image;$result;$extension]
				}
				^void:sql{UPDATE `${TABLES.PARTNER}` SET `image` = '$extension' WHERE `id` = $result}
			}
		}
	}{
		$result(0)
	}

@deletePartner[_id][extension]
	^if(^_id.int(0)){
		^db{
			$extension[^string:sql{SELECT `image` FROM `${TABLES.PARTNER}` WHERE `id` = $_id}]
			^deleteImage[$_id;$extension]
			
			^void:sql{DELETE FROM `${TABLES.PARTNER}` WHERE `id` = '$_id'}
		}
	}

@uploadImage[_file;_id;_extension][resizedPicture]
	^_file.save[binary;$IMG_PATH/${_id}.${_extension}]

@deleteImage[_id;_extension]
	^if(-f "$IMG_PATH/${_id}.${_extension}"){
		^file:delete[$IMG_PATH/${_id}.${_extension}]
	}


@xmlString[node;attr][k;v]
	$result[]
	^if(def $__partners){
		$result[
			^__partners.menu{
				<partner id="$__partners.id" city_id="$__partners.city_id" type="$__partners.type" ^if($__partners.published){ published="true"}>
					^if(def $__partners.title){<title>^toXml[$__partners.title]</title>}
					^if(def $__partners.desc){<desc>^toXml[$__partners.desc]</desc>}
					^if(def $__partners.image){<image>$__partners.image</image>}
				</partner>
			}
		]
	}
	^if(def $__cities){
		$result[
			^__cities.menu{
				<city id="$__cities.id" key="$__cities.key" title="$__cities.title"/>
			}
		]
	}
	^if(def $node){$result[<${node} ^if(def $attr && $attr is hash){^attr.foreach[k;v]{ $k="^taint[xml][$v]"}}>$result</${node}>]}

@toXml[text]
	^if(${escape-xml}){
		$result[^taint[xml][$text]]
	}{
		$result[^taint[as-is][$text]]
	}
