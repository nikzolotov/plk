<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href="static-text.xslt"/>
	
	<xsl:template name="script-includes">
		<xsl:call-template name="include-script">
			<xsl:with-param name="name" select="'tabs'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="content">
		<xsl:apply-templates select="static-text/title"/>
		<xsl:apply-templates select="static-text/text"/>
		<ul class="b-tabs-compact">
			<xsl:for-each select="navigation/item[@key = 'partners']/item">
				<li class="item">
					<a class="link">
						<xsl:if test="/page/partners/@type = current()/@key">
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
		<xsl:if test="partners/partner">
			<div id="tabs" class="b-white-zigzag">
				<ul class="b-simple-tabs">
					<xsl:for-each select="/page/cities/city">
						<xsl:if test="/page/partners/partner[@city = current()/@id]">
							<li class="item">
								<a class="link" href="#{@id}-partners">
									<span class="text">
										<xsl:value-of select="@title"/>
									</span>
								</a>
							</li>
						</xsl:if>
					</xsl:for-each>
					<xsl:text><![CDATA[]]></xsl:text>
				</ul>
				<xsl:for-each select="/page/cities/city">
					<xsl:if test="/page/partners/partner[@city = current()/@id]">
						<div id="{@id}-partners" class="js-tab">
							<ul class="b-partners">
								<xsl:apply-templates select="/page/partners/partner[@city = current()/@id]">
									<xsl:with-param name="city" select="@id"/>
								</xsl:apply-templates>
							</ul>
						</div>
					</xsl:if>
				</xsl:for-each>
				<i class="zigzag-top"><xsl:text><![CDATA[]]></xsl:text></i>
				<i class="zigzag-bottom"><xsl:text><![CDATA[]]></xsl:text></i>
			</div>
			<script type="text/javascript">
				$('#tabs').tabs({
					linkSelector: '.b-simple-tabs .link',
					tabSelector: '.js-tab'
				});
			</script>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="partner">
		<xsl:param name="city"/>
		<li class="item">
			<xsl:if test="position() = last()">
				<xsl:attribute name="class">
					<xsl:text>item item-</xsl:text>
					<xsl:value-of select="count(../partner[@city = $city]) mod 4"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="normalize-space(title)">
				<h3 class="title">
					<a href="{link/text()}" class="external-link" target="_blank">
						<xsl:if test="normalize-space(image)">
							<img class="image" src="/img/partners/{@id}.{image/text()}" alt="{title/text()}"/>
						</xsl:if>
						<xsl:value-of select="title/text()"/>
					</a>
				</h3>
			</xsl:if>
			<xsl:if test="normalize-space(desc)">
				<div class="desc">
					<xsl:apply-templates select="desc" mode="text"/>
				</div>
			</xsl:if>
		</li>
		<xsl:text><![CDATA[]]></xsl:text>
	</xsl:template>
	
</xsl:stylesheet>