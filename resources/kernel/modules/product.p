@CLASS
product

@auto[]
	$db[$MAIN:connect_db]
	$TABLES[
		$.PRODUCT[${MAIN:TABLES_PREFIX}product]
	]
	$IMG_PATH[/img/products]
	$escapeXml(false)


@products[_params]
	^db{
		$__products[^table::sql{
			SELECT
				`id`,
				`title`,
				`desc`,
				`price`,
				`date`,
				`photo`,
				`published`
			FROM
				`${TABLES.PRODUCT}`
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
				^if(def $params.order){`$params.order`}{`date`} ^if(def $params.dir && ^params.dir.upper[] eq "ASC"){ ASC }{ DESC }
		}]
	}

@GET_table[]
	^if($__products is table){
		$result[$__products]
	}

@updateProduct[_params][price;sql;extension]
	^if(def $_params && $_params is hash){
		$result(^_params.id.int(0))
		$price[^_params.price.match[[^^0-9]][g]{}]
		$sql[
			`title` = ^if(def $_params.title){'$_params.title'}{NULL},
			`desc` = ^if(def $_params.desc){'$_params.desc'}{NULL},
			`price` = ^price.int(0),
			`date` = ^if(def $_params.date){'$_params.date'}{NOW()},
			`published` = ^_params.published.int(0)
		]
		^db{
			^void:sql{
				INSERT INTO `${TABLES.PRODUCT}` SET
					^if(^_params.id.int(0)){`id` = ^_params.id.int(0),}
					$sql
				ON DUPLICATE KEY UPDATE
					$sql
			}
			^if(!$result){
				$result(^int:sql{ SELECT LAST_INSERT_ID() FROM `${TABLES.PRODUCT}` }[ $.limit(1) $.default{0} ])
			}
			^if(def $_params.photo || def $_params.delete_photo){
				$extension[^string:sql{SELECT `photo` FROM `${TABLES.PRODUCT}` WHERE id = $result}]
				^deletePhoto[$result;$extension]
				
				$extension[]
				
				^if($_params.photo is file){
					$extension[^file:justext[$_params.photo.name]]
					$extension[^extension.lower[]]
					^uploadPhoto[$_params.photo;$result;$extension]
				}
				^void:sql{UPDATE `${TABLES.PRODUCT}` SET `photo` = '$extension' WHERE `id` = $result}
			}
		}
	}{
		$result(0)
	}

@deleteProduct[_id][extension]
	^if(^_id.int(0)){
		^db{
			$extension[^string:sql{SELECT `photo` FROM `${TABLES.PRODUCT}` WHERE `id` = $_id}]
			^deletePhoto[$_id;$extension]
			
			^void:sql{DELETE FROM `${TABLES.PRODUCT}` WHERE `id` = '$_id'}
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
	^if(def $__products){
		$result[
			^__products.menu{
				<product id="$__products.id" price="$__products.price" date="$__products.date" ^if($__products.published){ published="true"}>
					^if(def $__products.title){<title>^toXml[$__products.title]</title>}
					^if(def $__products.desc){<desc>^toXml[$__products.desc]</desc>}
					^if(def $__products.photo){<photo>^toXml[$__products.photo]</photo>}
				</product>
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