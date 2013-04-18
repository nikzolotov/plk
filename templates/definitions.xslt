<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="definitions">
		<h1>Глоссарий</h1>
		<xsl:call-template name="sub-menu"/>
		<ul id="glossary" class="b-definitions">
			<xsl:apply-templates select="article" mode="definitions"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="article" mode="definitions">
		<li class="item">
			<span class="word">
				<xsl:value-of select="title/text()"/>
			</span>
			<xsl:text>&#160;&#8212; </xsl:text>
			<xsl:value-of select="body"/>
		</li>
	</xsl:template>
	
</xsl:stylesheet>