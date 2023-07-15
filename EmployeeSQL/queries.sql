-- 1.List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no,
	e.last_name, 
	e.first_name, 
	e.sex, 
	s.salary
FROM employees e
LEFT JOIN salaries s
	ON e.emp_no=s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, 
	last_name, 
	hire_date
FROM employees
WHERE hire_date LIKE '%1986';

-- 3.List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT m.dept_no, 
	d.dept_name, 
	e.emp_no, 
	e.last_name, 
	e.first_name
	FROM dept_manager m
	LEFT JOIN departments d
		ON m.dept_no=d.dept_no
	LEFT JOIN employees e
		ON m.emp_no=e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT de.dept_no, 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	d.dept_name
FROM employees e
LEFT JOIN dept_emp de
	ON e.emp_no=de.emp_no
LEFT JOIN departments d
	ON de.dept_no=d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, 
	last_name, 
	sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

SELECT emp_no, 
	sales_dept_employee_number, 
	last_name, 
	first_name
FROM employees
WHERE emp_no IN
	(SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN
	 	(SELECT dept_no
		FROM departments
		WHERE dept_name = 'Sales'
		)
	);

-- 7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, 
	e.last_name, 
	e.first_name, 
	d.dept_name department_name
	FROM employees e
	LEFT JOIN dept_emp
	ON e.emp_no=dept_emp.emp_no
	LEFT JOIN departments d
	ON dept_emp.dept_no=d.dept_no
	WHERE e.emp_no IN 
		(SELECT emp_no
		FROM dept_emp
		WHERE dept_no IN
	 		(SELECT dept_no
			FROM departments
			WHERE dept_name = 'Sales' or dept_name = 'Development'
		)
	);
	
-- 8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(last_name) as Frequency
	FROM employees
	GROUP BY last_name 
	ORDER BY Frequency DESC;