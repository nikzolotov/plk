<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="common/text.xslt"/>
	
	<xsl:param name="m"/>
	<xsl:param name="y"/>
	
	<xsl:template name="title-text">
		<xsl:text>Новости Первой лизинговой компании: </xsl:text>
		<xsl:choose>
			<xsl:when test="/page/news">
				<xsl:for-each select="/page/news/article">
					<xsl:if test="position() &lt; 4">
						<xsl:value-of select="title/text()"/>
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
		<h1>Новости</h1>
		<xsl:apply-templates select="/page/calendar" mode="list"/>
		<ul class="b-events">
			<xsl:apply-templates select="article" mode="list"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="article" mode="list">
		<li class="item">
			<div class="date">
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date"/>
				</xsl:call-template>
			</div>
			<h3 class="title">
				<a class="link" href="?">
					<xsl:value-of select="title/text()"/>
				</a>
			</h3>
			<div class="sub-content">
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
			</div>
			<i class="zigzag zigzag-t">
				<xsl:text><![CDATA[]]></xsl:text>
			</i>
			<i class="zigzag zigzag-b">
				<xsl:text><![CDATA[]]></xsl:text>
			</i>
		</li>
	</xsl:template>
	
	<xsl:template match="calendar" mode="list">
		<ul class="b-tabs-compact b-tabs-compact-news">
			<xsl:for-each select="year">
				<xsl:sort select="@number" order="descending"/>
				<li class="item">
					<a class="link" href="/news/{@number}/">
						<xsl:if test="@number = $y">
							<xsl:attribute name="class">link selected</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="href">
							<xsl:apply-templates select="/page/navigation/item[@key = 'news']" mode="navigation-item-path"/>
							<xsl:if test="/page/calendar/@type/text()">
								<xsl:value-of select="/page/calendar/@type"/>
								<xsl:text>/</xsl:text>
							</xsl:if>
							<xsl:value-of select="@number"/>
							<xsl:text>/</xsl:text>
						</xsl:attribute>
						<span class="text">
							<xsl:value-of select="@number"/>
						</span>
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