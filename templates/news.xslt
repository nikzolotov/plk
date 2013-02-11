﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="sales.xslt"/>
	<xsl:import href="common/text.xslt"/>
	
	<xsl:param name="m"/>
	<xsl:param name="y"/>
	
	<xsl:template name="title-text">
		<xsl:text>Новости Александрита: </xsl:text>
		<xsl:choose>
			<xsl:when test="/page/news">
				<xsl:for-each select="/page/news/article">
					<xsl:if test="position() &lt; 4">
						<xsl:choose>
							<xsl:when test="@type = 'sale'">
								<xsl:value-of select="sale/title/text()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="title/text()"/>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:if test="position() != last() and position() != 3">
							<xsl:text>; </xsl:text>
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="/page/article">
				<xsl:value-of select="/page/article/title/text()"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="news">
		<div class="h-shift-27p h-column-24p">
			<h1>Пресс-центр</h1>
		</div>
		<div class="l-wrapper">
			<div class="l-column-18p h-shift-6p h-column-3p">
				<xsl:call-template name="news-types"/>
			</div>
			<div class="l-column-49p">
				<xsl:apply-templates select="/page/calendar" mode="list"/>
				<ul class="b-news">
					<xsl:apply-templates select="article" mode="list"/>
				</ul>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="article" mode="list">
		<xsl:if test="@type != 'sale' or (@type = 'sale' and sale/@published)">
			<li class="item">
				<strong class="date">
					<xsl:if test="@type = 'video' or @type = 'sale'">
						<xsl:attribute name="class">date separated</xsl:attribute>
					</xsl:if>
					<xsl:call-template name="format-date">
						<xsl:with-param name="date" select="date"/>
					</xsl:call-template>
				</strong>
				<xsl:choose>
					<xsl:when test="@type = 'video'">
						<xsl:apply-templates select="lead/*|lead/text()" mode="text"/>
					</xsl:when>
					<xsl:when test="@type = 'sale'">
						<xsl:apply-templates select="sale" mode="list"/>
					</xsl:when>
					<xsl:otherwise>
						<a>
							<xsl:attribute name="href">
								<xsl:apply-templates select="/page/navigation/item[@key = 'news']" mode="navigation-item-path"/>
								<xsl:value-of select="@id"/>
								<xsl:text>.html</xsl:text>
							</xsl:attribute>
							<xsl:value-of select="title/text()"/>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="sale" mode="list">
		<div class="b-banner">
			<a class="link">
				<xsl:attribute name="href">
					<xsl:apply-templates select="/page/navigation//item[@key = 'sale']" mode="navigation-item-path"/>
					<xsl:value-of select="@id"/>
					<xsl:text>.html</xsl:text>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="medium-image-ext/text()">
						<div class="b-banner">
							<img class="image" src="/img/sales/{@id}-medium.{medium-image-ext/text()}" alt="{title/text()}"/>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="title/text()"/>
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</div>
		<div>
			<em>
				<xsl:call-template name="sale-date"/>
			</em>
		</div>
	</xsl:template>
	
	<xsl:template match="calendar" mode="list">
		<ul class="b-archive">
			<xsl:for-each select="year">
				<xsl:sort select="@number" order="descending"/>
				<li class="item">
					<a class="link" href="/news/{@number}/">
						<xsl:if test="@number = $y">
							<xsl:attribute name="class">link selected</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="href">
							<xsl:apply-templates select="/page/navigation/item[@key = 'news']" mode="navigation-item-path"/>
							<xsl:if test="/page/calendar/@type">
								<xsl:value-of select="/page/calendar/@type"/>
								<xsl:text>/</xsl:text>
							</xsl:if>
							<xsl:value-of select="@number"/>
							<xsl:text>/</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="@number"/>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="article">
		<div class="h-shift-27p h-column-24p">
			<h1>
				<xsl:value-of select="title/text()"/>
			</h1>
		</div>
		<div class="l-wrapper">
			<div class="l-column-18p h-shift-6p h-column-3p">
				<xsl:call-template name="news-types"/>
			</div>
			<div class="l-column-49p">
				<xsl:apply-templates select="lead/*|lead/text()" mode="text"/>
				<xsl:choose>
					<xsl:when test="not(body/*)">
						<p>
							<xsl:apply-templates select="body/text()" mode="text"/>
						</p>
					</xsl:when>
					<xsl:when test="body/iframe">
						<p>
							<xsl:apply-templates select="body/*|body/text()" mode="text"/>
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
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>