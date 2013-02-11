<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:import href="../common/date-form.xslt" />
		
	<xsl:template match="vacancies">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<xsl:if test="vacancy">
			<ul>
				<xsl:apply-templates select="vacancy"/>
			</ul>
		</xsl:if>
		<p>
			<a class="b-add-link" href="?action=edit">Добавить</a>
		</p>
	</xsl:template>
	
	<xsl:template match="vacancy">
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
						<input id="f-title" type="text" name="title" value="{vacancy/title/text()}"/>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-desc">Обязанности <span>(<a name="desc" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-desc" name="desc" rows="8" cols="100">
							<xsl:copy-of select="vacancy/desc/* | vacancy/desc/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-require">Требования <span>(<a name="require" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-require" name="require" rows="8" cols="100">
							<xsl:copy-of select="vacancy/require/* | vacancy/require/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-salary">Условия <span>(<a name="salary" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-salary" name="salary" rows="8" cols="100">
							<xsl:copy-of select="vacancy/salary/* | vacancy/salary/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-employment">Тип занятости <span>(<a name="employment" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-employment" name="employment" rows="4" cols="100">
							<xsl:copy-of select="vacancy/employment/* | vacancy/employment/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label">Дата</label>
					<xsl:call-template name="dateForm">
						<xsl:with-param name="date">
							<xsl:choose>
								<xsl:when test="vacancy/@date">
									<xsl:value-of select="vacancy/@date" />
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
						<xsl:if test="vacancy/@published">
							<xsl:attribute name="checked">true</xsl:attribute>
						</xsl:if>
					</input>
					<label for="f-published"> Опубликовать</label>
				</div>
				<div class="b-field">
					<input type="hidden" name="action" value="update"/>
					<input type="hidden" name="id" value="{vacancy/@id}"/>
					<input type="submit" value="Сохранить"/>
					<xsl:if test="vacancy">
						<xsl:text>&#160;&#160;&#160;</xsl:text>
						<a class="b-delete-link" href="?action=delete&amp;id={vacancy/@id}" onclick="return confirm('Удалить эту вакансию?')">
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