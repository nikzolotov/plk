<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="*"/>

	<xsl:template match="page">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	
	<xsl:template match="success">
		<div class="b-answer-request">
			<div class="b-thelargest-text">
				<p>
					<xsl:value-of select="title/text()"/>
				</p>
			</div>
			<i class="b-letter"><xsl:text><![CDATA[]]></xsl:text></i>
			<div class="b-text-icon">
				<b class="b-icon b-icon-big-book"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
				<p>
					<xsl:copy-of select="desc/text() | desc/*"/>
				</p>
			</div>
			<a class="b-cutaway-2-link" href="contacts.html"><xsl:text><![CDATA[]]></xsl:text></a>
			<i class="b-cutaway-2"><xsl:text><![CDATA[]]></xsl:text></i>
		</div>
	</xsl:template>
	
	<xsl:template match="error">
		<div class="b-answer-request">
			<div class="b-thelargest-text">
				<p>
					<xsl:value-of select="title/text()"/>
				</p>
			</div>
			<a id="request-close" href="?">Назад</a>
		</div>
	</xsl:template>
	
</xsl:stylesheet>