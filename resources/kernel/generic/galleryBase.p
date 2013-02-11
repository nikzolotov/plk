#utf8###########################################################################
#	Фотогалерея / gallery v1.0  20.12.2009
#	Автор: Солнцев Иван | prog@infolio2.ru
################################################################################

@CLASS
galleryBase


@auto[]
	$db[$MAIN:connect_db]
	$tables[
		$.gallery[`${MAIN:TABLES_PREFIX}_gallery`]
	]
	$LINK_FIELD[`link_field`]
	$PIC_DIR[/img/gallery]

@list[owner;ids]
	^db{
		$__list[^table::sql{
			SELECT
				id,
				$LINK_FIELD AS `owner`,
				title,
				width,
				height,
				ext,
				`order`,
				version
			FROM $tables.gallery g 
			WHERE 
				^if(def $owner){ $LINK_FIELD = ^owner.int(0) }
				^if(def $ids){ id IN ($ids)}
			ORDER BY `order`
		}]
	}

@GET_table[]
	$result[$__list]


@update[params][p;id]
	^if(def $params && $params is hash){
		^db{
			$params.id(^params.id.int(0))
			^void:sql{
				INSERT INTO $tables.gallery SET
					`id` = '$params.id',
					`title` = '$params.title',
					`order` = 0,
					$LINK_FIELD = '$params.owner'
				ON DUPLICATE KEY UPDATE
					`title` = '$params.title'
			}
			^if(!$params.id){
				$id[^int:sql{SELECT LAST_INSERT_ID()}]
				^void:sql{UPDATE $tables.gallery SET `order` = `id` WHERE `id` = '$id'}
			}{
				$id[$params.id]
			}
			
			^if(def $params.photo){
				$p[^uploadPic[$params.photo;$params.owner;$id;$params.wm]]
				
				^void:sql{
					UPDATE
						$tables.gallery
					SET
						`ext` = 'jpg',
						`width` = '$p.width',
						`height` = '$p.height',
						`version` = `version` + 1
					WHERE `id` = '$id'
				}
			}
			
			$result[$id]
		}
		^changeHandler[$params.owner;$id]
	}

@uploadPic[f;owner;id;wm][p;r]
	^useModule[picture]
	
	$r[^picture:resize[$f](620;380)]
	^r.save[binary;$PIC_DIR/$owner/${id}.jpg]
	
	$r[^picture:resize[$f;;49]]
	^r.save[binary;$PIC_DIR/$owner/${id}__49.jpg]
	
	^if(def $wm){
		^picture:watermark[$PIC_DIR/$owner/${id}.jpg;/img/wm.png;bottom-left]
	}
	
	$result[^image::measure[$PIC_DIR/$owner/${id}.jpg]]

@cropPreview[owner;id;left;top]
	$f[^file::load[binary;$PIC_DIR/$owner/${id}_450_280.jpg]]
	$p[^picture:resize[$f](140;105)[
		$.crop[true]
		$.left[$left]
		$.top[$top]
	]]
	^p.save[binary;$PIC_DIR/$owner/${id}_140_105.jpg]
	$p[^picture:resize[$f](118;86)[
		$.crop[true]
		$.left[$left]
		$.top[$top]
	]]
	^p.save[binary;$PIC_DIR/$owner/${id}_118_86.jpg]
	$p[^picture:resize[$f](70;62)[
		$.crop[true]
		$.left[$left]
		$.top[$top]
	]]
	^p.save[binary;$PIC_DIR/$owner/${id}_70_62.jpg]
	^db{
		^void:sql{ UPDATE $tables.gallery SET `version`=`version`+1 WHERE `id`='$id' }
	}

@delete[id][owner;l]
	^if(def $id){
		^db{
			$owner[^int:sql{SELECT $LINK_FIELD AS `owner` FROM $tables.gallery WHERE `id`='$id'}[$.default(0)]]
			$l[^file:list[$PIC_DIR/$owner;^^${id}(\.|_)]]
			^l.menu{
				^file:delete[$PIC_DIR/$owner/$l.name]
			}
			^void:sql{ DELETE FROM $tables.gallery WHERE `id` = '$id' }
			^changeHandler[$owner;$id]
		}
	}

@moveUp[id][o;t]
	^db{
		$o[^table::sql{SELECT `order`, $LINK_FIELD AS `owner` FROM $tables.gallery WHERE id='$id'}]
		$t[^table::sql{SELECT id, `order` FROM $tables.gallery WHERE $LINK_FIELD = '$o.owner' and `order`<'$o.order' ORDER BY `order` DESC LIMIT 1}]
		^if($t){
			^void:sql{UPDATE $tables.gallery SET `order` = '$o.order' WHERE id='$t.id'}
			^void:sql{UPDATE $tables.gallery SET `order` = '$t.order' WHERE id='$id'}
		}
	}
	^changeHandler[$o.owner;$id]

@moveDown[id][t;o]
	^db{
		$o[^table::sql{SELECT `order`, $LINK_FIELD AS `owner` FROM $tables.gallery WHERE id='$id'}]
		$t[^table::sql{SELECT id, `order` FROM $tables.gallery WHERE $LINK_FIELD='$o.owner' and `order`>'$o.order' ORDER BY `order` LIMIT 1}]
		^if($t){
			^void:sql{UPDATE $tables.gallery SET `order`='$o.order' WHERE id='$t.id'}
			^void:sql{UPDATE $tables.gallery SET `order`='$t.order' WHERE id='$id'}
		}
	}
	^changeHandler[$o.owner;$id]

@changeHandler[owner;id]


@xml[node;attr]
	$result[^xdoc::create{<?xml version="1.0" encoding="$MAIN:CHARSET"?>^xmlString[$node;$attr]}]

@xmlString[node;attr][k;v]
	$result[]
	^if(def $__list){
		$result[
			^__list.menu{
				^itemXml[]
			}
		]
	}
	^if(def $node){$result[<${node} ^if(def $attr && $attr is hash){^attr.foreach[k;v]{ $k="^taint[xml][$v]"}}>$result</${node}>]}

@itemXml[]
	<photo id="$__list.id" owner="$__list.owner" version="$__list.version">
		<title>$__list.title</title>
		<ext>$__list.ext</ext>
		<path>$PIC_DIR/$__list.owner/$__list.id</path>
		<width>$__list.width</width>
		<height>$__list.height</height>
	</photo>

@jsonString[]
	$result[^[
		^__list.menu{^{
			"id":"$__list.id",
			"owner":"$__list.owner",
			"title":"^taint[js][$__list.title]",
			"ext": "$__list.ext?$__list.version",
			"path": "$PIC_DIR/$__list.owner/$__list.id"
		^}}[,]
	^]]