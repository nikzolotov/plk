<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>
	
	<xsl:template name="script-includes">
		<xsl:call-template name="include-script">
			<xsl:with-param name="url">http://api-maps.yandex.ru/2.0/?load=package.standard&amp;mode=debug&amp;lang=ru-RU</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="include-script">
			<xsl:with-param name="name" select="'map'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="content">
		<xsl:apply-templates select="static-text/title"/>
		<xsl:apply-templates select="static-text/text"/>
		<div class="b-yandex-map">
			<div class="inner">
				<h3 class="title">Схема проезда</h3>
				<div id="YMapsID">
					<xsl:text><![CDATA[]]></xsl:text>
				</div>
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>