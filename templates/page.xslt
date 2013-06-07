<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="common/navigation-item-path.xslt"/>
	<xsl:import href="common/utils.xslt"/>
	<xsl:import href="common/text.xslt"/>
	
	<xsl:param name="default-lang"/>
	<xsl:param name="lang"/>
	<xsl:param name="index"/>
	<xsl:param name="date-now"/>
	
	<xsl:variable name="languages" select="document('../resources/languages.xml')/languages"/>
	<xsl:variable name="txtres" select="document('../resources/txtres.xml')/txtres/resources[@lang=$lang]"/>
	<xsl:variable name="nav-item" select="/page/navigation//item[@in and not(item[@in])]"/>
	
	<xsl:template match="*"/>
	
	<xsl:template match="page">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>
]]></xsl:text>
		<html>
			<xsl:call-template name="html-head"/>
			<xsl:call-template name="html-body"/>
		</html>
	</xsl:template>
	
	<xsl:template name="html-head">
		<head>
			<meta charset="utf-8"/>
			<title>
				<xsl:call-template name="title-text"/>
			</title>
			<xsl:call-template name="include-css">
				<xsl:with-param name="name" select="'main'"/>
			</xsl:call-template>
			<xsl:comment><xsl:text disable-output-escaping="yes"><![CDATA[[if lte IE 8]><link rel="stylesheet" type="text/css" href="/css/ie8.css"/><![endif]]]></xsl:text></xsl:comment>
			<xsl:comment><xsl:text disable-output-escaping="yes"><![CDATA[[if lte IE 7]><link rel="stylesheet" type="text/css" href="/css/ie7.css"/><![endif]]]></xsl:text></xsl:comment>
			<xsl:call-template name="css-includes"/>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'jquery-1.8.3.min'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'jquery-ui-1.9.2.custom.min'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'jquery.cookie.min'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'scrollGallery'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'jquery.validate'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'modal'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'tabs'"/>
			</xsl:call-template>
			<xsl:call-template name="script-includes"/>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'main'"/>
			</xsl:call-template>
			<!--
			<link href="/favicon.ico" rel="shortcut icon"/>
			-->
		</head>
	</xsl:template>
	
	<xsl:template name="title-text">
		<xsl:choose>
			<xsl:when test="string-length(/page/static-text/title/text()) != 0">
				<xsl:apply-templates select="/page/static-text/title/* | /page/static-text/title/text()"/>
				<xsl:text> — </xsl:text>
			</xsl:when>
			<xsl:when test="string-length(/page/navigation//item[@hit]/@name) != 0">
				<xsl:value-of select="/page/navigation//item[@hit]/@name"/>
				<xsl:text> — </xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:value-of select="$txtres/title"/>
	</xsl:template>
	
	<xsl:template name="css-includes"/>
	<xsl:template name="script-includes"/>
	
	<xsl:template name="html-body">
		<body class="l-main-section">
			<div class="l-header">
				<xsl:call-template name="header"/>
			</div>
			<div class="l-content">
				<div class="l-column-600 l-inner-20">
					<xsl:call-template name="content"/>
				</div>
			</div>
			<div class="l-footer">
				<xsl:call-template name="footer"/>
			</div>
		</body>
	</xsl:template>
	
	<xsl:template name="header">
		<xsl:call-template name="main-menu"/>
		<ul class="b-switch-phone">
			<li class="item">
				<a href="#tver" class="link selected">
					<span class="text">Тверь</span>
					<span class="phone">
						<xsl:value-of select="$txtres/phones/tver/text()"/>
					</span>
				</a>
			</li>
			<li class="item">
				<a href="#moscow" class="link">
					<span class="text">Москва</span>
					<span class="phone">
						<xsl:value-of select="$txtres/phones/moscow/text()"/>
					</span>
				</a>
			</li>
			<li class="item item-phones">
				<xsl:text><![CDATA[]]></xsl:text>
			</li>
		</ul>
		<div class="b-right-text">
			<a href="#calculation" class="js-modal">Лизинговый калькулятор</a>
		</div>
		<div id="calculation" class="b-modal-content">
			<div class="l-column-620">
				<div class="b-modal-calculation">
					<h2 class="title-main">Лизинговый калькулятор</h2>
					<div class="content">
						<i class="t-zigzag"><xsl:text><![CDATA[]]></xsl:text></i>
						<i class="b-zigzag"><xsl:text><![CDATA[]]></xsl:text></i>
						<form class="b-general-form">
							<div class="content-left">
								<label for="category" class="label label-left">Категория предмета лизинга</label>
								<xsl:if test="not($index)">
									<select id="category" name="category" class="l-input-323">
										<option value="motor_transport">Автотранспорт</option>
										<option value="special">Спецтехника</option>
										<option value="equipment">Оборудование</option>
									</select>
								</xsl:if>
							</div>
							<xsl:if test="not($index)">
								<xsl:call-template name="calculator"/>
							</xsl:if>
						</form>
					</div>
					<div class="submit">
						<a class="link link-reload">
							<xsl:attribute name="href">
								<xsl:apply-templates select="navigation/item[not(@key)]" mode="navigation-item-path"/>
								<xsl:text>#request</xsl:text>
							</xsl:attribute>
							<span class="text">Перейти к оформлению заявки</span>
						</a>
					</div>
					<a class="b-close-modal">
						<span class="text">Закрыть</span>
					</a>
				</div>
			</div>
		</div>
		<div class="l-column-1000">
			<xsl:call-template name="logo"/>
			<xsl:call-template name="service-menu"/>
		</div>
	</xsl:template>
	
	<xsl:template name="logo">
		<div class="b-mini-logo">
			<a href="/" class="link">
				<xsl:if test="$index">
					<xsl:attribute name="href">#about</xsl:attribute>
				</xsl:if>
				<span class="text">
					<xsl:value-of select="$txtres/title/text()"/>
				</span>
			</a>
		</div>
	</xsl:template>
	
	<xsl:template name="main-menu">
		<ul class="b-main-menu">
			<xsl:for-each select="navigation/item[@key]">
				<li class="item">
					<a>
						<xsl:attribute name="class">
							<xsl:text>link</xsl:text>
							<xsl:if test="@in"> selected</xsl:if>
							<xsl:if test="@hit"> hit</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="href">
							<xsl:call-template name="navigation-item-path"/>
						</xsl:attribute>
						<span class="text">
							<xsl:value-of select="@name"/>
						</span>
					</a>
				</li>
				<xsl:text><![CDATA[]]></xsl:text>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template name="service-menu">
		<ul class="b-main-navigation">
			<xsl:for-each select="navigation/group[@id = 'service']/item">
				<li class="item item-{@key}">
					<a class="link" href="/#{@key}">
						<xsl:choose>
							<xsl:when test="@scroll-key">
								<xsl:attribute name="href">
									<xsl:choose>
										<xsl:when test="$index">
											<xsl:text>#</xsl:text>
											<xsl:value-of select="@key"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>/#</xsl:text>
											<xsl:value-of select="@scroll-key"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$index">
									<xsl:attribute name="href">
										<xsl:text>#</xsl:text>
										<xsl:value-of select="@key"/>
									</xsl:attribute>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
						<span class="area-icon">
							<b class="b-icon b-icon-{@key}-n"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						</span>
						<span class="text">
							<xsl:value-of select="@name"/>
						</span>
						<i class="line">
							<xsl:text><![CDATA[]]></xsl:text>
						</i>
						<xsl:if test="position() = last()">
							<i class="decor">
								<xsl:text><![CDATA[]]></xsl:text>
							</i>
						</xsl:if>
					</a>
				</li>
			</xsl:for-each>
			<xsl:for-each select="navigation/group[@id = 'request']/item">
				<li class="item-{@key}">
					<a class="link" href="/#{@key}">
						<xsl:if test="$index">
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text>
								<xsl:value-of select="@key"/>
							</xsl:attribute>
						</xsl:if>
						<b class="b-icon b-icon-{@key}-n"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
						<span class="text">
							<xsl:value-of select="@name"/>
						</span>
						<i class="circ">
							<xsl:text><![CDATA[]]></xsl:text>
						</i>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template name="content">
		<xsl:apply-templates select="/page/*"/>
		<xsl:text><![CDATA[]]></xsl:text>
	</xsl:template>
	
	<xsl:template name="footer">
		<xsl:choose>
			<xsl:when test="navigation/item[@in]">
				<div class="b-signpost">
					<xsl:apply-templates select="navigation/item[@in]/preceding-sibling::item[1]" mode="sibling-page">
						<xsl:with-param name="preceding" select="true()"/>
					</xsl:apply-templates>
					<xsl:apply-templates select="navigation/item[@in]/following-sibling::item[1]" mode="sibling-page">
						<xsl:with-param name="preceding" select="false()"/>
					</xsl:apply-templates>
					<xsl:if test="navigation/item[@in and position() = last()]">
						<xsl:apply-templates select="navigation/item[not(@key)]" mode="sibling-page">
							<xsl:with-param name="preceding" select="false()"/>
						</xsl:apply-templates>
					</xsl:if>
					<i class="signpost">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
				</div>
			</xsl:when>
			<xsl:when test="navigation//item[@in]">
				<div class="b-signpost">
					<xsl:apply-templates select="navigation/item[not(@key)]" mode="sibling-page">
						<xsl:with-param name="preceding" select="true()"/>
					</xsl:apply-templates>
					<xsl:apply-templates select="navigation/item[@key = 'contacts']" mode="sibling-page">
						<xsl:with-param name="preceding" select="false()"/>
					</xsl:apply-templates>
					<i class="signpost">
						<xsl:text><![CDATA[]]></xsl:text>
					</i>
				</div>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="item" mode="sibling-page">
		<xsl:param name="preceding" select="true()"/>
		<a class="link link-l">
			<xsl:if test="not($preceding)">
				<xsl:attribute name="class">link link-r</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:call-template name="navigation-item-path"/>
			</xsl:attribute>
			<span class="arrow">
				<span class="text">
					<xsl:value-of select="@long-name" disable-output-escaping="yes"/>
				</span>
			</span>
		</a>
	</xsl:template>
	
	<xsl:template name="sub-menu">
		<ul class="b-tabs-docs">
			<xsl:apply-templates select="/page/navigation/item[@in]/item" mode="sub-menu"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="item" mode="sub-menu">
		<li class="item">
			<a class="link">
				<xsl:attribute name="href">
					<xsl:call-template name="navigation-item-path"/>
				</xsl:attribute>
				<xsl:if test="@in">
					<xsl:attribute name="class">link selected</xsl:attribute>
				</xsl:if>
				<span class="text">
					<xsl:value-of select="@name"/>
				</span>
			</a>
		</li>
	</xsl:template>
	
	<xsl:template name="calculator">
		<div class="b-calculation-cost">
			<!--div class="content-left">
				<h3 class="title label-left">Валюта</h3>
				<ul class="currencies">
					<li class="item">
						<a class="link selected">
							<span class="text text-rub">РУБ</span>
							<xsl:text><![CDATA[]]></xsl:text>
						</a>
					</li>
					<li class="item">
						<a class="link">
							<span class="text text-usd">USD</span>
							<xsl:text><![CDATA[]]></xsl:text>
						</a>
					</li>
					<li class="item">
						<a class="link">
							<span class="text text-euro">EUR</span>
							<xsl:text><![CDATA[]]></xsl:text>
						</a>
					</li>
					<xsl:text><![CDATA[]]></xsl:text>
				</ul>
			</div-->
			<div class="field-currencies content-left">
				<label for="cost" class="label label-left">Общая стоимость</label>
				<div class="b-movement">
					<ul class="category">
						<li class="item">
							<span class="number">100&#160;000</span>
							<xsl:text> </xsl:text>
							<span class="currency">р</span>
						</li>
						<li class="item">
							<span class="number">5&#160;000&#160;000</span>
							<xsl:text> </xsl:text>
							<span class="currency">р</span>
						</li>
						<li class="item">
							<span class="number">10&#160;000&#160;000</span>
							<xsl:text> </xsl:text>
							<span class="currency">р</span>
						</li>
						<xsl:text><![CDATA[]]></xsl:text>
					</ul>
					<div class="movement">
						<xsl:text><![CDATA[]]></xsl:text>
					</div>
				</div>
				<div class="b-field-sign">
					<input id="cost" name="cost" type="text" class="input required input-slider"/>
					<span class="sign">р</span>
				</div>
			</div>
			<div class="field-advance content-left">
				<label for="advance" class="label label-left">Авансовый платеж</label>
				<div class="b-movement">
					<ul class="category">
						<li class="item">10%</li>
						<li class="item">25%</li>
						<li class="item">49%</li>
						<xsl:text><![CDATA[]]></xsl:text>
					</ul>
					<div class="movement">
						<xsl:text><![CDATA[]]></xsl:text>
					</div>
				</div>
				<div class="b-field-sign">
					<input id="advance" name="advance" type="text" class="input required input-slider"/>
					<span class="sign">%</span>
				</div>
			</div>
			<div class="field-years content-left">
				<label for="years" class="label label-left">Срок</label>
				<div class="b-movement">
					<ul class="category">
						<li class="item">12 мес.</li>
						<li class="item">24 мес.</li>
						<li class="item">36 мес.</li>
						<li class="item">48 мес.</li>
						<xsl:text><![CDATA[]]></xsl:text>
					</ul>
					<div class="movement">
						<xsl:text><![CDATA[]]></xsl:text>
					</div>
				</div>
				<div class="b-field-sign">
					<input id="years" name="years" type="text" class="input required input-slider"/>
					<span class="sign">мес.</span>
				</div>
			</div>
			<div class="b-calculation">
				<div class="calc calc-month">Размер ежемесячного платежа: <span class="number">208 573</span> <span class="currency">р</span>*</div>
				<div class="calc calc-total">Общая сумма платежей: <span class="number">208 573</span> <span class="currency">р</span>*</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="breadcrumbs-title">
		<xsl:param name="title"/>
		<ul class="b-breadcrumbs">
			<li class="item">
				<a class="link-back">
					<xsl:attribute name="href">
						<xsl:apply-templates select="navigation/item[not(@key)]" mode="navigation-item-path"/>
						<xsl:text>#about-title</xsl:text>
					</xsl:attribute>
					<b class="b-icon b-icon-back"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
				</a>
			</li>
			<li class="item">
				<h1 class="title">
					<xsl:value-of select="$title"/>
				</h1>
			</li>
		</ul>
	</xsl:template>

</xsl:stylesheet>