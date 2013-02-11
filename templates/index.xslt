﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="html-body">
		<div class="l-page">
			<div id="main_section" class="l-main-section">
				<div class="l-header">
					<xsl:call-template name="header"/>
				</div>
				<div class="l-content">
					<div class="b-logo">
						<h1 class="title"> Первая лизинговая компания</h1>
						<div class="summary">Первая лизинговая компания — универсальная лизинговая компания, созданная 29 октября 2001 года. Наша компания являлась и является 100% Тверской компанией, и мы, как никто другой, хорошо знакомы со спецификой бизнеса нашего региона.</div>
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
			</div>
			<div id="external_content" class="l-external-content">
				<div class="l-column-1000">
					<div class="b-mini-logo">
						<a href="index.html" class="link">
							<span class="text">Первая лизинговая компания</span>
						</a>
					</div>
					<xsl:call-template name="service-menu"/>
				</div>
			</div>
			<div id="about" class="l-about-company">
				<div class="l-inner">
					<div class="l-column-600">
						<h1>Мы — Первая лизинговая компания</h1>
						<p class="b-big-line-height">В числе наших клиентов многие крупнейшие предприятия города Твери и Тверской области. В настоящий момент заключено более 1 500 договоров финансового лизинга с более чем 800 лизингополучателями. Численность персонала компании — 14 человек. В 2007 году было открыто представительство в г. Москва. Первая Лизинговая Компания имеет партнерские отношения с универсальнаядом крупнейших банков Тверского региона.</p>
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
						<div class="b-zigzag-text">
							<a class="link" href="?1">
								<b class="b-icon b-icon-square"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								<span class="text">Каталог <br/>лизинговых компаний</span>
							</a>
							<i class="zigzag-top">
								<xsl:text><![CDATA[]]></xsl:text>
							</i>
							<i class="zigzag-bottom">
								<xsl:text><![CDATA[]]></xsl:text>
							</i>
						</div>
					</div>
				</div>
				<div class="b-gallery">
					<h2 class="title">В своей работе мы придерживаемся <br/>семи простых правил</h2>
					<div class="area-gallery">
						<ul class="navigation">
							<li class="item item-efficiency">
								<a href="#efficiency" class="link link-active">Оперативность</a>
							</li>
							<li class="item item-availability">
								<a href="#availability" class="link">Доступность</a>
							</li>
							<li class="item item-convenience">
								<a href="#convenience" class="link">Удобство</a>
							</li>
							<li class="item item-promotion">
								<a href="#promotion" class="link">Содействие</a>
							</li>
							<li class="item item-competence">
								<a href="#competence" class="link">Компентентность</a>
							</li>
							<li class="item item-leadership">
								<a href="#leadership" class="link">Лидерство</a>
							</li>
							<li class="item item-reliability">
								<a href="#reliability" class="link">Надежность</a>
							</li>
						</ul>
						<ul class="icons">
							 <li class="item item-efficiency">
								<b class="icon icon-efficiency"><xsl:text><![CDATA[]]></xsl:text></b>
							</li>
							<li class="item item-availability">
								<b class="icon icon-availability"><xsl:text><![CDATA[]]></xsl:text></b>
							</li>
							<li class="item item-convenience">
								<b class="icon icon-convenience"><xsl:text><![CDATA[]]></xsl:text></b>
							</li>
							<li class="item item-promotion">
								<b class="icon icon-promotion"><xsl:text><![CDATA[]]></xsl:text></b>
							</li>
							<li class="item item-competence">
								<b class="icon icon-competence"><xsl:text><![CDATA[]]></xsl:text></b>
							</li>
							<li class="item item-leadership">
								<b class="icon icon-leadership"><xsl:text><![CDATA[]]></xsl:text></b>
							</li>
							<li class="item item-reliability">
								<b class="icon icon-reliability"><xsl:text><![CDATA[]]></xsl:text></b>
							</li>
						</ul>
						<ul class="content">
							<li class="item item-efficiency">
								<h3 class="title">Оперативность</h3>
								<p class="text">1. Одна из самых больших ценностей для нас — ваше время.  Если сделку нужно было заключить «еще вчера», вы пришли в правильное место!</p>
							</li>
							<li class="item item-availability">
								<h3 class="title">Доступность</h3>
								<p class="text">2. Одна из самых больших ценностей для нас — ваше время.  Если сделку нужно было заключить «еще вчера», вы пришли в правильное место!</p>
							</li>
							<li class="item item-convenience">
								<h3 class="title">Удобство</h3>
								<p class="text">3. Одна из самых больших ценностей для нас — ваше время.  Если сделку нужно было заключить «еще вчера», вы пришли в правильное место!</p>
							</li>
							<li class="item item-promotion">
								<h3 class="title">Содействие</h3>
								<p class="text">4. Одна из самых больших ценностей для нас — ваше время.  Если сделку нужно было заключить «еще вчера», вы пришли в правильное место!</p>
							</li>
							<li class="item item-competence">
								<h3 class="title">Компентентность</h3>
								<p class="text">5. Одна из самых больших ценностей для нас — ваше время.  Если сделку нужно было заключить «еще вчера», вы пришли в правильное место!</p>
							</li>
							<li class="item item-leadership">
								<h3 class="title">Лидерство</h3>
								<p class="text">6. Одна из самых больших ценностей для нас — ваше время.  Если сделку нужно было заключить «еще вчера», вы пришли в правильное место!</p>
							</li>
							<li class="item item-reliability">
								<h3 class="title">Надежность</h3>
								<p class="text">7. Одна из самых больших ценностей для нас — ваше время.  Если сделку нужно было заключить «еще вчера», вы пришли в правильное место!</p>
							</li>
						</ul>
					</div>
				</div>
				<div class="b-transition">
					<i class="zigzag">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
					<div class="area-icon">
						<b class="b-icon b-icon-special-technics-n"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
					</div>
					<div class="text">Спецтехника</div>
					<i class="decor">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
				</div>
			</div>
			<div id="special-technics" class="l-special-achinery">
				<div class="l-inner">
					<div class="l-column-600">
						<h1>Спецтехника в лизинге</h1>
						<ul class="b-list-equipment">
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-lift-truck"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Автопогрузчики</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-excavator"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Экскаваторы <br/>и бульдозеры</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-tractor"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Сельскохозяйственная <br/>техника</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-machinery"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Дорожно-строительная <br/> техника</div>
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
				<div class="b-transition">
					<i class="zigzag">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
					<div class="area-icon">
						<b class="b-icon b-icon-motor-vehicles-n"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
					</div>
					<div class="text">Автотранспорт</div>
					<i class="decor">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
				</div>
			</div>
			<div id="motor-vehicles" class="l-motor-transport">
				<div class="l-inner">
					<div class="l-column-600">
						<h1>Автотранспорт в лизинг</h1>
						<ul class="b-list-equipment b-list-transport">
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-passenger"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Легковой <br/>автотранспорт</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-commercial"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Коммерческий <br/>автотранспорт</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-cargo"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Грузовой <br/>автотранспорт</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-bus"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Австобусы <br/>и микроавтобусы</div>
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
				<div class="b-transition">
					<i class="zigzag">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
					<div class="area-icon">
						<b class="b-icon b-icon-equipment-n"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
					</div>
					<div class="text">Оборудование</div>
					<i class="decor">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
				</div>
			</div>
			<div id="equipment" class="l-equipment">
				<div class="l-inner">
					<div class="l-column-600">
						<h1>Оборудование в лизинг</h1>
						<ul class="b-list-equipment b-list-equipment-different">
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-food"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Оборудование <br/>для пишевой <br/>промышленности</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-industrial"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Промышленное <br/>оборудование</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-printing"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Полиграфическое <br/>оборудование</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-trade"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Торговое <br/>оборудование</div>
							</li>
							<li class="item">
								<div class="area-icon">
									<b class="b-icon b-icon-railways"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								</div>
								<div class="desc">Подвижный <br/>состав РЖД</div>
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
				<div class="b-transition">
					<i class="zigzag">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
					<div class="request">
						<div class="area-icon">
							<b class="b-icon b-icon-request-n"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="text">Заявка на лизинг</div>
					</div>
					<i class="decor">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
				</div>          
			</div>
			<div id="request" class="l-request">
				<div class="l-inner">
					<div class="l-column-600">
						<h1>Заявка на лизинг</h1>
						<div class="b-request">
							<div class="b-paper">
								<form method="post" action="index.html#request" class="b-general-form">
									<ol class="b-red-numbering">
										<li class="item-numbering">
											<div class="content">
												<h2 class="title">Расскажите о своей компании</h2>
												<ul class="b-fields">
													<li class="item">
														<div class="field">
															<label for="name" class="label l-label-190">Наименования организации</label>
															<input id="name" name="name" type="text" class="l-input-323"/>
														</div>
													</li>
													<li class="item">
														<div class="field field-left">
															<label for="career" class="label l-label-190">Род деятельности</label>
															<input id="career" name="career" type="text" class="l-input-165"/>
														</div>
														<div class="field field-right">
															<label for="personnel" class="label l-label-90">Персонал, чел.</label>
															<input id="personnel" name="personnel" type="text" class="l-input-43"/>
														</div>
													</li>
													<li class="item">
														<div class="field">
															<label for="phone" class="label l-label-190">Контактное лицо, телефон</label>
															<input id="phone" name="phone" type="text" class="input l-input-323"/>
														</div>
													</li>
													<li class="item">
														<h3 class="title l-label-190">Реквизиты</h3>
														<div class="field field-gray">
															<label for="tin" class="label-1">ИНН</label>
															<input id="tin" name="tin" type="text" class="l-input-98"/>
														</div>
														<div class="field field-gray">
															<label for="ncoea" class="label">ОКВЭД</label>
															<input id="ncoea" name="ncoea" type="text" class="l-input-56"/>
														</div>
														<div class="field field-gray">
															<label for="ncoeо" class="label">ОКПО</label>
															<input id="ncoeо" name="ncoeо" type="text" class="l-input-56"/>
														</div>
													</li>
													<li class="item">
														<div class="field">
															<label for="know" class="label l-label-190">Откуда вы узнали о нас</label>
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
												<h2 class="title">Сведения о поставщике</h2>
												<ul class="b-fields">
													<li class="item">
														<div class="field">
															<label for="name_supplier" class="label l-label-190">Наименование</label>
															<input id="name_supplier" name="name_supplier" type="text" class="input l-input-323"/>
														</div>
													</li>
													<li class="item">
														<div class="field">
															<label for="address" class="label l-label-190">Адрес</label>
															<input id="address" name="address" type="text" class="input l-input-323"/>
														</div>
													</li>
													<li class="item">
														<div class="field">
															<label for="contact_name" class="label l-label-190">Контактное лицо</label>
															<input id="contact_name" name="contact_name" type="text" class="input l-input-323"/>
														</div>
													</li>
												</ul>
											</div>
										</li>
										<li class="item-numbering">
											<div class="content">
												<h2 class="title">Сведения о предмете лизинга</h2>
												<ul class="b-fields">
													<li class="item">
														<div class="field">
															<label for="category" class="label l-label-190">Категория предмета лизинга</label>
															<select id="category" name="category" class="l-input-323">
																<option value="Спецтехника">Спецтехника</option>
																<option value="Автотранспорт">Автотранспорт</option>
																<option value="Оборудование">Оборудование</option>
															</select>
														</div>
													</li>
													<li class="item">
														<div class="field">
															<div class="l-label-190">
																<label for="name_supplier" class="label">Общие сведения лизинга</label>
																<span class="desc">Марка, модель, год, наименование производителя, страна производителя</span>
															</div>
															<textarea id="address" class="l-input-323" cols="30" rows="5" name="address"><xsl:text><![CDATA[]]></xsl:text></textarea>
														</div>
													</li>
													<li class="item">
														<div class="b-calculation-cost">
															<div class="field">
																<h3 class="title l-label-190">Валюта</h3>
																<ul class="currencies">
																	<li class="item">
																		<a class="link link-rub"><span class="text">РУБ</span></a>
																	</li>
																	<li class="item">
																		<a class="link link-usd"><span class="text">USD</span></a>
																	</li>
																	<li class="item">
																		<a class="link link-eur"><span class="text">EUR</span></a>
																	</li>
																</ul>
															</div>
															<div class="field">
																<label for="cost" class="label l-label-190">Общая стоимость</label>
																<div class="b-movement b-movement-currencies">
																	<ul class="category">
																		<li class="item">
																			100 000 <span class="currency">$</span>
																		</li>
																		<li class="item">
																			500 000 <span class="currency">$</span>
																		</li>
																		<li class="item">
																			1 000 000 <span class="currency">$</span>
																		</li>
																		<li class="item">
																			10 000 000 <span class="currency">$</span>
																		</li>
																	</ul>
																	<div class="movement">
																		<div class="fulled">
																			<a href="?" class="circ"></a>
																		</div>
																	</div>
																</div>
																<div class="b-field-sign">
																	<input id="cost" name="cost" type="text" class="input l-input-66"/>
																	<span class="sign">$</span>
																</div>
															</div>
															<div class="field">
																<label for="advance" class="label l-label-190">Авансовый платеж, %</label>
																<div class="b-movement b-movement-advance">
																	<ul class="category">
																		<li class="item">0%</li><li class="item">50%</li><li class="item">100%</li>
																	</ul>
																	<div class="movement">
																		<div class="fulled">
																			<a href="?" class="circ"><xsl:text><![CDATA[]]></xsl:text></a>
																		</div>
																	</div>
																</div>
																<input id="advance" name="advance" type="text" class="input l-input-66"/>
															</div>
															<div class="field">
																<label for="years" class="label l-label-190">Срок, лет</label>
																<div class="b-movement b-movement-years">
																	<ul class="category">
																		<li class="item">
																			1 год
																		</li>
																		<li class="item">
																			2 года
																		</li>
																		<li class="item">
																			3 года
																		</li>
																		<li class="item">
																			4 года
																		</li>
																	</ul>
																	<div class="movement">
																		<div class="fulled">
																			<a href="?" class="circ"><xsl:text><![CDATA[]]></xsl:text></a>
																		</div>
																	</div>
																</div>
																<input id="years" name="years" type="text" class="input l-input-66"/>
															</div>
															<div class="b-calculation">
																Размер ежемесячного платежа: <span class="number">208 573 — 195 357 Р*</span>
															</div>
														</div>
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
								<i class="cutaway">
									<xsl:text><![CDATA[]]></xsl:text>
								</i>
							</div>
							<div class="l-intercolumn-26-200">
								<p class="b-desc"><sub>*</sub> Приблизительная оценка. Фактический размер ежемесячного платежа определяется после прохождения финансовой экспертизы. Заявка не является прохожденияубличной офертой.</p>
							</div>
						</div>
						<div class="b-answer-request">
							<div class="b-thelargest-text">
								<p>Ваша заявка на лизинг успешно отправлена. Спасибо! Мы свяжемся с вами <br/>в самое ближайшее время.</p>
							</div>
							<i class="b-letter">
								<xsl:text><![CDATA[]]></xsl:text>
							</i>
							<div class="b-text-icon">
								<b class="b-icon b-icon-big-book"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
								<p>Пока мы обрабатываем вашу заявку, самое время ознакомиться с документами, необходимыми для заключения договора лизинга.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="b-cup">
					<i class="cup">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
					<i class="cutaway-2">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
				</div>
			</div>
		</div>
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
	
	<xsl:template name="conditions">
		<div class="b-wrapped-line">
			<h2 class="title">Базовые условия</h2>
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
					<li class="item">
						<div class="area-icon">
							<b class="b-icon b-icon-turnover"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</div>
						<div class="desc">Обеспечение сделки предмет лизинга</div>
					</li>
				</ul>
			</div>
		</div>
	</xsl:template>

</xsl:stylesheet>