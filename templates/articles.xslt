<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="common/text.xslt"/>
	
	<xsl:template match="articles">
		<h1>Статьи</h1>
		<xsl:call-template name="sub-menu"/>
		<div id="articles" class="b-bottom-design">
			<ul class="b-without-design">
				<xsl:apply-templates select="article" mode="articles"/>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="article" mode="articles">
		<li class="item">
			<h3 class="title">
				<a>
					<xsl:attribute name="href">
						<xsl:apply-templates select="/page/navigation/item[@key = 'customers']/item[@key = 'articles']" mode="navigation-item-path"/>
						<xsl:value-of select="@id"/>
						<xsl:text>.html</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="title/text()"/>
				</a>
			</h3>
			<p>
				<xsl:value-of select="lead"/>
			</p>
		</li>
	</xsl:template>
	
	<xsl:template match="article">
		<h1>
			<xsl:value-of select="title/text()"/>
		</h1>
		<xsl:choose>
			<xsl:when test="not(body/*)">
				<p>
					<xsl:apply-templates select="body/text()" mode="text"/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="body/*|body/text()" mode="text"/>
			</xsl:otherwise>
		</xsl:choose>
		<p>
			<strong>
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date"/>
				</xsl:call-template>
			</strong>
		</p>
	</xsl:template>
	
</xsl:stylesheet>