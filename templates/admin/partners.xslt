<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:import href="../common/date-form.xslt" />
	
	<xsl:template match="partners">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<xsl:apply-templates select="/page/types/type"/>
	</xsl:template>
	
	<xsl:template match="type">
		<h3>
			<xsl:value-of select="@title"/>
		</h3>
		<xsl:if test="/page/partners/partner[@type = current()/@id]">
			<ul>
				<xsl:apply-templates select="/page/partners/partner[@type = current()/@id]"/>
			</ul>
		</xsl:if>
		<p>
			<a class="b-add-link" href="?action=edit&amp;type={@id}">Добавить</a>
		</p>
	</xsl:template>
	
	<xsl:template match="partner">
		<li>
			<xsl:if test="not(@published)">
				<xsl:attribute name="class">b-not-published</xsl:attribute>
			</xsl:if>
			<a class="link">
				<xsl:attribute name="href">
					<xsl:text>?action=edit&amp;id=</xsl:text>
					<xsl:value-of select="@id"/>
				</xsl:attribute>
				<xsl:value-of select="title/text()"/>
			</a>
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
						<input id="f-title" type="text" name="title" value="{partner/title/text()}"/>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-desc">Краткое описание <span>(<a name="desc" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-desc" name="desc" rows="4" cols="100">
							<xsl:copy-of select="partner/desc/* | partner/desc/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
				</div>
				<div class="b-field b-image-upload">
					<xsl:if test="partner/image/text()">
						<div class="image">
							<img src="/img/partners/{partner/@id}.{partner/image/text()}" alt="{partner/name/text()}"/>
							<br/>
							<input id="f-delete-image" type="checkbox" name="delete_image" value="1"/>
							<label for="f-delete-image">удалить логотип</label>
						</div>
					</xsl:if>
					<div class="desc">
						<label class="b-label" for="f-image">Логотип</label>
						<input id="f-image" type="file" name="image"/>
						<p class="b-tip">Загружайте, пожалуйста, логотипы на белом фоне.</p>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-city-id">Город</label>
					<select id="f-city-id" name="city_id">
						<xsl:for-each select="/page/cities/city">
							<option value="{@id}">
								<xsl:if test="/page/form/partner/@city_id = @id or /page/form/@city = @id">
									<xsl:attribute name="selected">selected</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="@title"/>
							</option>
						</xsl:for-each>
					</select>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-type">Что поставляют</label>
					<select id="f-type" name="type">
						<xsl:for-each select="/page/types/type">
							<option value="{@id}">
								<xsl:if test="/page/form/partner/@type = @id or /page/form/@type = @id">
									<xsl:attribute name="selected">selected</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="@title"/>
							</option>
						</xsl:for-each>
					</select>
				</div>
				<div class="b-field">
					<input id="f-published" type="checkbox" name="published" value="1">
						<xsl:if test="partner/@published">
							<xsl:attribute name="checked">true</xsl:attribute>
						</xsl:if>
					</input>
					<label for="f-published"> Опубликовать</label>
				</div>
				<div class="b-field">
					<input type="hidden" name="action" value="update"/>
					<input type="hidden" name="id" value="{partner/@id}"/>
					<input type="submit" value="Сохранить"/>
					<xsl:if test="partner">
						<xsl:text>&#160;&#160;&#160;</xsl:text>
						<a class="b-delete-link" href="?action=delete&amp;id={partner/@id}" onclick="return confirm('Удалить этого поставщика?')">
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