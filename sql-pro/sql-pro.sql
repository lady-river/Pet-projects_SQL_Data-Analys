-- Проект выполняется в  тренажере на платформе Яндекс.Практикума
-- База данных сервиса StackOverflow — сервиса вопросов и ответов о программировании 


/* Задание 1. 
Найдите количество вопросов, которые набрали больше 300 очков или как минимум 100 раз были добавлены в «Закладки».*/

SELECT COUNT (p.id)
FROM stackoverflow.posts as  p
join stackoverflow.post_types as pt ON p.post_type_id = pt.id
WHERE type = 'Question' 
 	AND(score>300  
	OR favorites_count>=100);
 

/* Задание 2. 
Сколько в среднем в день задавали вопросов с 1 по 18 ноября 2008 включительно? Результат округлите до целого числа..*/
SELECT  ROUND(AVG(question_day.q_day),0)
FROM
	(SELECT 
	COUNT(p.id) as q_day,
	creation_date::date
	FROM stackoverflow.posts as  p
	join stackoverflow.post_types as pt ON p.post_type_id = pt.id
	WHERE type = 'Question' 
	GROUP BY creation_date::date
 	HAVING creation_date::date BETWEEN '2008-11-01' AND '2008-11-18') as question_day;

/* Задание 3. 
 Сколько пользователей получили значки сразу в день регистрации? Выведите количество уникальных пользователей.*/
SELECT COUNT (DISTINCT b.user_id)
FROM stackoverflow.users as  u
JOIN stackoverflow.badges  as b ON u.id = b.user_id
WHERE u.creation_date::date = b.creation_date::date



/* Задание 4. 
 Сколько уникальных постов пользователя с именем Joel Coehoorn получили хотя бы один голос?.*/
SELECT COUNT(ids.id)
FROM (SELECT  p.id 
		FROM stackoverflow.posts AS p
    	  JOIN stackoverflow.votes AS v ON p.id=v.post_id
     	  JOIN stackoverflow.users AS u ON p.user_id=u.id
 		WHERE display_name = 'Joel Coehoorn' AND v.id > 0
		GROUP BY p.id) as ids;



/* Задание 5. 
 Выгрузите все поля таблицы vote_types. Добавьте к таблице поле rank, в которое войдут номера записей в обратном порядке. Таблица должна быть отсортирована по полю id.*/
SELECT *
	, RANK() OVER (ORDER BY id  DESC)
FROM stackoverflow.vote_types
ORDER BY id;



/* Задание 6. 
 Отберите 10 пользователей, которые поставили больше всего голосов типа Close. Отобразите таблицу из двух полей: идентификатором пользователя и количеством голосов. 
 Отсортируйте данные сначала по убыванию количества голосов, потом по убыванию значения идентификатора пользователя.*/
SELECT user_id,
	COUNT (post_id) as posts_cnt
FROM stackoverflow.votes as v
JOIN stackoverflow.vote_types as vt ON v.vote_type_id=vt.id
WHERE vt.name = 'Close'
GROUP BY user_id 
Order BY posts_cnt DESC 
LIMIT 10

/* Задание 7. 
Отберите 10 пользователей по количеству значков, полученных в период с 15 ноября по 15 декабря 2008 года включительно.
Отобразите несколько полей:
- идентификатор пользователя;
- число значков;
- место в рейтинге — чем больше значков, тем выше рейтинг.
Пользователям, которые набрали одинаковое количество значков, присвойте одно и то же место в рейтинге.
Отсортируйте записи по количеству значков по убыванию, а затем по возрастанию значения идентификатора пользователя. .*/
SELECT *
	, DENSE_RANK() OVER (ORDER BY badges DESC) as rank
FROM 
    (select user_id,
    	COUNT (b.id) as badges
    FROM stackoverflow.badges b 
    JOIN stackoverflow.users u on u.id=b.user_id
    WHERE b.creation_date::date BETWEEN '2008-11-15' AND '2008-12-15'
    GROUP BY user_id
    ORDER BY badges DESC, user_id) as temp
ORDER BY rank , user_id
limit 10;



/* Задание 8. 
Сколько в среднем очков получает пост каждого пользователя?
Сформируйте таблицу из следующих полей:
- заголовок поста;
- идентификатор пользователя;
- число очков поста;
среднее число очков пользователя за пост, округлённое до целого числа.
Не учитывайте посты без заголовка, а также те, что набрали ноль очков. .*/

SELECT
	title
	, user_id
	, score
	, ROUND (AVG(score) OVER (PARTITION BY user_id),0)
FROM stackoverflow.posts
WHERE title is not NULL 
AND score <>0;



/* Задание 9. 
Отобразите заголовки постов, которые были написаны пользователями, получившими более 1000 значков. Посты без заголовков не должны попасть в список.*/
SELECT title 
FROM  stackoverflow.posts
WHERE user_id  in (SELECT
    user_id
    FROM stackoverflow.badges
    group by user_id
    having count(id) > 1000
)
AND title is not NULL ;



/* Задание 10. 
 Напишите запрос, который выгрузит данные о пользователях из США (англ. United States). Разделите пользователей на три группы в зависимости от количества просмотров их профилей:
- пользователям с числом просмотров больше либо равным 350 присвойте группу 1;
- пользователям с числом просмотров меньше 350, но больше либо равно 100 — группу 2;
- пользователям с числом просмотров меньше 100 — группу 3.
Отобразите в итоговой таблице идентификатор пользователя, количество просмотров профиля и группу. Пользователи с нулевым количеством просмотров не должны войти в итоговую таблицу..*/
SELECT id,
	views, 
CASE 
    when views >= 350 then 1
    WHEN 350 > views and views >= 100 then 2
    WHEN views<100 then 3
END    
FROM stackoverflow.users 
WHERE location LIKE '%United States%'
AND views > 0;



/* Задание 11. 
 
Дополните предыдущий запрос. Отобразите лидеров каждой группы — пользователей, которые набрали максимальное число просмотров в своей группе.
Выведите поля с идентификатором пользователя, группой и количеством просмотров. 
Отсортируйте таблицу по убыванию просмотров, а затем по возрастанию значения идентификатора..*/
WITH usa as (SELECT id,
					views, 
				CASE 
					WHEN views >= 350 then 1
   					WHEN 350 > views and views >= 100 then 2
					WHEN views<100 then 3
				END  as vg,
				MAX (views) OVER (PARTITION BY 
                  (CASE 
                    when views >= 350 then 1
                    WHEN 350 > views and views >= 100 then 2
                    WHEN views<100 then 3
                    END)) as max_group    
				FROM stackoverflow.users 
				WHERE location LIKE '%United States%'
				AND views > 0
				ORDER BY views)       
SELECT id, 
	views,
	vg
FROM usa
WHERE views =  max_group
ORDER BY  views DESC , id ;



/* Задание 12. 
 Посчитайте ежедневный прирост новых пользователей в ноябре 2008 года. Сформируйте таблицу с полями:
- номер дня;
- число пользователей, зарегистрированных в этот день;
- сумму пользователей с накоплением.*/
WITH TEMP AS(SELECT EXTRACT(DAY FROM creation_date::date)  AS day_num
					,COUNT (id) users_cnt
   		    FROM stackoverflow.users
			WHERE creation_date::date BETWEEN '2008-11-1' AND '2008-11-30'
			GROUP BY day_num)
SELECT *
,SUM (users_cnt) OVER  (ORDER BY day_num ) 
FROM TEMP;


/* Задание 13. 
Для каждого пользователя, который написал хотя бы один пост, найдите интервал между регистрацией и временем создания первого поста. Отобразите:
- идентификатор пользователя;
- разницу во времени между регистрацией и первым постом. .*/
WITH temp AS
        (SELECT DISTINCT p.user_id,
        u.creation_date as us_reg_date
        ,MIN(p.creation_date) OVER (PARTITION BY u.id ORDER BY p.creation_date) firs_post
        FROM stackoverflow.posts as p
        JOIN stackoverflow.users u on u.id=p.user_id)     
SELECT user_id
, firs_post - us_reg_date as delta
FROM temp;




/* Задание 14. 
 Выведите общую сумму просмотров постов за каждый месяц 2008 года. Если данных за какой-либо месяц в базе нет, такой месяц можно пропустить. 
 Результат отсортируйте по убыванию общего количества просмотров..*/


SELECT DATE_TRUNC('month', creation_date)::date AS mnth,
       SUM(views_count) 
FROM stackoverflow.posts
GROUP BY DATE_TRUNC('month', creation_date)
ORDER BY SUM(views_count) DESC




/* Задание 15. 
 Выведите имена самых активных пользователей, которые в первый месяц после регистрации (включая день регистрации) дали больше 100 ответов. 
 Вопросы, которые задавали пользователи, не учитывайте. Для каждого имени пользователя выведите количество уникальных значений user_id. 
 Отсортируйте результат по полю с именами в лексикографическом порядке..*/
SELECT 
	u.display_name
	, COUNT (DISTINCT u.id) 
FROM stackoverflow.users as u
join stackoverflow.posts as p on u.id = p.user_id
join stackoverflow.post_types as t on p.post_type_id = t.id 
WHERE t.type = 'Answer'
	AND p.creation_date::date BETWEEN u.creation_date::date AND (u.creation_date::date + INTERVAL '1 month') 
GROUP bY display_name 
HAVING COUNT( p.id) > 100
ORDER BY u.display_name
;

/* Задание 16. 
Выведите количество постов за 2008 год по месяцам. 
Отберите посты от пользователей, которые зарегистрировались в сентябре 2008 года и сделали хотя бы один пост в декабре того же года. 
Отсортируйте таблицу по значению месяца по убыванию. .*/
WITH september as (SELECT u.id
FROM stackoverflow.users as u
join stackoverflow.posts as p on u.id = p.user_id
WHERE DATE_TRUNC('month', u.creation_date)::date = '2008-09-01' 
                   AND DATE_TRUNC('month', p.creation_date)::date = '2008-12-01')                                   
SELECT 
	DATE_TRUNC('month', p.creation_date)::date
	,COUNT (p.id)
FROM stackoverflow.posts AS p
WHERE p.user_id IN (SELECT * FROM september)
AND DATE_TRUNC('year', p.creation_date)::date = '2008-01-01'
GROUP BY DATE_TRUNC('month', p.creation_date)::date
ORDER BY DATE_TRUNC('month', p.creation_date)::date DESC
; 




/* Задание 17. 
 Используя данные о постах, выведите несколько полей:
- идентификатор пользователя, который написал пост;
- дата создания поста;
- количество просмотров у текущего поста;
- сумму просмотров постов автора с накоплением.
Данные в таблице должны быть отсортированы по возрастанию идентификаторов пользователей, а данные об одном и том же пользователе — по возрастанию даты создания поста..*/
SELECT user_id
	, creation_date
	, views_count
	, SUM (views_count) OVER (PARTITION BY user_id ORDER BY creation_date)
FROM stackoverflow.posts 



/* Задание 18. 
колько в среднем дней в период с 1 по 7 декабря 2008 года включительно пользователи взаимодействовали с платформой? 
Для каждого пользователя отберите дни, в которые он или она опубликовали хотя бы один пост. 
Нужно получить одно целое число — не забудьте округлить результат. .*/

WITH temp as 
			(SELECT user_id,
			COUNT (distinct creation_date::date)
			FROM stackoverflow.posts
			WHERE creation_date::date between '2008-12-01' and '2008-12-07'
			GROUP BY user_id)
SELECT 
	ROUND (AVG(count),0)
FROM temp

/* Задание 19. 
На сколько процентов менялось количество постов ежемесячно с 1 сентября по 31 декабря 2008 года? Отобразите таблицу со следующими полями:
- номер месяца;
- количество постов за месяц;
- процент, который показывает, насколько изменилось количество постов в текущем месяце по сравнению с предыдущим.
Если постов стало меньше, значение процента должно быть отрицательным, если больше — положительным. Округлите значение процента до двух знаков после запятой.
Напомним, что при делении одного целого числа на другое в PostgreSQL в результате получится целое число, округлённое до ближайшего целого вниз. Чтобы этого избежать, переведите делимое в тип numeric..*/
WITH temp as
			(SELECT
			EXTRACT(month FROM creation_date::date) AS month_num,
			COUNT (DISTINCT  id) 
			FROM stackoverflow.posts
			WHERE creation_date::date between '2008-09-01' and '2008-12-31'
			GROUP BY month_num)
SELECT *
	,ROUND(((count::numeric / LAG (count) OVER (ORDER BY  month_num )) - 1) * 100, 2) AS user_growth
FROM temp;

/* Задание 20. 
 Выгрузите данные активности пользователя, который опубликовал больше всего постов за всё время. Выведите данные за октябрь 2008 года в таком виде:
номер недели;
дата и время последнего поста, опубликованного на этой неделе..*/
WITH user_post AS (SELECT user_id,
                   COUNT(DISTINCT id) AS cnt
                   FROM stackoverflow.posts
                   GROUP BY user_id
                   ORDER BY cnt DESC
                   LIMIT 1),
     dtt AS (SELECT p.user_id,
             p.creation_date,
             extract('week' from p.creation_date) AS week_number
             FROM stackoverflow.posts AS p
             JOIN user_post ON user_post.user_id = p.user_id
             WHERE DATE_TRUNC('month', p.creation_date)::date = '2008-10-01')
SELECT DISTINCT week_number::numeric,
MAX(creation_date) OVER (PARTITION BY week_number) AS post_dt
FROM dtt
ORDER BY week_number;






























