<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="common/text.xslt"/>
	
	<xsl:template match="docs">
		<div id="docs" class="b-bottom-design">
			<ul class="b-docs">
				<xsl:apply-templates select="doc" mode="doc"/>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="doc" mode="doc">
		<li class="item">
			<h3 class="title">
				<a href="/customers/docs/files/{@id}.{ext/text()}">
					<b class="b-icon b-icon-doc"><b><xsl:text><![CDATA[]]></xsl:text></b></b>
					<xsl:value-of select="title/text()"/>
				</a>
			</h3>
			<div class="desc">
				<xsl:value-of select="ext/text()"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="size/text()" mode="file-size"/>
			</div>
		</li>
	</xsl:template>

</xsl:stylesheet>