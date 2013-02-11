<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="*"/>

	<xsl:template match="page">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	
	<xsl:template match="success">
		<div class="b-message">
			<p class="title">
				<xsl:value-of select="title/text()"/>
			</p>
			<a id="feedback-close" class="link" href="?">Закрыть окно</a>
		</div>
	</xsl:template>
	
	<xsl:template match="error">
		<div class="b-message">
			<p class="title">
				<xsl:value-of select="title/text()"/>
			</p>
			<a id="feedback-back" class="link" href="?">Назад</a>
		</div>
	</xsl:template>
	
</xsl:stylesheet>