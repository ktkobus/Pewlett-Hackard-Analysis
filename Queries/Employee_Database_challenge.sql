-- Retirement Titles table creation
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01'AND '1955-12-31')
ORDER BY e.emp_no;

SELECT *
FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Number of employees retiring by title
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Employees eligible for mentorship program
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-21')
ORDER BY e.emp_no;

-- New Queries

SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retiring_year_one
FROM employees as e
LEFT JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01'AND '1952-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT(emp_no), title
INTO wave_one
FROM retiring_year_one
GROUP BY title
ORDER BY count DESC;

SELECT *
FROM wave_one;

SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retiring_year_four
FROM employees as e
LEFT JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1955-01-01'AND '1955-12-31')
	AND (t.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT(emp_no), title
INTO final_wave
FROM retiring_year_four
GROUP BY title
ORDER BY count DESC;

SELECT *
FROM final_wave;