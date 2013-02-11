<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="static-text">
		<xsl:choose>
			<xsl:when test="/page/navigation/item[@in]/item and not(/page/navigation/item[@in]/@hide-submenu)">
				<xsl:if test="title/text()">
					<div class="h-shift-27p h-column-28p">
						<xsl:if test="$nav-item/@layout ='wider'">
							<xsl:attribute name="class">h-shift-27p h-column-24p</xsl:attribute>
						</xsl:if>
						<xsl:apply-templates select="title"/>
					</div>
				</xsl:if>
				<div class="l-wrapper">
					<div class="l-column-18p h-shift-6p h-column-3p">
						<xsl:call-template name="sub-menu"/>
					</div>
					<div class="l-column-45p">
						<xsl:if test="$nav-item/@layout ='wider'">
							<xsl:attribute name="class">l-column-49p</xsl:attribute>
						</xsl:if>
						<xsl:if test="text/text() | text/*">
							<xsl:apply-templates select="text"/>
						</xsl:if>
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="h-shift-27p h-column-28p">
					<xsl:if test="$nav-item/@layout ='wider'">
						<xsl:attribute name="class">h-shift-27p h-column-24p</xsl:attribute>
					</xsl:if>
					<xsl:if test="title/text()">
						<xsl:apply-templates select="title"/>
					</xsl:if>
					<xsl:if test="text/text() | text/*">
						<xsl:apply-templates select="text"/>
					</xsl:if>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="title">
		<h1>
			<xsl:apply-templates select="* | text()" mode="text"/>
		</h1>
	</xsl:template>
	
	<xsl:template match="text">
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