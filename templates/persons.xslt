<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>

	<xsl:template name="content">
		<xsl:call-template name="breadcrumbs-title">
			<xsl:with-param name="title" select="static-text/title"/>
		</xsl:call-template>
		<xsl:apply-templates select="static-text/text"/>
		<xsl:if test="persons/person">
			<ul class="b-objects">
				<xsl:apply-templates select="persons/person"/>
			</ul>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="person">
		<li class="item">
			<xsl:if test="normalize-space(photo)">
				<img src="/img/persons/{@id}_128.{photo/text()}" class="image" alt="{name/text()}"/>
			</xsl:if>
			<xsl:if test="normalize-space(name)">
				<h3 class="title">
					<xsl:value-of select="name/text()"/>
				</h3>
			</xsl:if>
			<xsl:if test="normalize-space(duty)">
				<div class="desc">
					<xsl:apply-templates select="duty" mode="text"/>
				</div>
			</xsl:if>
			<xsl:if test="normalize-space(body)">
				<div class="summary">
					<xsl:apply-templates select="body" mode="text"/>
				</div>
			</xsl:if>
			<xsl:if test="normalize-space(email)">
				<div class="address">
					<a href="mailto:{email/text()}">
						<xsl:value-of select="email/text()"/>
					</a>
				</div>
			</xsl:if>
		</li>
	</xsl:template>
	
</xsl:stylesheet>