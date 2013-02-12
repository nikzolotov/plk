<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="../common/utils.xslt" />
	<xsl:import href="../common/text.xslt" />
	<xsl:import href="../common/date-form.xslt" />

	<xsl:param name="action" />
	
	<xsl:template match="article-list">
		<h1>
			<xsl:value-of select="/page/navigation//item[@in and not(item/@in)]/@name" />
		</h1>
		<p>
			<a class="b-add-link" href="?act=edit">Добавить</a>
		</p>
		<xsl:apply-templates select="../pages" mode="pages" />
		<ul>
			<xsl:apply-templates mode="list" />
		</ul>
		<xsl:apply-templates select="../pages" mode="pages" />
		<p>
			<a class="b-add-link" href="?act=edit">Добавить</a>
		</p>
	</xsl:template>
	
	<xsl:template match="article[@id]" mode="list">
		<li>
			<xsl:if test="not(@published)">
				<xsl:attribute name="class">b-not-published</xsl:attribute>
			</xsl:if>
			<a class="link" href="?id={@id}&amp;act=edit">
				<xsl:value-of select="title/text()"/>
			</a>
			<span class="b-meta">
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date"/>
				</xsl:call-template>
			</span>
		</li>
	</xsl:template>
	
	<xsl:template match="article-form">
		<h1>
			<xsl:value-of select="/page/navigation//item[@in and not(item/@in)]/@name" />
		</h1>
		<form method="post" action="?id={article/@id}&amp;act=update" enctype="multipart/form-data">
			<fieldset>
				<div id="title-field" class="b-field">
					<label class="b-label" for="f-title">Заголовок</label>
					<div class="b-wide-input">
						<input id="f-title" type="text" name="title" value="{article/title/text()}"/>
					</div>
				</div>
				<div id="text-field" class="b-field">
					<label class="b-label" for="f-body">Текст <span>(<a name="body" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-body" name="body" rows="15" cols="100">
							<xsl:copy-of select="article/body/*|article/body/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label">Дата</label>
					<xsl:call-template name="dateForm">
						<xsl:with-param name="date">
							<xsl:choose>
								<xsl:when test="article/date"><xsl:value-of select="article/date" /></xsl:when>
								<xsl:otherwise><xsl:value-of select="$date-now" /></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="min-year">2006</xsl:with-param>
						<xsl:with-param name="max-year"><xsl:value-of select="substring($date-now, 1, 4) + 1" /></xsl:with-param>
						<xsl:with-param name="type">datetime</xsl:with-param>
					</xsl:call-template>
				</div>
				<div class="b-field">
					<input id="f-published" type="checkbox" name="published" value="1">
						<xsl:if test="article/@published">
							<xsl:attribute name="checked">true</xsl:attribute>
						</xsl:if>
					</input>
					<label for="f-published"> Опубликовать</label>
				</div>
				<div class="b-field">
					<input type="hidden" name="type" value="news"/>
					<input type="submit" value="Сохранить"/>
					<xsl:if test="article">
						<xsl:text>&#160;&#160;&#160;</xsl:text>
						<a class="b-delete-link" href="?act=delete&amp;id={article/@id}" onclick="return confirm('Удалить эту новость?')">
							<xsl:text>Удалить</xsl:text>
						</a>
					</xsl:if>
				</div>
			</fieldset>
		</form>
		<div>
			<a>
				<xsl:attribute name="href">
					<xsl:apply-templates select="../navigation//item[@in and not(item[@in])]" mode="navigation-item-path" />
				</xsl:attribute>
				<xsl:text>Назад</xsl:text>
			</a>
		</div>
	</xsl:template>
	
	<xsl:template match="date">
		<xsl:call-template name="date">
			<xsl:with-param name="with-time" select="'false'" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="sale-title">
		<xsl:choose>
			<xsl:when test="sale/title/text()">
				<xsl:value-of select="sale/title/text()"/>
			</xsl:when>
			<xsl:when test="article/sale/title/text()">
				<xsl:value-of select="article/sale/title/text()"/>
			</xsl:when>
			<xsl:otherwise>Без названия</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>