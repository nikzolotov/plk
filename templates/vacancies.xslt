<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>

	<xsl:template name="content">
		<div class="h-shift-27p h-column-28p">
			<xsl:apply-templates select="static-text/title"/>
		</div>
		<div class="l-wrapper">
			<div class="l-column-18p h-shift-6p h-column-3p">
				<xsl:call-template name="sub-menu"/>
			</div>
			<div class="l-column-45p">
				<xsl:apply-templates select="static-text/text"/>
				<xsl:apply-templates select="vacancies/vacancy"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="vacancy">
		<h3>
			<xsl:value-of select="title/text()" disable-output-escaping="yes"/>
		</h3>
		<div class="l-wrapper-54">
			<xsl:if test="normalize-space(desc)">
				<h4>Обязанности:</h4>
				<xsl:apply-templates select="desc"/>
			</xsl:if>
			<xsl:if test="normalize-space(require)">
				<h4>Требования:</h4>
				<xsl:apply-templates select="require"/>
			</xsl:if>
			<xsl:if test="normalize-space(salary)">
				<h4>Условия:</h4>
				<xsl:apply-templates select="salary"/>
			</xsl:if>
			<xsl:if test="normalize-space(employment)">
				<h4>Тип занятости:</h4>
				<xsl:apply-templates select="employment"/>
			</xsl:if>
			<a class="b-button" href="mailto:hire@alexandrit.ru?subject=Отклик на вакансию: {title/text()}">
				<span class="text">Откликнуться</span>
			</a>
		</div>
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