<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="common/text.xslt"/>
	<xsl:import href="docs.xslt"/>
	<xsl:import href="articles.xslt"/>
	<xsl:import href="definitions.xslt"/>
	
	<xsl:template name="content">
		<h1>Информация для клиентов</h1>
		<ul class="b-tabs-docs">
			<li class="item">
				<a href="#docs" class="link selected">
					<span class="text">Документы</span>
				</a>
			</li>
			<li class="item">
				<a href="#articles" class="link">
					<span class="text">Статьи</span>
				</a>
			</li>
			<li class="item">
				<a href="#glossary" class="link">
					<span class="text">Глоссарий</span>
				</a>
			</li>
		</ul>
		<xsl:apply-templates select="docs"/>
		<xsl:apply-templates select="articles"/>
		<xsl:apply-templates select="definitions"/>
	</xsl:template>

</xsl:stylesheet>