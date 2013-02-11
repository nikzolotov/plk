<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param name="lang">ru</xsl:param>

	<xsl:include href="../common/utils.xslt" />
	<xsl:include href="../common/text.xslt" />
	
	<xsl:template name="langs"/>
	
	<xsl:template match="html">
		<xsl:call-template name="sub-menu"/>
		<xsl:copy-of select="*"/>
	</xsl:template>
	
	<xsl:template match="text">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<xsl:call-template name="sub-menu"/>
		<div class="b-editable">
			<xsl:if test="title/text()">
				<h2 class="b-first-title">
					<xsl:apply-templates select="title/* | title/text()" mode="text"/>
				</h2>
			</xsl:if>
			<xsl:apply-templates select="text" mode="text" />
			<xsl:text><![CDATA[]]></xsl:text>
		</div>
		<div>
			<a href="?act=edit&amp;l={$lang}">Редактировать</a>
		</div>
	</xsl:template>
	
	<xsl:template match="list">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<p>Выберите раздел, текст которого вы бы хотели просмотреть или редактировать.</p>
		<xsl:call-template name="sub-menu"/>
	</xsl:template>

	<xsl:template match="textform">
		<h1>
			<xsl:value-of select="/page/navigation/item[@in]/@name"/>
		</h1>
		<xsl:call-template name="sub-menu"/>
		<form action="?act=update&amp;l={$lang}" method="post">
			<fieldset>
				<div class="b-field">
					<label class="b-label" for="f-title">Заголовок</label>
					<div class="b-wide-input">
						<input id="f-title" type="text" name="title" value="{title/text()}"/>
					</div>
				</div>
				<div class="b-field">
					<label class="b-label" for="f-text">Текст <span>(<a name="text" href="#" onclick="return showeditor(this)">редактор</a>)</span></label>
					<div class="b-wide-input">
						<textarea id="f-text" name="text" rows="15" cols="100">
							<xsl:copy-of select="text/*|text/text()"/>
							<xsl:text><![CDATA[]]></xsl:text>
						</textarea>
					</div>
					<xsl:call-template name="examples"/>
				</div>
				<div class="b-field">
					<input type="submit" value="Сохранить"/>
				</div>
			</fieldset>
		</form>
		<div>
			<a>
				<xsl:attribute name="href">
					<xsl:apply-templates select="../navigation//item[@in and not(item[@in])]" mode="navigation-item-path" />
					<xsl:text>?l=</xsl:text>
					<xsl:value-of select="$lang" />
				</xsl:attribute>
				<xsl:text>Назад</xsl:text>
			</a>
		</div>
	</xsl:template>
	
	<xsl:template name="sub-menu">
		<ul>
			<xsl:apply-templates select="/page/navigation/item[@in]/item" mode="nav"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="item" mode="nav">
		<li>
			<xsl:choose>
				<xsl:when test="@in">
					<strong>
						<xsl:call-template name="navigation-item-link" />
					</strong>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="navigation-item-link" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@in and item">
				<ul>
					<xsl:apply-templates select="item" mode="nav" />
				</ul>
			</xsl:if>
		</li>
	</xsl:template>
	
	<xsl:template name="examples">
		<xsl:choose>
			<xsl:when test="id = 'ru.company.contacts'">
				<div class="b-tip">
					<a class="b-dynamic-link" href="#example">Пример списка контактов</a>
				</div>
				<pre id="example" class="b-code">
<xsl:text disable-output-escaping="no"><![CDATA[<dl class="b-options">
  <dt class="label">Адрес:</dt>
  <dd class="value">б-р Радищева, 21</dd>
  <dt class="label">Телефон:</dt>
  <dd class="value">+7 (4822) 999-777</dd>
  <dt class="label">Электронная почта:</dt>
  <dd class="value">
    <a href="mailto:info@alexandrit.ru">info@alexandrit.ru</a>
  </dd>
</dl>]]></xsl:text>
				</pre>
				<xsl:call-template name="example-script"/>
			</xsl:when>
			<xsl:when test="id = 'ru.offers'">
				<div class="b-tip">
					<a class="b-dynamic-link" href="#example">Вёрстка колонок с описанием спецпредложений</a>
				</div>
				<pre id="example" class="b-code">
<xsl:text disable-output-escaping="no"><![CDATA[<div class="l-wrapper-36">
  <p>Вступительный текст</p>
</div>
<div class="l-wrapper">
  <div class="l-column-26p h-column-11p">
    <div class="b-section-desc">
      <h2 class="title">
        <a class="link" href="/offers/gift-card.html">
          <img class="image" src="/img/promo/giftcard-preview.png" alt="Подарочная карта"/>
          Подарочная карта «Александритка»
        </a>
      </h2>
      <p class="desc">Описание подарочной карты</p>
    </div>
  </div>
  <div class="l-column-26p h-column-11p">
    <div class="b-section-desc">
      <h2 class="title">
        <a class="link" href="/offers/discount-card.html">
          <img class="image" src="/img/promo/discount-card-preview.png" alt="Накопительные карты"/>
          Накопительные дисконтные карты
        </a>
      </h2>
      <p class="desc">Описание дисконтных карт</p>
    </div>
  </div>
  <div class="l-column-26p">
    <div class="b-section-desc">
      <h2 class="title">
        <a class="link" href="/offers/rings.html">
          <img class="image" src="/img/promo/rings-preview.png" alt="Кольца"/>
          Обручальные кольца
        </a>
      </h2>
      <p class="desc">Описание обручальных колец</p>
    </div>
  </div>
</div>]]></xsl:text>
				</pre>
				<xsl:call-template name="example-script"/>
			</xsl:when>
			<xsl:when test="id = 'ru.offers.discount-card'">
				<div class="b-tip">
					<a class="b-dynamic-link" href="#example">Вёрстка колонок с описанием скидок</a>
				</div>
				<pre id="example" class="b-code">
<xsl:text disable-output-escaping="no"><![CDATA[<ul class="b-cards">
  <li class="item silver">
    <h2 class="title">Серебряная</h2>
    <table class="data">
      <tbody>
        <tr>
          <td class="cell">Сумма покупки 1</td>
          <td class="cell">1%</td>
        </tr>
        <tr>
          <td class="cell">Сумма покупки 2</td>
          <td class="cell">2%</td>
        </tr>
        <tr>
          <td class="cell">Сумма покупки 3</td>
          <td class="cell">3%</td>
        </tr>
      </tbody>
    </table>
    <i class="stage">&#160;</i>
  </li>
  <li class="item">
    <h2 class="title">Золотая</h2>
    <table class="data">
      <tbody>
        <tr>
          <td class="cell">Сумма покупки 1</td>
          <td class="cell">1%</td>
        </tr>
      </tbody>
    </table>
    <i class="stage">&#160;</i>
  </li>
  <li class="item">
    <h2 class="title">Платиновая</h2>
    <table class="data">
      <tbody>
        <tr>
          <td class="cell">Сумма покупки 1</td>
          <td class="cell">1%</td>
        </tr>
      </tbody>
    </table>
  </li>
</ul>]]></xsl:text>
				</pre>
				<xsl:call-template name="example-script"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="example-script">
		<script type="text/javascript">
			$('.b-dynamic-link').click(function(event){
				$('#' + $(this).attr('href').substr(1)).toggle();
				event.preventDefault();
			}).click();
		</script>
	</xsl:template>
	
</xsl:stylesheet>