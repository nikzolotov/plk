<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="base-dir">/admin</xsl:variable>
	<xsl:param name="use-fckeditor">false</xsl:param>

	<xsl:template match="*" />
	
	<xsl:template match="page">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]]></xsl:text>
		<html>
			<xsl:call-template name="html-head" />
			<xsl:call-template name="html-body" />
		</html>
	</xsl:template>
	
	<xsl:template name="html-head">
		<head>
			<title>
				<xsl:choose>
					<xsl:when test="navigation//item[@in and not(item[@in])]">
						<xsl:value-of select="navigation//item[@in and not(item[@in])]/@name" />
					</xsl:when>
					<xsl:otherwise>АРМ администратора</xsl:otherwise>
				</xsl:choose>
			</title>
			<meta http-equiv="X-UA-Compatible" content="IE=9"/>
			<link rel="stylesheet" type="text/css" href="/css/main.css" />
			<link rel="stylesheet" type="text/css" href="{$base-dir}/css/main.css" />
			<xsl:call-template name="include-script">
				<xsl:with-param name="name" select="'jquery-1.7.2.min'"/>
				<xsl:with-param name="base_url">/js/</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="script-includes"/>
			<xsl:if test="$use-fckeditor = 'true'">
				<script type="text/javascript" src="/admin/js/fckeditor/fckeditor.js">&#160;</script>
				<script type="text/javascript">
					function showeditor(lnk){
						var oFCKeditor = new FCKeditor( lnk.name );
						oFCKeditor.BasePath = '/admin/js/fckeditor/';
						oFCKeditor.Height=document.forms[0][lnk.name].rows * 25;
						oFCKeditor.ReplaceTextarea();
						lnk.parentNode.style.display="none";
						return false;
					}
				</script>
			</xsl:if>
		</head>
	</xsl:template>
	
	<xsl:template name="script-includes"/>

	<xsl:template name="html-body">
		<body>
			<div class="l-container">
				<div class="l-navigation">
					<xsl:apply-templates select="navigation" mode="navigation" />
				</div>
				<div class="l-content">
					<xsl:call-template name="content" />
				</div>
			</div>
		</body>
	</xsl:template>
	
	<xsl:template name="content">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="navigation" mode="navigation">
		<div class="b-admin-home">
			<a class="link" href="{$base-dir}/">Управление сайтом</a>
		</div>
		<ul class="b-admin-menu">
			<xsl:for-each select="item">
				<li class="item">
					<a>
						<xsl:if test="not(@hit)">
							<xsl:attribute name="href">
								<xsl:call-template name="navigation-item-path" />
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="@in">
							<xsl:attribute name="class">selected</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="@name" />
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	
	<xsl:template match="html">
		<xsl:copy-of select="*" />
	</xsl:template>
	
	<xsl:template name="formated-date">
		<xsl:param name="time">true</xsl:param>
		<xsl:value-of select="substring(., 9, 2)" />
		<xsl:text>.</xsl:text>
		<xsl:value-of select="substring(., 6, 2)" />
		<xsl:text>.</xsl:text>
		<xsl:value-of select="substring(., 1, 4)" />
		<xsl:if test="$time = true">
			<xsl:text>, </xsl:text>
			<xsl:value-of select="substring(., 12, 5)" />
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>