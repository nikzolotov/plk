<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>

	<xsl:template name="content">
		<xsl:apply-templates select="static-text/title"/>
		<xsl:apply-templates select="static-text/text"/>
		<ul class="b-tabs-compact">
			<xsl:for-each select="navigation/item[@key = 'partners']/item">
				<li class="item">
					<a class="link">
						<xsl:if test="/page/partners/@type = current()/@key">
							<xsl:attribute name="class">link selected</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="href">
							<xsl:call-template name="navigation-item-path"/>
						</xsl:attribute>
						<span class="text">
							<xsl:value-of select="@name"/>
						</span>
					</a>
				</li>
			</xsl:for-each>
		</ul>
		<xsl:if test="partners/partner">
			<ul class="b-team">
				<xsl:apply-templates select="partners/partner"/>
			</ul>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="partner">
		<li class="item">
			<xsl:if test="normalize-space(image)">
				<img src="/img/partners/{@id}.{image/text()}" class="image" alt="{title/text()}"/>
			</xsl:if>
			<xsl:if test="normalize-space(title)">
				<h3 class="title">
					<xsl:value-of select="title/text()"/>
				</h3>
			</xsl:if>
			<xsl:if test="normalize-space(desc)">
				<div class="desc">
					<xsl:apply-templates select="desc" mode="text"/>
				</div>
			</xsl:if>
		</li>
	</xsl:template>
	
</xsl:stylesheet>