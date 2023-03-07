-- Проект выполняется в  тренажере на платформе Яндекс.Практикума
-- База данных основана на датасете Startup Investments, опубликованном на популярной платформе для соревнований по исследованию данных Kaggle. 

-- Задание 1. 
Посчитайте, сколько компаний закрылось.*/
SELECT COUNT(id)
FROM company
WHERE status = 'closed';

/* Задание 2. 
 Отобразите количество привлечённых средств для новостных компаний США. Используйте данные из таблицы company. 
 Отсортируйте таблицу по убыванию значений в поле funding_total.*/
SELECT funding_total
FROM company
WHERE category_code = 'news'
AND country_code = 'USA'
ORDER BY funding_total DESC;


/*Задание 3. 
 Найдите общую сумму сделок по покупке одних компаний другими в долларах. 
 Отберите сделки, которые осуществлялись только за наличные с 2011 по 2013 год включительно.*/
SELECT SUM(price_amount)
FROM acquisition
WHERE term_code = 'cash'
AND acquired_at BETWEEN  '2011-01-01' AND '2013-12-31';



/*Задание 4. 
Отобразите имя, фамилию и названия аккаунтов людей в твиттере, у которых названия аккаунтов начинаются на 'Silver'.*/
SELECT
first_name,
last_name,
twitter_username
FROM people
WHERE twitter_username LIKE 'Silver%';


/*Задание 5. 
 Выведите на экран всю информацию о людях, у которых названия аккаунтов в твиттере содержат подстроку 'money', а фамилия начинается на 'K'. */
SELECT*
FROM people
WHERE twitter_username LIKE '%money%'
AND last_name LIKE 'K%' ;



/*Задание 6. 
Для каждой страны отобразите общую сумму привлечённых инвестиций, которые получили компании, зарегистрированные в этой стране. 
Страну, в которой зарегистрирована компания, можно определить по коду страны. Отсортируйте данные по убыванию суммы.*/
SELECT country_code,
SUM(funding_total) as sum_funding
FROM company
GROUP BY country_code
ORDER BY sum_funding DESC;



/*Задание 7. 
Составьте таблицу, в которую войдёт дата проведения раунда, а также минимальное и максимальное значения суммы инвестиций, привлечённых в эту дату.
Оставьте в итоговой таблице только те записи, в которых минимальное значение суммы инвестиций не равно нулю и не равно максимальному значению. */
SELECT funded_at,
MIN(raised_amount),
MAX(raised_amount)
FROM funding_round
GROUP BY funded_at
HAVING MIN(raised_amount) NOT IN (0, MAX(raised_amount));


/*Задание 8. 
Создайте поле с категориями:
Для фондов, которые инвестируют в 100 и более компаний, назначьте категорию high_activity.
Для фондов, которые инвестируют в 20 и более компаний до 100, назначьте категорию middle_activity.
Если количество инвестируемых компаний фонда не достигает 20, назначьте категорию low_activity.
Отобразите все поля таблицы fund и новое поле с категориями. */
SELECT *, 
CASE
        WHEN invested_companies >= 100  THEN 'high_activity'
        WHEN invested_companies BETWEEN  20 AND 100  THEN 'middle_activity'
        WHEN invested_companies < 20  THEN 'low_activity'
END
FROM fund;

/*Задание 9. 
Для каждой из категорий, назначенных в предыдущем задании, посчитайте округлённое до ближайшего целого числа среднее количество инвестиционных раундов, в которых фонд принимал участие. 
Выведите на экран категории и среднее число инвестиционных раундов. Отсортируйте таблицу по возрастанию среднего. */
SELECT ROUND(AVG(investment_rounds)) as avg_rounds,
CASE
        WHEN invested_companies >= 100  THEN 'high_activity'
        WHEN invested_companies BETWEEN  20 AND 100  THEN 'middle_activity'
        WHEN invested_companies < 20  THEN 'low_activity'
END
FROM fund
GROUP BY CASE
        WHEN invested_companies >= 100  THEN 'high_activity'
        WHEN invested_companies BETWEEN  20 AND 100  THEN 'middle_activity'
        WHEN invested_companies < 20  THEN 'low_activity'
END   
ORDER BY avg_rounds;    


/*Задание 10. 
Проанализируйте, в каких странах находятся фонды, которые чаще всего инвестируют в стартапы. 
Для каждой страны посчитайте минимальное, максимальное и среднее число компаний, в которые инвестировали фонды этой страны, основанные с 2010 по 2012 год включительно. 
Исключите страны с фондами, у которых минимальное число компаний, получивших инвестиции, равно нулю. Выгрузите десять самых активных стран-инвесторов.
Отсортируйте таблицу по среднему количеству компаний от большего к меньшему, а затем по коду страны в лексикографическом порядке. */
SELECT country_code,
MIN(invested_companies ),
MAX(invested_companies ),
AVG(invested_companies )
FROM fund
WHERE EXTRACT (year FROM CAST (founded_at  as timestamp)) BETWEEN 2010 and 2012
GROUP BY country_code
HAVING MIN(invested_companies ) > 0 
ORDER BY AVG(invested_companies ) DESC, country_code
limit 10;


/*Задание 11. 
Отобразите имя и фамилию всех сотрудников стартапов. Добавьте поле с названием учебного заведения, которое окончил сотрудник, если эта информация известна. */
SELECT p.first_name,
p.last_name,
e.instituition 
FROM people as p
LEFT JOIN education as e on p.id = e.person_id;



/*Задание 12. 
Для каждой компании найдите количество учебных заведений, которые окончили её сотрудники. 
Выведите название компании и число уникальных названий учебных заведений. Составьте топ-5 компаний по количеству университетов.*/
SELECT c.name,
COUNT(DISTINCT e.instituition)
FROM company AS c
JOIN people AS p ON c.id = p.company_id
JOIN education AS e ON p.id = e.person_id
GROUP BY c.name
ORDER BY COUNT(DISTINCT e.instituition) DESC
LIMIT 5;


/*Задание 13. 
Составьте список с уникальными названиями закрытых компаний, для которых первый раунд финансирования оказался последним. */
SELECT  DISTINCT(c.name)
FROM funding_round as fr
left join company as c ON fr.company_id = c.id
WHERE c.status = 'closed'
AND is_first_round = 1
AND  is_last_round = 1
;


/*Задание 14. 
Составьте список уникальных номеров сотрудников, которые работают в компаниях, отобранных в предыдущем задании. */
WITH
c AS (SELECT  DISTINCT(c.id)
FROM funding_round as fr
left join company as c ON fr.company_id = c.id
WHERE c.status = 'closed'
AND is_first_round = 1
AND  is_last_round = 1)
SELECT id
FROM people
WHERE company_id in c;

/*Задание 15. 
Составьте таблицу, куда войдут уникальные пары с номерами сотрудников из предыдущей задачи и учебным заведением, которое окончил сотрудник. */
SELECT DISTINCT(p.id),
e.instituition 
FROM people as p
INNER JOIN education as e ON p.id = e.person_id
WHERE company_id in (SELECT  DISTINCT(c.id)
FROM funding_round as fr
left join company as c ON fr.company_id = c.id
WHERE c.status = 'closed'
AND is_first_round = 1
AND  is_last_round = 1);

/*Задание 16. 
Посчитайте количество учебных заведений для каждого сотрудника из предыдущего задания. 
При подсчёте учитывайте, что некоторые сотрудники могли окончить одно и то же заведение дважды. */
SELECT p.id,
COUNT(e.instituition)
FROM people as p
INNER JOIN education as e ON p.id = e.person_id
WHERE company_id in (SELECT  DISTINCT(c.id)
FROM funding_round as fr
left join company as c ON fr.company_id = c.id
WHERE c.status = 'closed'
AND is_first_round = 1
AND  is_last_round = 1)
GROUP BY p.id;

/*Задание 17. 
Дополните предыдущий запрос и выведите среднее число учебных заведений (всех, не только уникальных), которые окончили сотрудники разных компаний. 
Нужно вывести только одну запись, группировка здесь не понадобится. */
WITH 
f AS (SELECT 
COUNT(e.instituition) as int
FROM people as p
INNER JOIN education as e ON p.id = e.person_id
WHERE company_id in (SELECT  DISTINCT(c.id)
FROM funding_round as fr
left join company as c ON fr.company_id = c.id
WHERE c.status = 'closed'
AND is_first_round = 1
AND  is_last_round = 1)
GROUP BY p.id)
SELECT AVG(f.int)
FROM f;

/*Задание 18. 
Напишите похожий запрос: выведите среднее число учебных заведений (всех, не только уникальных), которые окончили сотрудники Facebook.
(сервис, запрещённый на территории РФ) */
WITH
facebook AS 
        (SELECT p.id, 
         COUNT(e.instituition) as avg_un
FROM people as p
JOIN education as e ON p.id = e.person_id
JOIN company as c ON p.company_id = c.id
WHERE c.name= 'Facebook'
GROUP BY p.id)
SELECT AVG(avg_un)
FROM facebook;

/*Задание 19. 
Составьте таблицу из полей:
name_of_fund — название фонда;
name_of_company — название компании;
amount — сумма инвестиций, которую привлекла компания в раунде.
В таблицу войдут данные о компаниях, в истории которых было больше шести важных этапов, а раунды финансирования проходили с 2012 по 2013 год включительно. */
SELECT f.name AS name_of_fund,
c.name AS name_of_company,
fr.raised_amount AS amount
FROM investment AS i
LEFT JOIN company AS c ON c.id = i.company_id
LEFT JOIN fund AS f ON i.fund_id = f.id
INNER JOIN 
(SELECT*
FROM funding_round
WHERE funded_at BETWEEN '2012-01-01' AND '2013-12-31')
AS fr ON fr.id = i.funding_round_id
WHERE c.milestones > 6;

/*Задание 20. 
Выгрузите таблицу, в которой будут такие поля:
- название компании-покупателя;
- сумма сделки;
- название компании, которую купили;
- сумма инвестиций, вложенных в купленную компанию;
- доля, которая отображает, во сколько раз сумма покупки превысила сумму вложенных в компанию инвестиций, округлённая до ближайшего целого числа.
Не учитывайте те сделки, в которых сумма покупки равна нулю. Если сумма инвестиций в компанию равна нулю, исключите такую компанию из таблицы. 
Отсортируйте таблицу по сумме сделки от большей к меньшей, а затем по названию купленной компании в лексикографическом порядке. Ограничьте таблицу первыми десятью записями. */
WITH 
buyer as 
(SELECT a.acquiring_company_id,
c.name as acquiring_company, 
a.id,
a.price_amount 
FROM acquisition as a
LEFT JOIN company as c ON a.acquiring_company_id = c.id
where price_amount > 0),
seller as (
SELECT a.acquired_company_id ,
c.name as acquired_company, 
a.id,
funding_total     
FROM acquisition as a
LEFT JOIN company as c ON a.acquired_company_id  = c.id
WHERE funding_total >0)
SELECT buyer.acquiring_company,
buyer.price_amount, 
seller.acquired_company,
seller.funding_total,
ROUND(buyer.price_amount / seller.funding_total) 
FROM buyer 
JOIN seller ON buyer.id = seller.id
ORDER BY buyer.price_amount DESC,seller.acquired_company 
limit 10;



/*Задание 21. 
Выгрузите таблицу, в которую войдут названия компаний из категории social, получившие финансирование с 2010 по 2013 год включительно. 
Проверьте, что сумма инвестиций не равна нулю. Выведите также номер месяца, в котором проходил раунд финансирования. */
WITH 
a AS 
(SELECT 
id,
name
FROM company 
WHERE category_code = 'social')
SELECT a.name,
EXTRACT ( month  FROM CAST (fr.funded_at as timestamp)) as month
FROM funding_round as fr
JOIN a ON fr.company_id = a.id
WHERE funded_at  BETWEEN  '2010-01-01' AND '2013-12-31'
AND raised_amount > 0
and company_id in (SELECT id FROM a);                    

/*Задание 22. 
Отберите данные по месяцам с 2010 по 2013 год, когда проходили инвестиционные раунды. Сгруппируйте данные по номеру месяца и получите таблицу, в которой будут поля:
- номер месяца, в котором проходили раунды;
- количество уникальных названий фондов из США, которые инвестировали в этом месяце;
- количество компаний, купленных за этот месяц;
- общая сумма сделок по покупкам в этом месяце. */
WITH fund as
(SELECT EXTRACT(MONTH FROM CAST(fr.funded_at AS DATE)) AS funding_month,
COUNT(DISTINCT f.id) AS us_funds
FROM funding_round as fr
Join investment as i ON i.funding_round_id = fr.id 
join fund as f ON f.id = i.fund_id  
WHERE funded_at  BETWEEN  '2010-01-01' AND '2013-12-31'
AND  f.country_code = 'USA'
GROUP BY funding_month),
acquisitions AS
(SELECT EXTRACT(MONTH FROM CAST(acquired_at AS DATE)) AS funding_month,
COUNT(acquired_company_id) AS bought_co,
SUM(price_amount) AS sum_total
FROM acquisition
WHERE EXTRACT(YEAR FROM CAST(acquired_at AS DATE)) BETWEEN 2010 AND 2013
GROUP BY funding_month)
SELECT fnd.funding_month, fnd.us_funds, acq.bought_co, acq.sum_total
FROM fund AS fnd
LEFT JOIN acquisitions AS acq ON fnd.funding_month = acq.funding_month;

/*Задание 23. 
Составьте сводную таблицу и выведите среднюю сумму инвестиций для стран, в которых есть стартапы, зарегистрированные в 2011, 2012 и 2013 годах. 
Данные за каждый год должны быть в отдельном поле. Отсортируйте таблицу по среднему значению инвестиций за 2011 год от большего к меньшему. */
WITH y_11 AS
(SELECT country_code AS country,
AVG(funding_total) AS y_2011
FROM company
WHERE EXTRACT(YEAR FROM founded_at::DATE) IN(2011, 2012, 2013)
GROUP BY country, EXTRACT(YEAR FROM founded_at)
HAVING EXTRACT(YEAR FROM founded_at) = '2011'),
y_12 AS
(SELECT country_code AS country,
AVG(funding_total) AS y_2012
FROM company
WHERE EXTRACT(YEAR FROM founded_at::DATE) IN(2011, 2012, 2013)
GROUP BY country, EXTRACT(YEAR FROM founded_at)
HAVING EXTRACT(YEAR FROM founded_at) = '2012'),
y_13 AS
(SELECT country_code AS country,
AVG(funding_total) AS y_2013
FROM company
WHERE EXTRACT(YEAR FROM founded_at::DATE) IN(2011, 2012, 2013)
GROUP BY country, EXTRACT(YEAR FROM founded_at)
HAVING EXTRACT(YEAR FROM founded_at) = '2013')
SELECT y_11.country, y_2011, y_2012, y_2013
FROM y_11
JOIN y_12 ON y_11.country = y_12.country
JOIN y_13 ON y_12.country = y_13.country
ORDER BY y_2011 DESC;


