USE world;
/*Question 1. 76 rows returned*/
SELECT country.Name, Language, Percentage
FROM country
	JOIN countrylanguage
		ON Code = CountryCode
WHERE Percentage > 90
ORDER BY Percentage;

/*Question 2. 76 rows returned*/
SELECT country.Name, Language, Percentage
FROM country, countrylanguage
WHERE Code = CountryCode AND Percentage > 90
ORDER BY Percentage;

/*Question 3. 421 rows returned*/
SELECT country.Name AS Country, city.Name AS City, countrylanguage.Language AS Language
FROM countrylanguage
	JOIN country
		ON Code = countrylanguage.CountryCode
			JOIN city
				ON city.CountryCode = Code
WHERE Language = 'Spanish' AND Percentage >= 75
ORDER BY country.Name, city.Name;

/*Question 4. 2060 rows returned*/
SELECT city.Name, Language, Population
FROM city	
	JOIN countrylanguage
		USING (CountryCode)
WHERE Population > 900000
ORDER BY Population DESC;

/*Question 5. 2060 rows returned*/
SELECT city.Name, Language, Population
FROM city
	NATURAL JOIN countrylanguage
WHERE Population > 900000
ORDER BY Population DESC;    

/*Question 6. 30670 rows returned*/
SELECT city.Name AS City, Language
FROM city	
	LEFT OUTER JOIN countrylanguage
		USING (CountryCode);
        
/*Question 7. 30671 rows returned*/
SELECT city.Name AS City, Language
FROM city	
	RIGHT OUTER JOIN countrylanguage
		USING (CountryCode);

/*Question 8. 239 rows returned*/
SELECT Name AS CountryName, 'Small' AS Population
FROM country
WHERE Population < 1000000
UNION
SELECT Name AS CountryName, 'Medium' AS Population
FROM country
WHERE Population >= 1000000 AND Population < 3000000
UNION
SELECT Name AS CountryName, 'Large' AS Population
FROM country
WHERE Population >= 3000000
ORDER BY CountryName;

USE ex;
/*Question 9. 6 rows returned*/
SELECT 
	CONCAT (emp.first_name, ' ', emp.last_name) AS Employees,
	CONCAT (mngr1.first_name, ' ', mngr1.last_name) AS '1st level managers',
    CONCAT (mngr2.first_name, ' ', mngr2.last_name) AS '2nd level managers'
FROM employees emp
	JOIN employees mngr1
		ON emp.manager_id = mngr1.employee_id
	JOIN employees mngr2
		ON mngr1.manager_id = mngr2.employee_id
ORDER BY emp.last_name, emp.first_name;

/*Question 10. 72 rows returned*/
SELECT 
    CONCAT (emp1.last_name, ',', emp1.first_name) AS Interviewer, 
    CONCAT (emp2.last_name, ',', emp2.first_name) AS Interviewee
FROM employees AS emp1
    CROSS JOIN employees AS emp2
WHERE
    emp1.employee_id <> emp2.employee_id
ORDER BY emp1.last_name, emp1.first_name;
    
USE sakila;
/*Question 11. 53 rows returned*/
SELECT first_name, city, district, postal_code
FROM customer
	JOIN address
		USING (address_id)
	JOIN city
		USING (city_id)
	JOIN country
		USING (country_id)
WHERE country = 'China';
        
/*Question 12. 83 rows returned*/
SELECT DISTINCT first_name, last_name, title, length
FROM actor 
	JOIN film_actor
		USING (actor_id)
	JOIN film
		USING (film_id)
WHERE last_name = 'Johansson';

/*Question 13. 62 rows returned*/
SELECT title AS 'Movie Title', category.name AS Category, language.name AS Language
FROM language
	JOIN film
		USING (language_id)
	JOIN film_category
		USING (film_id)
	JOIN category
		USING (category_id)
WHERE category.name = 'drama' AND language.name = 'english';

/*
Table 1: attraction
Key					Name			Data Type, Size				Null 
PK					IDAttr			INT(11)						NN
					Name 			VARCHAR(50)					NN
					Popularity		INT(2)						N
					OpenYear		INT(4)						N (for some attractions that haven't opened yet)

Table 2: city_attraction
Key					Name			Data Type, Size				Null 
PK(composite), FK	IDAttr			copy						NN
PK(composite), FK	city.ID			copy						NN
*/