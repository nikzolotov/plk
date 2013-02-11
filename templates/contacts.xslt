<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>
	
	<xsl:template name="script-includes">
		<xsl:call-template name="include-script">
			<xsl:with-param name="url">
				<xsl:text>http://api-maps.yandex.ru/1.1/index.xml?key=</xsl:text>
				<xsl:value-of select="$maps-key"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="include-script">
			<xsl:with-param name="name" select="'contacts'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="content">
		<div class="h-shift-27p h-column-28p">
			<xsl:apply-templates select="static-text/title"/>
		</div>
		<div class="l-wrapper">
			<div class="l-column-18p h-shift-6p h-column-3p">
				<xsl:call-template name="sub-menu"/>
			</div>
			<div class="l-column-45p">
				<xsl:apply-templates select="static-text/text"/>
				<div id="map" class="b-map b-map-highlighted">
					<xsl:text><![CDATA[]]></xsl:text>
				</div>
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>