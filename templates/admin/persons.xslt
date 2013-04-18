<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:import href="../common/date-form.xslt" />
	
	<xsl:key name="city" match="person" use="@city"/>
	
	<xsl:template match="persons">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<xsl:apply-templates select="person[generate-id(.) = generate-id(key('city',@city))]"/>
		<!--
		<xsl:if test="person">
			<ul>
				<xsl:apply-templates select="person"/>
			</ul>
		</xsl:if>
		<p>
			<a class="b-add-link" href="?action=edit">Добавить</a>
		</p>
		-->
	</xsl:template>
	
	<xsl:template match="person">
		<h3>
			<xsl:value-of select="/page/cities/city[@id = current()/@city]/@title"/>
		</h3>
		<ul>
			<xsl:apply-templates select="key('city',@city)" mode="list"/>
		</ul>
		<p>
			<a class="b-add-link" href="?action=edit&amp;city={@city}">Добавить</a>
		</p>
	</xsl:template>
	
	<xsl:template match="person" mode="list">
		<li>
			<xsl:if test="not(@published)">
				<xsl:attribute name="class">b-not-published</xsl:attribute>
			</xsl:if>
			<a class="link">
				<xsl:attribute name="href">
					<xsl:text>?action=edit&amp;id=</xsl:text>
					<xsl:value-of select="@id"/>
				</xsl:attribute>
				<xsl:value-of select="name/text()"/>
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
					<label class="b-label" for="f-name">Имя</label>
					<div class="b-wide-input">
						<input id="f-name" type="text" name="name" value="{person/name/text()}"/>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-duty">Должность</label>
					<div class="b-wide-input">
						<input id="f-duty" type="text" name="duty" value="{person/duty/text()}"/>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-body">Обязанности <span>(<a name="body" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-body" name="body" rows="8" cols="100">
							<xsl:copy-of select="person/body/* | person/body/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-email">Электронная почта</label>
					<div class="b-wide-input">
						<input id="f-email" type="text" name="email" value="{person/email/text()}"/>
					</div>
				</div>
				<div class="b-field b-image-upload">
					<xsl:if test="person/photo/text()">
						<div class="image">
							<img src="/img/persons/{person/@id}_128.{person/photo/text()}" alt="{person/name/text()}"/>
							<br/>
							<input id="f-delete-photo" type="checkbox" name="delete_photo" value="1"/>
							<label for="f-delete-photo">удалить фотографию</label>
						</div>
					</xsl:if>
					<div class="desc">
						<label class="b-label" for="f-photo">Фотография</label>
						<input id="f-photo" type="file" name="photo"/>
						<p class="b-tip">Загружайте, пожалуйста, вертикальные фотографии.</p>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label">Дата добавления</label>
					<xsl:call-template name="dateForm">
						<xsl:with-param name="date">
							<xsl:choose>
								<xsl:when test="person/@date">
									<xsl:value-of select="person/@date" />
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
					<input id="f-published" type="checkbox" name="published" value="1">
						<xsl:if test="person/@published">
							<xsl:attribute name="checked">true</xsl:attribute>
						</xsl:if>
					</input>
					<label for="f-published"> Опубликовать</label>
				</div>
				<div class="b-field">
					<input type="hidden" name="action" value="update"/>
					<input type="hidden" name="id" value="{person/@id}"/>
					<input type="submit" value="Сохранить"/>
					<xsl:if test="person">
						<xsl:text>&#160;&#160;&#160;</xsl:text>
						<a class="b-delete-link" href="?action=delete&amp;id={person/@id}" onclick="return confirm('Удалить этого работника?')">
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