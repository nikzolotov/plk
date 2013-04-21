<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>
	
	<xsl:template name="script-includes">
		<xsl:call-template name="include-script">
			<xsl:with-param name="url">http://api-maps.yandex.ru/2.0/?load=package.standard&amp;mode=debug&amp;lang=ru-RU</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="include-script">
			<xsl:with-param name="name" select="'map'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="content">
		<xsl:apply-templates select="static-text/title"/>
		<ul class="b-tabs-compact">
			<li class="item">
				<a class="link" href="#moscow">
					<span class="text">Москва</span>
				</a>
			</li>
			<li class="item">
				<a class="link" href="#tver">
					<span class="text">Тверь</span>
				</a>
			</li>
		</ul>
		<xsl:apply-templates select="static-text/text"/>
		<script type="text/javascript">
			<xsl:text><![CDATA[
				$('.l-main-section').tabs({
					linkSelector: '.b-tabs-compact .link',
					tabSelector: '.b-tab'
				});
			]]></xsl:text>
		</script>
	</xsl:template>
	
</xsl:stylesheet>