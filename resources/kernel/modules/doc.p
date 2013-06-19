@CLASS
doc

@auto[]
	$db[$MAIN:connect_db]
	$TABLES[
		$.DOC[${MAIN:TABLES_PREFIX}doc]
	]
	$DOC_PATH[/customers/docs/files/]

@docs[_params]
	^db{
		$__docs[^table::sql{
			SELECT
				`id`,
				`title`,
				`ext`,
				`size`,
				`date`,
				`created`
			FROM
				`$TABLES.DOC`
			WHERE
				1 = 1
				^whereSql[$_params]
			ORDER BY
				`date` DESC
		}]
	}

@whereSql[_params]
	^if(def $_params && $_params is hash){
		$result[
			^if(^_params.id.int(0)){ AND `id` = '$_params.id' }
			^if(^_params.year.int(0)){ AND YEAR(`date`) = '$_params.year'}
			^if(^_params.month.int(0)){ AND MONTH(`date`) = '$_params.month'}
			^if(^_params.day.int(0)){ AND DAY(`date`) = '$_params.day'}
			^if(def $_params.dates && $_params.dates is table){
				 AND DATE(`date`) IN (^_params.dates.menu{"$_params.dates.date"}[, ])
			}
		]
	}{
		$result[]
	}

@monthCalendar[_params][yearCalendar;monthCalendar;months]
	^db{
		$yearCalendar[^table::sql{
			SELECT DISTINCT
				YEAR(`date`) AS `year`
			FROM
				`$TABLES.DOC`
			WHERE
				1 = 1
				^whereSql[$_params]
			ORDER BY
				`date` DESC
		}]
		$monthCalendar[^table::sql{
			SELECT
				YEAR(`date`) AS `year`,
				MONTH(`date`) AS `month`,
				MAX(DAY(`date`)) AS `day`
			FROM
				`$TABLES.DOC`
			WHERE
				1 = 1
				^whereSql[$_params]
			GROUP BY
				`year`,
				`month`
			ORDER BY
				`date`
		}]
		
		$result[
			<calendar>
				^yearCalendar.menu{
					<year number="$yearCalendar.year"^if($yearCalendar.year == $_params.selectedYear){ selected="true"}>
						$months[^monthCalendar.select($monthCalendar.year == $yearCalendar.year)]
						^months.menu{
							<month number="$months.month" last-day="$months.day"^if($yearCalendar.year == $_params.selectedYear && $months.month == $_params.selectedMonth){ selected="true"}/>
						}
					</year>
				}
			</calendar>
		]
	}

@daysCalendar[_params][daysCalendar]
	^db{
		$daysCalendar[^table::sql{
			SELECT DISTINCT
				DAY(`date`) AS `day`
			FROM
				`$TABLES.DOC`
			WHERE
				1 = 1
				^whereSql[$_params]
			ORDER BY
				`date` DESC
		}]
		
		$result[
			<days year="$_params.year" month="$_params.month">
				^daysCalendar.menu{
					<day number="$daysCalendar.day"^if($daysCalendar.day == $_params.selectedDay){ selected="true"}/>
				}
			</days>
		]
	}

@lastDaysCalendar[_params]
	^db{
		$__lastDaysCalendar[^table::sql{
			SELECT DISTINCT
				DATE(`date`) AS `date`
			FROM
				`$TABLES.DOC`
			ORDER BY
				`date` DESC
			LIMIT
				^_params.limit.int(6)
		}]
	}

@GET_lastDaysTable[]
	^if($__lastDaysCalendar is table){
		$result[$__lastDaysCalendar]
	}{
		^throw[doc.runtime;lastDaysTable;Can't convert object to table.]
	}

@xmlString[_node;_attr][key;value]
	$result[]
	
	^if(def $__docs){
		$result[
			^__docs.menu{
				^docXmlString[$__docs]
			}
		]
	}
	^if(def $__lastDaysCalendar){
		$result[
			^__lastDaysCalendar.menu{
				<day date="$__lastDaysCalendar.date"/>
			}
		]
	}
	^if(def $_node){$result[<${_node} ^if(def $_attr && $_attr is hash){^_attr.foreach[key;value]{ $key="^taint[xml][$value]"}}>$result</${_node}>]}

@docXmlString[_doc]
	^if(def $_doc){
		<doc id="$_doc.id" date="$_doc.date" created="$_doc.created">
			<title>^taint[xml][$_doc.title]</title>
			<ext>^taint[xml][$_doc.ext]</ext>
			<size>^taint[xml][$_doc.size]</size>
		</doc>
	}


@update[_params][ext;size;updateSql]
	^if(def $_params && $_params is hash && def $_params.title){
		^db{
			^if(def $_params.document && $_params.document is file){
				^deleteFile[$_params.id]
				
				$ext[^file:justext[$_params.document.name]]
				$size[$_params.document.size]
			}
			$updateSql[
				^if(def $_params.import_id){
					`import_id` = '$_params.import_id',
				}
				`title` = '$_params.title',
				^if(def $ext){
					`ext` = '$ext',
					`size` = '$size',
				}
				`date` = ^if(def $_params.date){'$_params.date'}{NOW()}
			]
			$result[$_params.id]
			
			^void:sql{
				INSERT INTO `$TABLES.DOC` SET
					`id` = '^_params.id.int(0)',
					`created` = NOW(),
					$updateSql
				ON DUPLICATE KEY UPDATE
					$updateSql
			}
			^if(!$result){
				$result(^int:sql{ SELECT LAST_INSERT_ID() FROM `$TABLES.DOC` }[ $.limit(1) $.default{0} ])
			}
			^if(def $ext){
				^_params.document.save[binary;^filePath[$result;$ext]]
			}
		}
	}

@delete[_id]
	^if(^_id.int(0)){
		^db{
			^deleteFile[$_id]
			
			^void:sql{
				DELETE FROM `$TABLES.DOC` WHERE `id` = '$_id'
			}
		}
	}

@deleteFile[_id]
	^if(^_id.int(0)){
		^db{
			$ext[^string:sql{ SELECT `ext` FROM `$TABLES.DOC` WHERE `id` = '$_id' }[$.limit(1) $.default[]]]
				
			^if( -f "^filePath[$_id;$ext]"){
				^file:delete[^filePath[$_id;$ext]]
			}
		}
	}

@filePath[_id;_ext]
	$result[${DOC_PATH}plk-lizing-${_id}.$_ext]
