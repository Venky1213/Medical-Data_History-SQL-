use project_medical_data_history;


-- 1. . Show first name, last name, and gender of patients who's gender is 'M'.
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';


-- 2. Show first name and last name of patients who does not have allergies.
SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL;

-- 3. Show first name of patients that start with the letter 'C'.
SELECT first_name
FROM patients
WHERE first_name LIKE 'C%';

-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive).
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

set sql_safe_updates =0;

-- 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'.
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;


-- 6. Show first name and last name concatenated into one column to show their full name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- 7. Show first name, last name, and the full province name of each patient.
SELECT p.first_name, p.last_name, pn.province_name
FROM patients AS p
JOIN province_names AS pn ON p.province_id = pn.province_id;

-- 8. Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS patients_born_in_2010
FROM patients
WHERE YEAR(birth_date) = 2010;

-- 9. Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT MAX(height) FROM patients);

-- 10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT *
FROM patients
WHERE patient_id IN (1, 45, 534, 879, 1000);

-- 11. Show the total number of admissions.
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- 13. Show the total number of admissions for patient_id 579.
SELECT COUNT(*) AS admissions_for_patient_579
FROM admissions
WHERE patient_id = 579;

-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';

-- 15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70.
SELECT first_name, last_name, birth_date
FROM patients
WHERE height > 160 AND weight > 70;

-- 16. Show unique birth years from patients and order them by ascending.
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
WHERE birth_date IS NOT NULL
ORDER BY birth_year ASC;

-- 17. Show unique first names from the patients table which only occurs once in the list.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(*) = 1;

-- 18. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%s'
  AND CHAR_LENGTH(first_name) >= 6;

-- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table.
SELECT DISTINCT p.patient_id, p.first_name, p.last_name
FROM patients AS p
JOIN admissions AS a ON p.patient_id = a.patient_id
WHERE a.diagnosis = 'Dementia';

-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
SELECT first_name
FROM patients
ORDER BY CHAR_LENGTH(first_name) ASC, first_name ASC;

-- 21. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
SELECT
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_patients,
  SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_patients
FROM patients;

-- 22. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
SELECT
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_patients,
  SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_patients
FROM patients;

-- 23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis, COUNT(*) AS admission_count
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;

-- 24. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

-- 25. . Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS role
FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;

-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
SELECT allergies, COUNT(*) AS allergy_count
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY allergy_count DESC, allergies ASC;

-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date
FROM patients
WHERE birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC;

-- 28. LAST_NAME uppercase, first_name lowercase, first-name descending
SELECT CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

-- 29. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT province_id, SUM(height) AS total_height
FROM patients
GROUP BY province_id
HAVING SUM(height) >= 7000;

-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'.
SELECT MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
SELECT
    days.day_of_month,
    COUNT(a.admission_date) AS admission_count
FROM (
    SELECT 1 AS day_of_month UNION ALL
    SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9 UNION ALL SELECT 10
    UNION ALL SELECT 11 UNION ALL SELECT 12
    UNION ALL SELECT 13 UNION ALL SELECT 14
    UNION ALL SELECT 15 UNION ALL SELECT 16
    UNION ALL SELECT 17 UNION ALL SELECT 18
    UNION ALL SELECT 19 UNION ALL SELECT 20
    UNION ALL SELECT 21 UNION ALL SELECT 22
    UNION ALL SELECT 23 UNION ALL SELECT 24
    UNION ALL SELECT 25 UNION ALL SELECT 26
    UNION ALL SELECT 27 UNION ALL SELECT 28
    UNION ALL SELECT 29 UNION ALL SELECT 30
    UNION ALL SELECT 31
) AS days
LEFT JOIN admissions AS a
    ON DAY(a.admission_date) = days.day_of_month
GROUP BY days.day_of_month
ORDER BY admission_count DESC, days.day_of_month ASC;

-- 32. Patient counts by weight group (100-109 => 100, 110-119 => 110)
SELECT FLOOR(weight / 10) * 10 AS weight_group,
       COUNT(*) AS total_patients
FROM patients
WHERE weight IS NOT NULL
GROUP BY FLOOR(weight / 10) * 10
ORDER BY weight_group DESC;

-- 33. Obesity flag using BMI >= 30; height is stored in centimetres BMI = weight(kg) / (height in metres squared)
SELECT patient_id, weight, height,
       CASE
         WHEN height IS NOT NULL AND height > 0
              AND weight / POWER(height / 100.0, 2) >= 30 THEN 1
         ELSE 0
       END AS isObese
FROM patients;

-- 34. Patients diagnosed with Epilepsy whose attending doctor's first name is Lisa
SELECT DISTINCT p.patient_id, p.first_name, p.last_name, d.specialty
FROM patients AS p
JOIN admissions AS a ON p.patient_id = a.patient_id
JOIN doctors AS d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
  AND d.first_name = 'Lisa';

