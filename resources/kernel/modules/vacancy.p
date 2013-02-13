@CLASS
vacancy

@auto[]
	$db[$MAIN:connect_db]
	$TABLES[
		$.VACANCY[${MAIN:TABLES_PREFIX}vacancy]
	]
	$escapeXml(false)


@vacancies[_params]
	^db{
		$__vacancies[^table::sql{
			SELECT
				`id`,
				`title`,
				`intro`,
				`desc`,
				`require`,
				`salary`,
				`employment`,
				`date`,
				`published`
			FROM
				`${TABLES.VACANCY}`
			WHERE
				1 = 1
				^if(^_params.id.int(0)){
					AND `id` = $_params.id
				}
				^if($_params.published){
					AND `published` = ^_params.published.int(0)
				}
			ORDER BY
				`date` DESC
		}]
	}

@GET_table[]
	^if($__vacancies is table){
		$result[$__vacancies]
	}


@updateVacancy[_params][sql]
	^if(def $_params && $_params is hash){
		$result(^_params.id.int(0))
		$sql[
			`title` = ^if(def $_params.title){'$_params.title'}{NULL},
			`intro` = ^if(def $_params.intro){'$_params.intro'}{NULL},
			`desc` = ^if(def $_params.desc){'$_params.desc'}{NULL},
			`require` = ^if(def $_params.require){'$_params.require'}{NULL},
			`salary` = ^if(def $_params.salary){'$_params.salary'}{NULL},
			`employment` = ^if(def $_params.employment){'$_params.employment'}{NULL},
			`date` = ^if(def $_params.date){'$_params.date'}{NOW()},
			`published` = ^_params.published.int(0)
		]
		^db{
			^void:sql{
				INSERT INTO `${TABLES.VACANCY}` SET
					^if(^_params.id.int(0)){`id` = ^_params.id.int(0),}
					$sql
				ON DUPLICATE KEY UPDATE
					$sql
			}
			^if(!$result){
				$result(^int:sql{ SELECT LAST_INSERT_ID() FROM `${TABLES.VACANCY}` }[ $.limit(1) $.default{0} ])
			}
		}
	}{
		$result(0)
	}

@deleteVacancy[_id]
	^if(^_id.int(0)){
		^db{
			^void:sql{DELETE FROM `${TABLES.VACANCY}` WHERE `id` = '$_id'}
		}
	}


@xmlString[_node;_attr][k;v]
	$result[]
	^if(def $__vacancies){
		$result[
			^__vacancies.menu{
				<vacancy id="$__vacancies.id" date="$__vacancies.date" ^if($__vacancies.published){ published="true"}>
					^if(def $__vacancies.title){<title>^toXml[$__vacancies.title]</title>}
					^if(def $__vacancies.intro){<intro>^toXml[$__vacancies.intro]</intro>}
					^if(def $__vacancies.desc){<desc>^toXml[$__vacancies.desc]</desc>}
					^if(def $__vacancies.require){<require>^toXml[$__vacancies.require]</require>}
					^if(def $__vacancies.salary){<salary>^toXml[$__vacancies.salary]</salary>}
					^if(def $__vacancies.employment){<employment>^toXml[$__vacancies.employment]</employment>}
				</vacancy>
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