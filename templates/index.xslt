<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="script-includes">
		<xsl:call-template name="include-script">
			<xsl:with-param name="name" select="'px-loader'"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="html-body">
		<div id="loader-modal" class="l-modal" style="display: block;">
			<div class="l-modal-outer">
				<div class="l-modal-inner">
					<div class="l-modal-container">
						<p id="loader-console">0%</p>
					</div>
				</div>
			</div>
		</div>		
		<div id="external_content" class="l-external-content">
			<div class="l-header">
				<xsl:call-template name="header"/>
			</div>
		</div>
		<div class="l-page">
			<div id="about" class="l-about-company">
				<div class="l-content">
					<div class="b-logo">
						<h1 class="title"> Первая Лизинговая Компания</h1>
					</div>
					<div class="b-zigzag-design">
						<xsl:call-template name="service-menu-deployed"/>
						<i class="zigzag-top"><xsl:text><![CDATA[]]></xsl:text></i>
						<i class="zigzag-bottom"><xsl:text><![CDATA[]]></xsl:text></i>
					</div>
				</div>
				<div class="l-footer">
					<div class="b-copyright">© 2007—2012 ООО «Первая Лизинговая Компания»</div>
				</div>
				<div class="l-inner">
					<div class="b-area-title">
						<h1 class="b-title"><span class="text">Мы — Первая лизинговая компания</span></h1>
					</div>
					<div class="l-column-600">
						<p class="b-big-line-height">В числе наших клиентов многие крупнейшие предприятия города Твери и Тверской области. В настоящий момент заключено более 1 500 договоров финансового лизинга с более чем 800 лизингополучателями. Численность персонала компании — 14 человек. В 2007 году было открыто представительство в г. Москва. Первая Лизинговая Компания имеет партнерские отношения с универсальнаядом крупнейших банков Тверского региона.</p>
						<ul class="b-icon-list">
							<li class="item">
								<a href="http://finefinance.ru/lizingovye-kompanii/pervaya-lizingovaya-kompaniya-tver" class="link" target="_blank"><b class="b-icon b-icon-square"><b><xsl:text><![CDATA[]]></xsl:text></b></b> Мы в каталоге <br/>лизинговых компаний</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/group[@id = 'rest']/item[@key = 'sale']" mode="navigation-item-path"/>
									</xsl:attribute>
									<b class="b-icon b-icon-sale"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									<xsl:text> Распродажа </xsl:text>
									<br/>
									<xsl:text>лизингового имущества</xsl:text>
								</a>
							</li>
						</ul>
					</div>
					<div class="b-moving-car">
						<i class="traffic-line">
							<xsl:text><![CDATA[]]></xsl:text>
						</i>
						<i class="car">
							<xsl:text><![CDATA[]]></xsl:text>
						</i>
					</div>
					<div class="l-column-600">
						<p>Компания занимает достойную позицию на финансовом рынке Центрального федерального округа (24-е место по итогам 2009 года), а так же стабильно входит в сотню крупнейших 1-го полугодия 2010 года).</p>
						<ul class="b-icon-list b-icon-list-zigzag">
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/group[@id = 'rest']/item[@key = 'team']" mode="navigation-item-path"/>
									</xsl:attribute>
									<b class="b-icon b-icon-mini-promotion"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									<xsl:text> Руководство </xsl:text>
									<br/>
									<xsl:text>компании</xsl:text>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/group[@id = 'rest']/item[@key = 'hire']" mode="navigation-item-path"/>
									</xsl:attribute>
									<b class="b-icon b-icon-jobs"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									<xsl:text> Вакансии</xsl:text>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<xsl:call-template name="company-features"/>
			</div>
			<div id="special-technics" class="l-special-achinery">
				<div class="l-inner">
					<div class="b-area-title">
						<h1 class="b-title"><span class="text">Спецтехника в лизинге</span></h1>
					</div>
					<div class="l-column-600">
						<ul class="b-list-equipment">
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-excavator"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Экскаваторы <br/>и бульдозеры</span>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-tractor"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Сельско-<br/>хозяйственная <br/>техника</span>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-municipal"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Коммунальная <br/>техника</span>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-machinery"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Дорожно-<br/>строительная <br/> техника</span>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-lift-truck"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Автопогрузчики</span>
								</a>
							</li>
						</ul>
						<p class="b-big-text">Первая Лизинговая Компания готова предложить своим клиентам отличные условия лизинга машин различных марок при приобретении от одной машины до автопарка.</p>
						<div class="b-special-achinery">
							<img src="img/elements/special_achinery_big.png" class="image"/>
						</div>
						<div class="h-bottom-30">
							<p>Первая Лизинговая Компания сотрудничает с большинством крупных дилеров и официальных представителей ведущих производителей автотранспорта. Среди партнеров компании дилеры легкового и грузового автотранспорта, автосалоны, расположенные в Москве и регионах России.Поставщик автотранспорта определяется лизингополучателем самостоятельно. Мы можем помочь клиенту, предоставив информацию о продавцах, однако окончательный выбор продавца остается за лизингополучателем.</p>
						</div>
						<xsl:call-template name="conditions"/>
					</div>
				</div>
			</div>
			<div id="motor-vehicles" class="l-motor-transport">
				<div class="l-inner">
					<div class="b-area-title">
						<h1 class="b-title"><span class="text">Автотранспорт в лизинг</span></h1>
					</div>
					<div class="l-column-600">
						<ul class="b-list-equipment b-list-transport">
							<li class="item">
								<a class="link" href="?">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'light']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-passenger"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Легковой <br/>автотранспорт</span>
								</a>
							</li>
							<li class="item">
								<a class="link" href="?">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'heavy']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-cargo"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Грузовой <br/>автотранспорт</span>
								</a>
							</li>
							<li class="item">
								<a class="link" href="?">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'heavy']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-bus"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Автобусы <br/>и микроавтобусы</span>
								</a>
							</li>
						</ul>
						<p class="b-big-text">Первая Лизинговая Компания готова предложить своим клиентам отличные условия лизинга машин различных марок при приобретении от одной машины до автопарка.</p>
						<div class="b-motor-transport">
							<img src="img/elements/motor_transport_big.png" class="image"/>
						</div>
						<div class="h-bottom-30">
							<p>Первая Лизинговая Компания сотрудничает с большинством крупных дилеров и официальных представителей ведущих производителей автотранспорта. Среди партнеров компании дилеры легкового и грузового автотранспорта, автосалоны, расположенные в Москве и регионах России.Поставщик автотранспорта определяется лизингополучателем самостоятельно. Мы можем помочь клиенту, предоставив информацию о продавцах, однако окончательный выбор продавца остается за лизингополучателем.</p>
						</div>
						<xsl:call-template name="conditions"/>
					</div>
				</div>
			</div>
			<div id="equipment" class="l-equipment">
				<div class="l-inner">
					<div class="b-area-title">
						<h1 class="b-title"><span class="text">Оборудование в лизинг</span></h1>
					</div>
					<div class="l-column-600">
						<ul class="b-list-equipment b-list-equipment-different">
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-food"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Оборудование <br/>для пишевой <br/>промышленности</span>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-industrial"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Промышленное <br/>оборудование</span>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-printing"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Полиграфическое <br/>оборудование</span>
								</a>
							</li>
							<li class="item">
								<a class="link">
									<xsl:attribute name="href">
										<xsl:apply-templates select="navigation/item[@key = 'partners']/item[@key = 'special']" mode="navigation-item-path"/>
									</xsl:attribute>
									<span class="area-icon">
										<b class="b-icon b-icon-trade"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
									</span>
									<span class="desc">Торговое <br/>оборудование</span>
								</a>
							</li>
						</ul>
						<p class="b-big-text">Первая Лизинговая Компания готова предложить своим клиентам отличные условия лизинга машин различных марок при приобретении от одной машины до автопарка.</p>
						<div class="b-equipment">
							<img src="img/elements/equipment_big.png" class="image"/>
						</div>
						<div class="h-bottom-30">
							<p>Первая Лизинговая Компания сотрудничает с большинством крупных дилеров и официальных представителей ведущих производителей автотранспорта. Среди партнеров компании дилеры легкового и грузового автотранспорта, автосалоны, расположенные в Москве и регионах России.Поставщик автотранспорта определяется лизингополучателем самостоятельно. Мы можем помочь клиенту, предоставив информацию о продавцах, однако окончательный выбор продавца остается за лизингополучателем.</p>
						</div>
						<xsl:call-template name="conditions"/>
					</div>
				</div>
			</div>
			<div id="request" class="l-request">
				<div class="l-inner">
					<div class="b-area-title">
						<h1 class="b-title"><span class="text">Заявка на лизинг</span></h1>
					</div>
					<div class="l-column-620">
						<div class="b-request">
							<div class="b-paper">
								<form method="post" action="index.html" id="request_form" class="b-general-form">
									<ol class="b-red-numbering">
										<li class="item-numbering">
											<div class="content">
												<h2 class="title">Расскажите о своей компании</h2>
												<ul class="b-fields">
													<li class="item">
														<div class="content-left">
															<label for="name" class="label label-left">Наименования организации</label>
															<input id="name" name="name" type="text" class="l-input-323 required"/>
														</div>
													</li>
													<li class="item">
														<div class="content-left">
															<label for="town" class="label label-left">Выш город</label>
															<select id="town" name="town" class="l-input-323">
																<option value="Тверь">Тверь</option>
																<option value="Москва">Москва</option>
																<option value="Санкт-Петербург">Санкт-Петербург</option>
																<option value="Бежецк">Бежецк</option>
																<option value="Другой">Другой</option>
															</select>
														</div>
													</li>
													<li class="item">
														<div class="content-left">
															<div class="field field-left">
																<label for="person" class="label label-left">Контактное лицо</label>
																<input id="person" name="person" type="text" class="l-input-145"/>
															</div>
															<div class="field field-right">
																<label for="phone" class="label l-label-90">Телефон</label>
																<input id="phone" name="phone" type="text" class="l-input-100"/>
															</div>
														</div>
													</li>
													<li class="item">
														<div class="content-left">
															<label for="email" class="label label-left">Электронная почта</label>
															<input id="email" name="email" type="text" class="l-input-323 required"/>
														</div>
													</li>
													<li class="item">
														<div class="content-left">
															<label for="know" class="label label-left">Откуда вы узнали о нас</label>
															<select id="know" name="know" class="l-input-323">
																<option value="Газета">Прочитали в газете</option>
																<option value="Телевизор">Увидели на телевидении</option>
																<option value="Поиск">Нашли в поисковых системах</option>
																<option value="Интернет">Случайно забрели на сайт</option>
																<option value="Другое">Другое</option>
															</select>
														</div>
													</li>
												</ul>
											</div>
										</li>
										<li class="item-numbering">
											<div class="content">
												<h2 class="title">Сведения о предмете лизинга</h2>
												<ul class="b-fields">
													<li class="item item-category">
														<div class="content-left">
															<label for="category" class="label label-left">Категория предмета лизинга</label>
															<select id="category" name="category" class="l-input-323">
																<option value="motor_transport">Автотранспорт</option>
																<option value="special">Спецтехника</option>
																<option value="equipment">Оборудование</option>
															</select>
														</div>
													</li>
													<li class="item">
														<div class="content-left">
															<div class="label-left">
																<label for="name_supplier" class="label">Общие сведения лизинга</label>
																<span class="desc">Марка, модель, год, наименование производителя, страна производителя</span>
															</div>
															<textarea id="address" class="l-input-323 required" cols="30" rows="5" name="address">
																<xsl:text><![CDATA[]]></xsl:text>
															</textarea>
														</div>
													</li>
													<li class="item item-calculation">
														<xsl:call-template name="calculator"/>
													</li>
													<li class="item">
														<div class="b-submit">
														<input type="submit" value="Подать заявку!" class="submit"/>
														</div>
													</li>
												</ul>
											</div>
										</li>
									</ol>
								</form>
								<a href="contacts.html" class="cutaway"><xsl:text><![CDATA[]]></xsl:text></a>
							</div>
							<div class="l-intercolumn-26-200">
								<p class="b-desc"><sub>*</sub> Приблизительная оценка. Фактический размер ежемесячного платежа определяется после прохождения финансовой экспертизы. Заявка не является прохожденияубличной офертой.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="b-cup">
					<i class="cup"><xsl:text><![CDATA[]]></xsl:text></i>
					<a href="http://vodka-group.ru/" class="link">
						<span class="text">Дизайн - <span class="develop">VCG</span></span>
					</a>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			<xsl:text disable-output-escaping="yes"><![CDATA[
				document.documentElement.className = 'l-theater';
				
				var loader = new PxLoader(),
					loaderModal = document.getElementById('loader-modal'),
					loaderConsole = document.getElementById('loader-console'),
					totalSize = 0,
					currentSize = 0,
					resources = [
						{
							url: '/img/backgrounds/bg_cars_1.jpg',
							size: 362
						},
						{
							url: '/img/backgrounds/sand.jpg',
							size: 1147
						},
						{
							url: '/img/backgrounds/asphalt.jpg',
							size: 987
						},
						{
							url: '/img/backgrounds/rug.jpg',
							size: 312
						},
						{
							url: '/img/backgrounds/request.jpg',
							size: 468
						}
					];
				
				for( var i = 0; i < resources.length; i++ ){
					var pxImage = new PxLoaderImage(resources[i].url);
					
					pxImage.size = resources[i].size;
					totalSize += resources[i].size;
					
					loader.add(pxImage);
				}
				
				loader.addProgressListener(function(e){
					currentSize += e.resource.size;
					loaderConsole.innerText = Math.round(currentSize / totalSize * 100) + '%';
				});
				
				loader.addCompletionListener(function(){
					loaderModal.style.display = 'none';
					document.documentElement.className = '';
				});
				
				loader.start();
			]]></xsl:text>
		</script>
	</xsl:template>
	
	<xsl:template name="service-menu-deployed">
		<ul class="b-navigation-deployed">
			<xsl:for-each select="navigation/group[@id = 'service']/item[@key != 'about']|navigation/group[@id = 'request']/item[@key != 'about']">
				<li class="item item-{@key}">
					<a class="link" href="#{@key}">
						<b class="b-icon b-icon-{@key}"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<span class="text">
							<xsl:value-of select="@name"/>
						</span>
					</a>
				</li>
				<xsl:text><![CDATA[]]></xsl:text>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template name="company-features">
		<div class="b-scroll-gallery">
			<div class="l-column-600">
				<h2 class="b-title-gallery">В своей работе мы придерживаемся<br/> семи простых правил:</h2>
			</div>
			<div class="slides">
				<div class="slide">
					<div class="content">
						<b class="b-icon b-icon-big-clock"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<h3 class="title"><span class="text">Оперативность</span></h3>
						<p class="desc">Для нас одна из самых больших ценностей — это время наших клиентов. Если сделку нужно было заключить «ещё вчера», вы пришли в правильное место!</p>
					</div>
				</div>
				<div class="slide">
					<div class="content">
						<b class="b-icon b-icon-availability"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<h3 class="title"><span class="text">Доступность</span></h3>
						<p class="desc">Работая с рядом крупных банков Твери и Тверской области, а также принимая участия в различных федеральных программах, мы обладаем возможностью предлагать нашим клиентам самые выгодные условия финансирования проектов без лишних запросов и обременений</p>
					</div>
				</div>
				<div class="slide">
					<div class="content">
						<b class="b-icon b-icon-convenience"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<h3 class="title"><span class="text">Удобство</span></h3>
						<p class="desc">Мы делаем все для комфорта наших клиентов:  до минимума сокращены перечни требующихся документов, в любое время можно получить консультацию по интересующему вопросу, предлагается ряд дополнительных услуг</p>
					</div>
				</div>
				<div class="slide">
					<div class="content">
						<b class="b-icon b-icon-big-castle"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<h3 class="title"><span class="text">Надежность</span></h3>
						<p class="desc">ООО «Первая лизинговая компания» старейшая лизинговая компания Тверского региона. Мы горды тем, что за все время нашего существования мы не подвели ни одного нашего партнера</p>
					</div>
				</div>
				<div class="slide">
					<div class="content">
						<b class="b-icon b-icon-promotion"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<h3 class="title"><span class="text">Содействие</span></h3>
						<p class="desc">Что один в поле не воин, известно давно. Мы всегда адекватно воспринимаем сложности наших клиентов и на многое готовы пойти, чтобы помочь им пережить непростые времена</p>
					</div>
				</div>
				<div class="slide">
					<div class="content">
						<b class="b-icon b-icon-competence"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<h3 class="title"><span class="text">Компетентность</span></h3>
						<p class="desc">За время нашей работы мы смогли сформировать команду с профессиональным руководством и высококвалифицированными специалистами. Сотрудники компании готовы оказать клиентам любую помощь для решения возникающих задач</p>
					</div>
				</div>
				<div class="slide">
					<div class="content">
						<b class="b-icon b-icon-leadership"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<h3 class="title"><span class="text">Лидерство</span></h3>
						<p class="desc">На Тверском рынке лизинговых услуг! Своему успеху мы, конечно же, обязаны нашим партнерам, ведь именно успешность их бизнеса сделала нас первыми</p>
					</div>
				</div>
			</div>
			<div class="common-content">
				<i class="circ">
					<xsl:text><![CDATA[]]></xsl:text>
				</i>
				<div class="navigation">
					<xsl:text><![CDATA[]]></xsl:text>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="conditions">
		<div class="b-wrapped-line">
			<h2 class="title">
				<a href="?" class="link">
					<span class="text">Базовые условия</span>
				</a>
			</h2>
			<div class="content">
				<ul class="b-conditions">
					<li class="item">
						<div class="area-icon">
							<b class="b-icon b-icon-calendar"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="desc">Срок договора лизинга от 1 до 4 лет</div>
					</li>
					<li class="item">
						<div class="area-icon">
							<b class="b-icon b-icon-graph"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="desc">Авансовый платеж от 10% от покупной стоимости имущества</div>
					</li>
					<li class="item">
						<div class="area-icon">
							<b class="b-icon b-icon-book"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="desc">Балансодержатель имущества: Лизингодатель или Лизингополучатель </div>
					</li>
					<li class="item">
						<div class="area-icon">
							<b class="b-icon b-icon-clock"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="desc">Срок рассмотрения заявки:до 3-х дней с момента</div>
					</li>
					<li class="item">
						<div class="area-icon">
							<b class="b-icon b-icon-diagram"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="desc">График платежей (по выбору клиента): убывающий, равномерный, индивидуальный</div>
					</li>
					<li class="item">
						<div class="area-icon">
							<b class="b-icon b-icon-arms"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="desc">Страхование всех рисков, связанных с предметом лизинга, на весь срок лизинга в согласованной с лизингодателем страховой компании</div>
					</li>
				</ul>
			</div>
		</div>
	</xsl:template>

</xsl:stylesheet>