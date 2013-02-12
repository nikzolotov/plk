﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>

	<xsl:template name="content">
		<h1>Работа в Первой Лизинговой Компании</h1>
		<xsl:apply-templates select="vacancies/vacancy"/>
	</xsl:template>
	
	<xsl:template match="vacancy">
		<div class="b-important">
			<h2 class="b-title-square">
				<a href="?">
					<xsl:value-of select="title/text()" disable-output-escaping="yes"/>
				</a>
			</h2>
			<xsl:if test="normalize-space(desc)">
				<h4 class="title">Обязанности:</h4>
				<xsl:apply-templates select="desc"/>
			</xsl:if>
			<xsl:if test="normalize-space(require)">
				<h4 class="title">Требования:</h4>
				<xsl:apply-templates select="require"/>
			</xsl:if>
			<xsl:if test="normalize-space(salary)">
				<h4 class="title">Условия:</h4>
				<xsl:apply-templates select="salary"/>
			</xsl:if>
			<xsl:if test="normalize-space(employment)">
				<h4 class="title">Тип занятости:</h4>
				<xsl:apply-templates select="employment"/>
			</xsl:if>
			<a href="mailto:hire@plk.ru?subject=Отклик на вакансию: {title/text()}" class="b-transform-link">
				<span class="text">Откликнуться на вакансию</span>
			</a>
			<i class="zigzag zigzag-t">
				<xsl:text><![CDATA[]]></xsl:text>
			</i>
			<i class="zigzag zigzag-b">
				<xsl:text><![CDATA[]]></xsl:text>
			</i>
		</div>
		<br/>
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