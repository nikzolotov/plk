<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:import href="../common/date-form.xslt" />
		
	<xsl:template match="docs">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<xsl:if test="doc">
			<ul>
				<xsl:apply-templates select="doc"/>
			</ul>
		</xsl:if>
		<p>
			<a class="b-add-link" href="?action=edit">Добавить</a>
		</p>
	</xsl:template>
	
	<xsl:template match="doc">
		<li>
			<a class="link">
				<xsl:attribute name="href">
					<xsl:text>?action=edit&amp;id=</xsl:text>
					<xsl:value-of select="@id"/>
				</xsl:attribute>
				<xsl:value-of select="title/text()"/>
			</a>
			<span class="b-meta">
				<xsl:value-of select="ext/text()"/>
			</span>
		</li>
	</xsl:template>
	
	<xsl:template match="form">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<form action="?" method="post" enctype="multipart/form-data">
			<fieldset>
				<div class="b-field">
					<label class="b-label" for="f-title">Название</label>
					<div class="b-wide-input">
						<input id="f-title" type="text" name="title" value="{doc/title/text()}"/>
					</div>
				</div>
				<div class="b-field b-image-upload">
					<xsl:if test="doc/ext/text()">
						<div class="image">
							<a href="/customers/docs/files/plk-lizing-{doc/@id}.{doc/ext/text()}">
								<xsl:text>plk-lizing-</xsl:text>
								<xsl:value-of select="doc/@id"/>
								<xsl:text>.</xsl:text>
								<xsl:value-of select="doc/ext/text()"/>
							</a>
							<xsl:text> (</xsl:text>
							<xsl:apply-templates select="doc/size/text()" mode="file-size"/>
							<xsl:text>)</xsl:text>
						</div>
					</xsl:if>
					<div class="desc">
						<label class="b-label" for="f-document">Файл</label>
						<input id="f-document" type="file" name="document"/>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label">Дата</label>
					<xsl:call-template name="dateForm">
						<xsl:with-param name="date">
							<xsl:choose>
								<xsl:when test="doc/@date">
									<xsl:value-of select="doc/@date" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$date-now" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="min-year">2006</xsl:with-param>
						<xsl:with-param name="max-year"><xsl:value-of select="substring($date-now, 1, 4) + 1" /></xsl:with-param>
						<xsl:with-param name="type">datetime</xsl:with-param>
					</xsl:call-template>
				</div>
				<div class="b-field">
					<input type="hidden" name="action" value="update"/>
					<input type="hidden" name="id" value="{doc/@id}"/>
					<input type="submit" value="Сохранить"/>
					<xsl:if test="doc">
						<xsl:text>&#160;&#160;&#160;</xsl:text>
						<a class="b-delete-link" href="?action=delete&amp;id={doc/@id}" onclick="return confirm('Удалить этот документ?')">
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
	
</xsl:stylesheet>