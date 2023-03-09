<div class="paragraph">
<div class="paragraph">База данных <a href="https://www.stackoverflow.com/" target="_blank" rel="noopener">StackOverflow</a> &mdash; сервиса вопросов и ответов о программировании. StackOverflow похож на социальную сеть &mdash; пользователи сервиса задают вопросы, отвечают на посты, оставляют комментарии и ставят оценки другим ответам.</div>
<div class="paragraph">Вы будете работать с версией базы, где хранятся данные о постах за 2008 год, но в таблицах вы найдёте информацию и о более поздних оценках, которые эти посты получили.</div>
</div>
<div class="paragraph"><br />ER-диаграмма базы:</div>
<div class="paragraph">
<div class="downloadable-image"><img class="image image_expandable" src="https://pictures.s3.yandex.net/resources/Frame_353_1_1664969443.png" alt="" width="490" height="351" crossorigin="anonymous" /></div>
</div>
<h3>Таблица&nbsp;<code class="code-inline code-inline_theme_light">stackoverflow.badges</code></h3>
<div class="paragraph">Хранит информацию о значках, которые присуждаются за разные достижения. Например, пользователь, правильно ответивший на большое количество вопросов про PostgreSQL, может получить значок postgresql.</div>
<div class="table">
<div class="scrollable-default scrollable scrollable_theme_light table__wrapper">
<div>&nbsp;</div>
<div class="scrollable__content-wrapper">
<div class="scrollbar-remover scrollable__content-container">
<div class="scrollable__content">
<table cellspacing="0" cellpadding="0">
<thead>
<tr>
<th scope="col">Поле</th>
<th scope="col">Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td>id</td>
<td>Идентификатор значка, первичный ключ таблицы</td>
</tr>
<tr>
<td>name</td>
<td>Название значка</td>
</tr>
<tr>
<td>user_id</td>
<td>Идентификатор пользователя, которому присвоили значок, внешний ключ, отсылающий к таблице&nbsp;<code class="code-inline code-inline_theme_light">users</code></td>
</tr>
<tr>
<td>creation_date</td>
<td>Дата присвоения значка</td>
</tr>
</tbody>
</table>
<div>&nbsp;</div>
</div>
</div>
</div>
<section class="scrollbar-default scrollbar scrollbar_vertical scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_vertical">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
<section class="scrollbar-default scrollbar scrollbar_horizontal scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_horizontal">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
</div>
</div>
<h3>Таблица&nbsp;<code class="code-inline code-inline_theme_light">stackoverflow.post_types</code></h3>
<div class="paragraph">Содержит информацию о типе постов. Их может быть два:</div>
<ul>
<li><code class="code-inline code-inline_theme_light">Question</code> &mdash; пост с вопросом;</li>
<li><code class="code-inline code-inline_theme_light">Answer</code> &mdash; пост с ответом.</li>
</ul>
<div class="table">
<div class="scrollable-default scrollable scrollable_theme_light table__wrapper">
<div>&nbsp;</div>
<div class="scrollable__content-wrapper">
<div class="scrollbar-remover scrollable__content-container">
<div class="scrollable__content">
<table cellspacing="0" cellpadding="0">
<thead>
<tr>
<th scope="col">Поле</th>
<th scope="col">Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td>id</td>
<td>Идентификатор поста, первичный ключ таблицы</td>
</tr>
<tr>
<td>type</td>
<td>Тип поста</td>
</tr>
</tbody>
</table>
<div>&nbsp;</div>
</div>
</div>
</div>
<section class="scrollbar-default scrollbar scrollbar_vertical scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_vertical">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
<section class="scrollbar-default scrollbar scrollbar_horizontal scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_horizontal">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
</div>
</div>
<h3>Таблица&nbsp;<code class="code-inline code-inline_theme_light">stackoverflow.posts</code></h3>
<div class="paragraph">Содержит информацию о постах.</div>
<div class="table">
<div class="scrollable-default scrollable scrollable_theme_light table__wrapper table__wrapper_scrollable-y">
<div>&nbsp;</div>
<div class="scrollable__content-wrapper">
<div class="scrollbar-remover scrollable__content-container">
<div class="scrollable__content">
<table cellspacing="0" cellpadding="0">
<thead>
<tr>
<th scope="col">Поле</th>
<th scope="col">Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td>id</td>
<td>Идентификатор поста, первичный ключ таблицы</td>
</tr>
<tr>
<td>title</td>
<td>Заголовок поста</td>
</tr>
<tr>
<td>creation_date</td>
<td>Дата создания поста</td>
</tr>
<tr>
<td>favorites_count</td>
<td>Число, которое показывает, сколько раз пост добавили в &laquo;Закладки&raquo;</td>
</tr>
<tr>
<td>last_activity_date</td>
<td>Дата последнего действия в посте, например комментария</td>
</tr>
<tr>
<td>last_edit_date</td>
<td>Дата последнего изменения поста</td>
</tr>
<tr>
<td>user_id</td>
<td>Идентификатор пользователя, который создал пост, внешний ключ к таблице&nbsp;<code class="code-inline code-inline_theme_light">users</code></td>
</tr>
<tr>
<td>parent_id</td>
<td>Если пост написали в ответ на другую публикацию, в это поле попадёт идентификатор поста с вопросом</td>
</tr>
<tr>
<td>post_type_id</td>
<td>Идентификатор типа поста, внешний ключ к таблице&nbsp;<code class="code-inline code-inline_theme_light">post_types</code></td>
</tr>
<tr>
<td>score</td>
<td>Количество очков, которое набрал пост</td>
</tr>
<tr>
<td>views_count</td>
<td>Количество просмотров</td>
</tr>
</tbody>
</table>
<div>&nbsp;</div>
</div>
</div>
</div>
<section class="scrollbar-default scrollbar scrollbar_vertical scrollable__scrollbar scrollable__scrollbar_type_vertical">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
<section class="scrollbar-default scrollbar scrollbar_horizontal scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_horizontal">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
</div>
</div>
<h3>Таблица&nbsp;<code class="code-inline code-inline_theme_light">stackoverflow.users</code></h3>
<div class="paragraph">Содержит информацию о пользователях.</div>
<div class="table">
<div class="scrollable-default scrollable scrollable_theme_light table__wrapper table__wrapper_scrollable-y">
<div>&nbsp;</div>
<div class="scrollable__content-wrapper">
<div class="scrollbar-remover scrollable__content-container">
<div class="scrollable__content">
<table cellspacing="0" cellpadding="0">
<thead>
<tr>
<th scope="col">Поле</th>
<th scope="col">Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td>id</td>
<td>Идентификатор пользователя, первичный ключ таблицы</td>
</tr>
<tr>
<td>creation_date</td>
<td>Дата регистрации пользователя</td>
</tr>
<tr>
<td>display_name</td>
<td>Имя пользователя</td>
</tr>
<tr>
<td>last_access_date</td>
<td>Дата последнего входа</td>
</tr>
<tr>
<td>location</td>
<td>Местоположение</td>
</tr>
<tr>
<td>reputation</td>
<td>Очки репутации, которые получают за хорошие вопросы и полезные ответы</td>
</tr>
<tr>
<td>views</td>
<td>Число просмотров профиля пользователя</td>
</tr>
</tbody>
</table>
<div>&nbsp;</div>
</div>
</div>
</div>
<section class="scrollbar-default scrollbar scrollbar_vertical scrollable__scrollbar scrollable__scrollbar_type_vertical">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
<section class="scrollbar-default scrollbar scrollbar_horizontal scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_horizontal">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
</div>
</div>
<h3>Таблица&nbsp;<code class="code-inline code-inline_theme_light">stackoverflow.vote_types</code></h3>
<div class="paragraph">Содержит информацию о типах голосов. Голос &mdash; это метка, которую пользователи ставят посту. Типов бывает несколько:</div>
<ul>
<li><code class="code-inline code-inline_theme_light">UpMod</code> &mdash; такую отметку получают посты с вопросами или ответами, которые пользователи посчитали уместными и полезными.</li>
<li><code class="code-inline code-inline_theme_light">DownMod</code> &mdash; такую отметку получают посты, которые показались пользователям наименее полезными.</li>
<li><code class="code-inline code-inline_theme_light">Close</code> &mdash; такую метку ставят опытные пользователи сервиса, если заданный вопрос нужно доработать или он вообще не подходит для платформы.</li>
<li><code class="code-inline code-inline_theme_light">Offensive</code> &mdash; такую метку могут поставить, если пользователь ответил на вопрос в грубой и оскорбительной манере, например, указав на неопытность автора поста.</li>
<li><code class="code-inline code-inline_theme_light">Spam</code> &mdash; такую метку ставят в случае, если пост пользователя выглядит откровенной рекламой.</li>
</ul>
<div class="table">
<div class="scrollable-default scrollable scrollable_theme_light table__wrapper">
<div>&nbsp;</div>
<div class="scrollable__content-wrapper">
<div class="scrollbar-remover scrollable__content-container">
<div class="scrollable__content">
<table cellspacing="0" cellpadding="0">
<thead>
<tr>
<th scope="col">Поле</th>
<th scope="col">Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td>id</td>
<td>Идентификатор типа голоса, первичный ключ</td>
</tr>
<tr>
<td>name</td>
<td>Название метки</td>
</tr>
</tbody>
</table>
<div>&nbsp;</div>
</div>
</div>
</div>
<section class="scrollbar-default scrollbar scrollbar_vertical scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_vertical">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
<section class="scrollbar-default scrollbar scrollbar_horizontal scrollbar_hidden scrollable__scrollbar scrollable__scrollbar_type_horizontal">
<div class="scrollbar__control-container">&nbsp;</div>
</section>
</div>
</div>
<h3>Таблица&nbsp;<code class="code-inline code-inline_theme_light">stackoverflow.votes</code></h3>
<div class="paragraph">Содержит информацию о голосах за посты.</div>
<div class="table">
<div class="scrollable-default scrollable scrollable_theme_light table__wrapper table__wrapper_scrollable-y">
<div>&nbsp;</div>
<div class="scrollable__content-wrapper">
<div class="scrollbar-remover scrollable__content-container">
<div class="scrollable__content">
<table cellspacing="0" cellpadding="0">
<thead>
<tr>
<th scope="col">Поле</th>
<th scope="col">Описание</th>
</tr>
</thead>
<tbody>
<tr>
<td>id</td>
<td>Идентификатор голоса, первичный ключ</td>
</tr>
<tr>
<td>post_id</td>
<td>Идентификатор поста, внешний ключ к таблице&nbsp;<code class="code-inline code-inline_theme_light">posts</code></td>
</tr>
<tr>
<td>user_id</td>
<td>Идентификатор пользователя, который поставил посту голос, внешний ключ к таблице&nbsp;<code class="code-inline code-inline_theme_light">users</code></td>
</tr>
<tr>
<td>bounty_amount</td>
<td>Сумма вознаграждения, которое назначают, чтобы привлечь внимание к посту</td>
</tr>
<tr>
<td>vote_type_id</td>
<td>Идентификатор типа голоса, внешний ключ к таблице&nbsp;<code class="code-inline code-inline_theme_light">vote_types</code></td>
</tr>
<tr>
<td>creation_date</td>
<td>Дата назначения голоса</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
</div>
</div>
<p>&nbsp;</p>
