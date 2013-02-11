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
				<xsl:if test="@type = 'video'">
					<xsl:attribute name="class">link b-video-icon</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="@type = 'video'">&#9658;</xsl:when>
					<xsl:when test="@type = 'sale'">
						<xsl:call-template name="sale-title"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="title/text()"/>
					</xsl:otherwise>
				</xsl:choose>
			</a>
			<span class="b-meta">
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date"/>
				</xsl:call-template>
				<xsl:text>, </xsl:text>
				<xsl:value-of select="/page/news-types/type[@id = current()/@type]/@title"/>
			</span>
		</li>
	</xsl:template>
	
	<xsl:template match="article-form">
		<h1>
			<xsl:value-of select="/page/navigation//item[@in and not(item/@in)]/@name" />
		</h1>
		<form method="post" action="?id={article/@id}&amp;act=update" enctype="multipart/form-data">
			<fieldset>
				<div class="b-field">
					<label class="b-label" for="f-type">Тип новости</label>
					<xsl:choose>
						<xsl:when test="article/@type = 'sale'">
							<strong>
								<xsl:value-of select="/page/news-types/type[@id = 'sale']/@title"/>
								<xsl:text>: </xsl:text>
							</strong>
							<a>
								<xsl:attribute name="href">
									<xsl:apply-templates select="/page/navigation/item[@key = 'sales']" mode="navigation-item-path"/>
									<xsl:text>?action=edit&amp;id=</xsl:text>
									<xsl:value-of select="article/@sale-id"/>
								</xsl:attribute>
								<xsl:call-template name="sale-title"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<select id="f-type" name="type">
								<xsl:for-each select="/page/news-types/type[@id != 'sale']">
									<option value="{@id}">
										<xsl:if test="/page/article-form/article/@type = @id">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="@title"/>
									</option>
								</xsl:for-each>
							</select>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<xsl:if test="article/@type != 'sale' or not(article)">
					<div id="title-field" class="b-field">
						<label class="b-label" for="f-title">Заголовок</label>
						<div class="b-wide-input">
							<input id="f-title" type="text" name="title" value="{article/title/text()}"/>
						</div>
					</div>
					<div id="lead-field" class="b-field">
						<label class="b-label" for="f-lead">Код видео</label>
						<div class="b-wide-input">
							<textarea id="f-lead" name="lead" rows="6" cols="100">
								<xsl:copy-of select="article/lead/*|article/lead/text()"/>
								<xsl:text><![CDATA[]]></xsl:text>
							</textarea>
							<span class="b-tip">Рекомендуемый размер видео: 486&#215;273&#160;px</span>
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
				</xsl:if>
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
		<xsl:if test="article/@type != 'sale' or not(article)">
			<script type="text/javascript">
				var formFields = {
						title: $('#title-field'),
						lead: $('#lead-field'),
						text: $('#text-field')
					},
					typeSelect = $('#f-type');
				
				typeSelect.change(function(){
					showFields(this.value);
				}).change();
				
				function showFields(newsType){
					if( newsType == 'video' ){
						formFields.title.hide();
						formFields.lead.show();
						formFields.text.hide();
					}
					else {
						formFields.title.show();
						formFields.lead.hide();
						formFields.text.show();
					}
				}
			</script>
		</xsl:if>
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