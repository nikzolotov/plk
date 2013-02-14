<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="common/text.xslt"/>
	<xsl:import href="docs.xslt"/>
	<xsl:import href="articles.xslt"/>
	<xsl:import href="definitions.xslt"/>
	
	<xsl:template name="content">
		<h1>Информация для клиентов</h1>
		<xsl:apply-templates select="docs"/>
		<xsl:apply-templates select="articles"/>
		<xsl:apply-templates select="definitions"/>
	</xsl:template>
	
	<xsl:template name="docs">
		<div class="b-bottom-design">
			<ul class="b-docs">
				<li class="item">
					<h3 class="title">
						<a href="?">
							<b class="b-icon b-icon-doc"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
							<xsl:text>Документы юридического лица</xsl:text>
						</a>
					</h3>
					<div class="desc">word 2007, 357 Кб</div>
				</li>
				<li class="item">
					<h3 class="title">
						<a href="?">
							<b class="b-icon b-icon-doc"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
							<xsl:text>Документы юридического лица</xsl:text>
						</a>
					</h3>
					<div class="desc">word 2007, 357 Кб</div>
				</li>
				<li class="item">
					<h3 class="title">
						<a href="?">
							<b class="b-icon b-icon-doc"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
							<xsl:text>Документы юридического лица</xsl:text>
						</a>
					</h3>
					<div class="desc">word 2007, 357 Кб</div>
				</li>
			</ul>
		</div>
	</xsl:template>

</xsl:stylesheet>