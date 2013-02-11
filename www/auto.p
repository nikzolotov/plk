@USE
kernel.p

@auto[]
#	Определяем язык сайта
	$LANGUAGES[^xdoc::load[$RESOURCES_DIR/languages.xml]]
	$XSL-Params.default-lang[^LANGUAGES.documentElement.selectString[string(lang[1]/@id)]]
	$XSL-Params.lang[^if(def $form:lang && def ^LANGUAGES.documentElement.selectSingle[lang[@id='$form:lang']]){$form:lang}{$XSL-Params.default-lang}]
	^if($[XSL-Params].[default-lang] ne $[XSL-Params].lang){
		^Navigation.documentElement.setAttribute[base;/$XSL-Params.lang]
	}
	
	^Templates.add[page.xslt]

@site_postprocess[result]
	^if($DEBUG && def $form:xml){ ^Templates.clear[] }
	
@page-id[]
	$result[$request:uri]
	^if(^result.pos[?] > 0){ $result[^result.left(^result.pos[?])] }
	^if(^result.match[/index\.html^$]){ $result[^result.match[^^(.*/)index\.html^$][]{$match.1}] }
	^if(^result.match[^^/(admin|print)/]){ $result[^result.match[/(admin|print)(.+)][]{$match.2}] }
	$result[^result.match[^^/(admin/|print/)?(.*)(/|\.html)^$][]{$match.2}]
	$result[^result.replace[^table::create{from	to
/	.}]]
	^if($result eq "."){ $result[index] }
	^if($[XSL-Params].lang eq $[XSL-Params].[default-lang]){
		$result[${XSL-Params.lang}.$result]
	}

@static-text[Page-Id]
	^useModule[text]
	^try{
		$Text[^text::create[$Page-Id]]
		^Text.xml-string[static-text]
	}{
		^if($exception.type eq "text.not_found"){
			<static-text>
				<title>404</title>
				<text>
					<p>Запрашиваемая страница не найдена.</p>
#					<p>$Page-Id</p>
				</text>
			</static-text>
			$exception.handled(true)
			$response:status[404 Not found]
		}
	}

@GET_validEmailReceived[]
	$result(
		^isEmailValid[$form:email]
	)

@isEmailValid[_email]
	$result(
		def $_email && $_email is string &&
		^_email.match[^^(^[a-zA-Z0-9_\.\-^])+\@((^[a-zA-Z0-9\-^])+\.)+(^[a-zA-Z0-9^]{2,4})+^$][i]
	)