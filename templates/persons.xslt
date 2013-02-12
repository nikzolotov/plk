<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>

	<xsl:template name="content">
		<xsl:apply-templates select="static-text/title"/>
		<xsl:apply-templates select="static-text/text"/>
		<ul class="b-tabs-compact">
			<xsl:for-each select="navigation/item[@key = 'team']/item">
				<li class="item">
					<a class="link">
						<xsl:if test="/page/persons/@city = current()/@key">
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
		<xsl:if test="persons/person">
			<ul class="b-team">
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
	
	<xsl:template match="desc | require | salary | employment">
		<xsl:choose>
			<xsl:when test="not(*)">
				<p>
					<xsl:value-of select="."/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="." mode="text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>