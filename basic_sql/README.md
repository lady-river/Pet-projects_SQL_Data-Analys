# Pet-projects_SQL_Data-Analys
<div class="paragraph">
<div class="paragraph">База данных, которая хранит информацию о венчурных фондах и инвестициях в компании-стартапы. Эта база данных основана на датасете <a href="https://www.kaggle.com/justinas/startup-investments" target="_blank" rel="noopener">Startup Investments</a>, опубликованном на популярной платформе для соревнований по исследованию данных Kaggle.</div>
<div class="paragraph">&nbsp;</div>
<div class="paragraph">
<div class="paragraph">
<div class="downloadable-image"><img class="image image_expandable" src="https://pictures.s3.yandex.net/resources/1_Baza_dannykh_1673427320.png" alt="" width="1010" height="652" crossorigin="anonymous" /></div>
</div>
<div class="paragraph">&nbsp;</div>
<div class="paragraph">&nbsp;</div>
<div class="paragraph"><strong>Данные таблиц.</strong></div>
<div class="paragraph">&nbsp;</div>
<div class="paragraph">&nbsp;</div>
<div class="paragraph"><span style="text-decoration: underline;"><strong><span class="element-hint glossary-term"><span class="element-hint__wrapper"><code class="code-inline code-inline_theme_light">acquisition</code></span></span></strong></span></div>
<div class="paragraph">Содержит информацию о покупках одних компаний другими.</div>
<div class="paragraph">Таблица включает такие поля:</div>
<ul>
<li>первичный ключ <code class="code-inline code-inline_theme_light">id</code> &mdash; идентификатор или уникальный номер покупки;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">acquiring_company_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">company</code> &mdash; идентификатор компании-покупателя, то есть той, что покупает другую компанию;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">acquired_company_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">company</code> &mdash; идентификатор компании, которую покупают;</li>
<li><code class="code-inline code-inline_theme_light">term_code</code> &mdash; способ оплаты сделки:
<ul>
<li><code class="code-inline code-inline_theme_light">cash</code> &mdash; наличными;</li>
<li><code class="code-inline code-inline_theme_light">stock</code> &mdash; акциями компании;</li>
<li><code class="code-inline code-inline_theme_light">cash_and_stock</code> &mdash; смешанный тип оплаты: наличные и акции.</li>
</ul>
</li>
<li><code class="code-inline code-inline_theme_light">price_amount</code> &mdash; сумма покупки в долларах;</li>
<li><code class="code-inline code-inline_theme_light">acquired_at</code> &mdash; дата совершения сделки;</li>
<li><code class="code-inline code-inline_theme_light">created_at</code> &mdash; дата и время создания записи в таблице;</li>
<li><code class="code-inline code-inline_theme_light">updated_at</code> &mdash; дата и время обновления записи в таблице.</li>
</ul>
<div class="paragraph"><span style="text-decoration: underline;"><strong><code class="code-inline code-inline_theme_light">company</code></strong></span></div>
<div class="paragraph">Содержит информацию о компаниях-стартапах.</div>
<ul>
<li>первичный ключ <code class="code-inline code-inline_theme_light">id</code> &mdash; идентификатор, или уникальный номер компании;</li>
<li><code class="code-inline code-inline_theme_light">name</code> &mdash; название компании;</li>
<li><code class="code-inline code-inline_theme_light">category_code</code> &mdash; категория деятельности компании, например:
<ul>
<li><code class="code-inline code-inline_theme_light">news</code> &mdash; специализируется на работе с новостями;</li>
<li><code class="code-inline code-inline_theme_light">social</code> &mdash; специализируется на социальной работе.</li>
</ul>
</li>
<li><code class="code-inline code-inline_theme_light">status</code> &mdash; статус компании:
<ul>
<li><code class="code-inline code-inline_theme_light">acquired</code> &mdash; приобретена;</li>
<li><code class="code-inline code-inline_theme_light">operating</code> &mdash; действует;</li>
<li><code class="code-inline code-inline_theme_light">ipo</code> &mdash; вышла на IPO;</li>
<li><code class="code-inline code-inline_theme_light">closed</code> &mdash; перестала существовать.</li>
</ul>
</li>
<li><code class="code-inline code-inline_theme_light">founded_at</code> &mdash; дата основания компании;</li>
<li><code class="code-inline code-inline_theme_light">closed_at</code> &mdash; дата закрытия компании, которую указывают в том случае, если компании больше не существует;</li>
<li><code class="code-inline code-inline_theme_light">domain</code> &mdash; домен сайта компании;</li>
<li><code class="code-inline code-inline_theme_light">twitter_username</code> &mdash; название профиля компании в твиттере;</li>
<li><code class="code-inline code-inline_theme_light">country_code</code> &mdash; код страны, например, <code class="code-inline code-inline_theme_light">USA</code> для США, <code class="code-inline code-inline_theme_light">GBR</code> для Великобритании;</li>
<li><code class="code-inline code-inline_theme_light">investment_rounds</code> &mdash; число раундов, в которых компания участвовала как инвестор;</li>
<li><code class="code-inline code-inline_theme_light">funding_rounds</code> &mdash; число раундов, в которых компания привлекала инвестиции;</li>
<li><code class="code-inline code-inline_theme_light">funding_total</code> &mdash; сумма привлечённых инвестиций в долларах;</li>
<li><code class="code-inline code-inline_theme_light">milestones</code> &mdash; количество важных этапов в истории компании;</li>
<li><code class="code-inline code-inline_theme_light">created_at</code> &mdash; дата и время создания записи в таблице;</li>
<li><code class="code-inline code-inline_theme_light">updated_at</code> &mdash; дата и время обновления записи в таблице.</li>
</ul>
<div class="paragraph"><span style="text-decoration: underline;"><strong><code class="code-inline code-inline_theme_light">education</code></strong></span></div>
<div class="paragraph">Хранит информацию об уровне образования сотрудников компаний.</div>
<ul>
<li>первичный ключ <code class="code-inline code-inline_theme_light">id</code> &mdash; уникальный номер записи с информацией об образовании;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">person_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">people</code> &mdash; идентификатор человека, информация о котором представлена в записи;</li>
<li><code class="code-inline code-inline_theme_light">degree_type</code> &mdash; учебная степень, например:
<ul>
<li><code class="code-inline code-inline_theme_light">BA</code> &mdash; Bachelor of Arts &mdash; бакалавр гуманитарных наук;</li>
<li><code class="code-inline code-inline_theme_light">MS</code> &mdash; Master of Science &mdash; магистр естественных наук.</li>
</ul>
</li>
<li><code class="code-inline code-inline_theme_light">instituition</code> &mdash; учебное заведение, название университета;</li>
<li><code class="code-inline code-inline_theme_light">graduated_at</code> &mdash; дата завершения обучения, выпуска;</li>
<li><code class="code-inline code-inline_theme_light">created_at</code> &mdash; дата и время создания записи в таблице;</li>
<li><code class="code-inline code-inline_theme_light">updated_at</code> &mdash; дата и время обновления записи в таблице.</li>
</ul>
<div class="paragraph"><span style="text-decoration: underline;"><strong><code class="code-inline code-inline_theme_light">fund</code></strong></span></div>
<div class="paragraph">Хранит информацию о венчурных фондах.</div>
<ul>
<li>первичный ключ <code class="code-inline code-inline_theme_light">id</code> &mdash; уникальный номер венчурного фонда;</li>
<li><code class="code-inline code-inline_theme_light">name</code> &mdash; название венчурного фонда;</li>
<li><code class="code-inline code-inline_theme_light">founded_at</code> &mdash; дата основания фонда;</li>
<li><code class="code-inline code-inline_theme_light">domain</code> &mdash; домен сайта фонда;</li>
<li><code class="code-inline code-inline_theme_light">twitter_username</code> &mdash; профиль фонда в твиттере;</li>
<li><code class="code-inline code-inline_theme_light">country_code</code> &mdash; код страны фонда;</li>
<li><code class="code-inline code-inline_theme_light">investment_rounds</code> &mdash; число инвестиционных раундов, в которых фонд принимал участие;</li>
<li><code class="code-inline code-inline_theme_light">invested_companies</code> &mdash; число компаний, в которые инвестировал фонд;</li>
<li><code class="code-inline code-inline_theme_light">milestones</code> &mdash; количество важных этапов в истории фонда;</li>
<li><code class="code-inline code-inline_theme_light">created_at</code> &mdash; дата и время создания записи в таблице;</li>
<li><code class="code-inline code-inline_theme_light">updated_at</code> &mdash; дата и время обновления записи в таблице.</li>
</ul>
<div class="paragraph"><span style="text-decoration: underline;"><strong><code class="code-inline code-inline_theme_light">funding_round</code></strong></span></div>
<div class="paragraph">Содержит информацию о раундах инвестиций.</div>
<ul>
<li>первичный ключ <code class="code-inline code-inline_theme_light">id</code> &mdash; уникальный номер инвестиционного раунда;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">company_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">company</code> &mdash; уникальный номер компании, участвовавшей в инвестиционном раунде;</li>
<li><code class="code-inline code-inline_theme_light">funded_at</code> &mdash; дата проведения раунда;</li>
<li><code class="code-inline code-inline_theme_light">funding_round_type</code> &mdash; тип инвестиционного раунда, например:
<ul>
<li><code class="code-inline code-inline_theme_light">venture</code> &mdash; венчурный раунд;</li>
<li><code class="code-inline code-inline_theme_light">angel</code> &mdash; ангельский раунд;</li>
<li><code class="code-inline code-inline_theme_light">series_a</code> &mdash; раунд А.</li>
</ul>
</li>
<li><code class="code-inline code-inline_theme_light">raised_amount</code> &mdash; сумма инвестиций, которую привлекла компания в этом раунде в долларах;</li>
<li><code class="code-inline code-inline_theme_light">pre_money_valuation</code> &mdash; предварительная, проведённая до инвестиций оценка стоимости компании в долларах;</li>
<li><code class="code-inline code-inline_theme_light">participants</code> &mdash; количество участников инвестиционного раунда;</li>
<li><code class="code-inline code-inline_theme_light">is_first_round</code> &mdash; является ли этот раунд первым для компании;</li>
<li><code class="code-inline code-inline_theme_light">is_last_round</code> &mdash; является ли этот раунд последним для компании;</li>
<li><code class="code-inline code-inline_theme_light">created_at</code> &mdash; дата и время создания записи в таблице;</li>
<li><code class="code-inline code-inline_theme_light">updated_at</code> &mdash; дата и время обновления записи в таблице.</li>
</ul>
<div class="paragraph"><span style="text-decoration: underline;"><strong><code class="code-inline code-inline_theme_light">investment</code></strong></span></div>
<div class="paragraph">Содержит информацию об инвестициях венчурных фондов в компании-стартапы.</div>
<ul>
<li>первичный ключ <code class="code-inline code-inline_theme_light">id</code> &mdash; уникальный номер инвестиции;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">funding_round_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">funding_round</code> &mdash; уникальный номер раунда инвестиции;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">company_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">company</code> &mdash; уникальный номер компании-стартапа, в которую инвестируют;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">fund_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">fund</code> &mdash; уникальный номер фонда, инвестирующего в компанию-стартап;</li>
<li><code class="code-inline code-inline_theme_light">created_at</code> &mdash; дата и время создания записи в таблице;</li>
<li><code class="code-inline code-inline_theme_light">updated_at</code> &mdash; дата и время обновления записи в таблице.</li>
</ul>
<div class="paragraph"><span style="text-decoration: underline;"><strong><code class="code-inline code-inline_theme_light">people</code></strong></span></div>
<div class="paragraph">Содержит информацию о сотрудниках компаний-стартапов.</div>
<ul>
<li>первичный ключ <code class="code-inline code-inline_theme_light">id</code> &mdash; уникальный номер сотрудника;</li>
<li><code class="code-inline code-inline_theme_light">first_name</code> &mdash; имя сотрудника;</li>
<li><code class="code-inline code-inline_theme_light">last_name</code> &mdash; фамилия сотрудника;</li>
<li>внешний ключ <code class="code-inline code-inline_theme_light">company_id</code> &mdash; ссылается на таблицу <code class="code-inline code-inline_theme_light">company</code> &mdash; уникальный номер компании-стартапа;</li>
<li><code class="code-inline code-inline_theme_light">twitter_username</code> &mdash; профиль сотрудника в твиттере;</li>
<li><code class="code-inline code-inline_theme_light">created_at</code> &mdash; дата и время создания записи в таблице;</li>
<li><code class="code-inline code-inline_theme_light">updated_at</code> &mdash; дата и время обновления записи в таблице.</li>
</ul>
</div>
</div>
