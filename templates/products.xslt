<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:decimal-format name="price" decimal-separator="," grouping-separator=" " />

	<xsl:template name="content">
		<xsl:call-template name="breadcrumbs-title">
			<xsl:with-param name="title" select="static-text/title"/>
		</xsl:call-template>
		<xsl:apply-templates select="static-text/text" mode="text"/>
		<xsl:if test="products/product">
			<ul class="b-objects b-objects-sale">
				<xsl:apply-templates select="products/product"/>
			</ul>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="product">
		<li class="item">
			<xsl:if test="normalize-space(photo)">
				<img src="/img/products/{@id}_128.{photo/text()}" class="image" alt="{title/text()}"/>
			</xsl:if>
			<xsl:if test="normalize-space(title)">
				<h3 class="title">
					<xsl:value-of select="title/text()"/>
				</h3>
			</xsl:if>
			<xsl:if test="normalize-space(desc)">
				<div class="summary">
					<xsl:apply-templates select="desc" mode="text"/>
				</div>
			</xsl:if>
			<div class="price">
				<xsl:variable name="price" select="@price"/>
				<xsl:value-of select="format-number($price, '### ### ###', 'price')"/>
				<xsl:text>&#160;Р.</xsl:text>
			</div>
		</li>
	</xsl:template>
	
</xsl:stylesheet>