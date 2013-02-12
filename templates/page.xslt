<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="common/navigation-item-path.xslt"/>
	<xsl:import href="common/utils.xslt"/>
	<xsl:import href="common/text.xslt"/>
	
	<xsl:param name="default-lang"/>
	<xsl:param name="lang"/>
	<xsl:param name="index"/>
	<xsl:param name="date-now"/>
	<xsl:param name="maps-key"/>
	
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
			<xsl:comment><xsl:text disable-output-escaping="yes"><![CDATA[[if lte IE 7]><link rel="stylesheet" type="text/css" href="/css/ie7.css"/><![endif]]]></xsl:text></xsl:comment>
			<xsl:call-template name="css-includes"/>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'jquery-1.8.3.min'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'history'"/>
			</xsl:call-template>
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'main'"/>
			</xsl:call-template>
			<xsl:call-template name="script-includes"/>
			<!--
			<link href="/favicon.ico" rel="shortcut icon"/>
			-->
		</head>
	</xsl:template>
	
	<xsl:template name="title-text">
		<xsl:value-of select="$txtres/title"/>
		<xsl:choose>
			<xsl:when test="string-length(/page/static-text/title/text()) != 0">
				<xsl:text> — </xsl:text>
				<xsl:apply-templates select="/page/static-text/title/* | /page/static-text/title/text()"/>
			</xsl:when>
			<xsl:when test="string-length(/page/navigation//item[@hit]/@name) != 0">
				<xsl:text> — </xsl:text>
				<xsl:value-of select="/page/navigation//item[@hit]/@name"/>
			</xsl:when>
		</xsl:choose>
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
		<div class="l-column-1000">
			<xsl:call-template name="main-menu"/>
			<div class="b-left-text">
				<xsl:value-of select="$txtres/phones/main/text()"/>
			</div>
			<div class="b-right-text">
				<a href="?1">Обратная связь</a>
			</div>
			<xsl:if test="not($index)">
				<xsl:call-template name="logo"/>
				<xsl:call-template name="service-menu"/>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xsl:template name="logo">
		<div class="b-mini-logo">
			<a href="/" class="link">
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
						<xsl:if test="$index">
							<xsl:attribute name="href">
								<xsl:text>#</xsl:text>
								<xsl:value-of select="@key"/>
							</xsl:attribute>
						</xsl:if>
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
		<xsl:if test="navigation/item[@in]">
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
		</xsl:if>
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

</xsl:stylesheet>