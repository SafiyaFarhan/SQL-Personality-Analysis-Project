
-- SQL Project: Personality Dataset Analysis

-- Dataset contains 30 columns, mostly real numbers, and one text field: personality_type

-- 🔍 Basic Exploration

-- 1. How many records are there in the dataset?
SELECT COUNT (*)
FROM personality_synthetic_dataset

-- 2. How many distinct personality types are present?
SELECT COUNT (DISTINCT personality_type)
FROM personality_synthetic_dataset

-- 3. How many people belong to each personality type?
SELECT COUNT (*) AS numeber_of_people,
personality_type
FROM personality_synthetic_dataset
GROUP BY personality_type
 

-- 4. What is the average social_energy score for each personality type?
SELECT 
ROUND (AVG (CAST (social_energy AS REAL))) AS average_social_energy,
personality_type
FROM personality_synthetic_dataset
GROUP BY personality_type

-- 5. What is the highest empathy score recorded in the dataset?
SELECT 
ROUND (MAX (CAST (empathy AS REAL))) AS maximum_empathy
FROM personality_synthetic_dataset

-- 6. What is the average empathy, creativity, and leadership score for each personality type?
SELECT 
ROUND (AVG (CAST (empathy AS REAL))) AS average_empathy,
ROUND (AVG (CAST (creativity AS REAL))) AS average_creativity,
ROUND (AVG (CAST (leadership AS REAL))) AS average_leadership,
personality_type
FROM personality_synthetic_dataset
GROUP BY personality_type
ORDER BY personality_type

-- 📊 Sorting & Grouping

-- 7. Which personality type has the highest average risk_taking score?
SELECT 
ROUND (AVG (CAST (risk_taking AS REAL))) AS average_risk_taking,
personality_type
FROM personality_synthetic_dataset
GROUP BY personality_type
ORDER BY average_risk_taking DESC
LIMIT 1

-- 8. What are the top 5 personality_type and creativity combinations with the highest creativity scores?
SELECT 
ROUND (AVG (CAST (creativity AS REAL))) AS average_creativity,
personality_type, 
creativity
FROM personality_synthetic_dataset
GROUP BY personality_type, creativity
ORDER BY average_creativity DESC
LIMIT 5


-- 9. Show the average stress_handling for each personality type, only where the average is above 5.
SELECT 
ROUND (AVG (CAST (stress_handling AS REAL))) AS average_stress_handling,
personality_type, 
stress_handling
FROM personality_synthetic_dataset
GROUP BY personality_type, stress_handling
HAVING ROUND (AVG (CAST (stress_handling AS REAL))) > 5
ORDER BY average_stress_handling DESC

-- 🧠 Filtering & Conditions

-- 10. How many individuals have a deep_reflection score greater than 8?
SELECT COUNT (deep_reflection) AS count_of_individuals
FROM personality_synthetic_dataset
WHERE CAST (deep_reflection AS REAL) > 8

-- 11. How many individuals have both routine_preference and planning above 7?
SELECT COUNT (*) AS count_of_all
FROM personality_synthetic_dataset
WHERE CAST (routine_preference AS REAL) > 7 
AND CAST ( planning AS REAL) > 7

-- 12. Find all individuals where public_speaking_comfort is below 4 and leadership is above 7.
SELECT COUNT (*) AS fullcount
FROM personality_synthetic_dataset
WHERE CAST (public_speaking_comfort AS REAL) < 4
AND CAST ( leadership AS REAL) > 7

-- 13. What’s the average gadget_usage for individuals with online_social_usage greater than 8?
SELECT ROUND (AVG (CAST(gadget_usage AS REAL))) AS Average_usage
FROM personality_synthetic_dataset
WHERE CAST (online_social_usage AS REAL) > 8

-- 🔡 String & Math Functions

-- 14. Show personality types in UPPERCASE along with average emotional_stability.
SELECT ROUND (AVG (CAST(emotional_stability AS REAL))) AS Average_stability,
UPPER (personality_type)
FROM personality_synthetic_dataset
GROUP BY UPPER (personality_type)
ORDER BY UPPER (personality_type) 

-- 15. Round the average of decision_speed and stress_handling for each personality type to 2 decimal places.
SELECT ROUND (AVG (CAST(decision_speed AS REAL) :: NUMERIC), 2) AS Average_decision_speed,  -- type casted twice since with average around there was double precision giving error so casted avergae to NUMERIC which is a extra precise numeric data type that stores exact deciaml values. the first casting was done to change the data type to allow average to work on a field that was assigned data type TEXT 
ROUND (AVG (CAST(stress_handling AS REAL) :: NUMERIC), 2) AS Average_stress_handling,
personality_type
FROM personality_synthetic_dataset
GROUP BY personality_type
ORDER BY personality_type

-- 16. What is the length of each personality_type string and how often do they occur?
SELECT  
LENGTH (personality_type) AS total_length,
COUNT (personality_type) AS count_of_personality,
personality_type
FROM personality_synthetic_dataset
GROUP BY personality_type
ORDER BY personality_type

-- 📈 Bonus Analytics

-- 17. Which personality type has the highest average adventurousness?
SELECT 
personality_type,
ROUND (AVG (CAST (adventurousness AS REAL)):: NUMERIC) AS Average
FROM personality_synthetic_dataset
GROUP BY personality_type
LIMIT 1

-- 18. What are the average scores for reading_habit, travel_desire, and sports_interest by personality type?
SELECT 
personality_type,
ROUND (AVG (CAST (sports_interest AS REAL)):: NUMERIC) AS Average_sports_interest,
ROUND (AVG (CAST (reading_habit AS REAL)):: NUMERIC) AS Average_reading,
ROUND (AVG (CAST (travel_desire AS REAL)):: NUMERIC) AS Average_travel
FROM personality_synthetic_dataset
GROUP BY personality_type
ORDER BY personality_type

-- 19. What is the total sum of excitement_seeking scores for all Extroverts?
SELECT 
ROUND (SUM (CAST (excitement_seeking AS REAL)):: NUMERIC) AS total_excitement
FROM personality_synthetic_dataset
WHERE personality_type = 'Extrovert'

-- 20. Compare average work_style_collaborative between Introverts and Extroverts.
SELECT 
personality_type,
ROUND (AVG (CAST (work_style_collaborative AS REAL)):: NUMERIC) AS average_work_style
FROM personality_synthetic_dataset
WHERE personality_type IN ('Introvert', 'Extrovert')
GROUP BY personality_type
ORDER BY personality_type
