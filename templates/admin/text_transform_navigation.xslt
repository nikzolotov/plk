﻿<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="*" />

	<xsl:template match="navigation">
		<navigation>
			<xsl:apply-templates select="item[@key and not(@module)]"/>
		</navigation>
	</xsl:template>
	
	<xsl:template match="group[not(@module)]">
		<xsl:apply-templates select="item[not(@module)]"/>
	</xsl:template>

	<xsl:template match="item">
		<item>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="item[not(@module)]"/>
		</item>
	</xsl:template>

</xsl:stylesheet>