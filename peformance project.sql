use da;
select * from employee_performance_dataset;
-- Count total employees
select count(employee_id) as no_of_rows from employee_performance_dataset;
-- Unique departments
select distinct department from employee_performance_dataset;
-- Unique team leads
select distinct team_lead from employee_performance_dataset;
-- Update example (change target tasks)
set sql_safe_updates = 0;
update employee_performance_dataset set target_tasks = 80 where employee_id = 101;
-- Delete record
delete from employee_performance_dataset where employee_id = 102;
-- Insert new employee
insert into employee_performance_dataset (employee_id, employee_name, department, team_lead, month, tasks_completed, target_tasks, quality_score, attendance)
values (121, 'Ameen', 'Sales', 'Rahul', 'Apr', 40, 50, 8, 90);
select * from employee_performance_dataset;
-- Employees who achieved target
select employee_name from employee_performance_dataset where tasks_completed >= target_tasks;
-- Employees who did NOT achieve target
select employee_name from employee_performance_dataset where tasks_completed < target_tasks;
-- Total tasks completed by department
select department, sum(tasks_completed) from employee_performance_dataset group by department;
-- Average quality score by department
select department, avg(quality_score) from employee_performance_dataset group by department;
-- Department with highest productivity
select team_lead, avg(quality_score) from employee_performance_dataset group by team_lead;
-- Tasks completed per month
select month, sum(tasks_completed) from employee_performance_dataset group by month;
-- Average attendance per month
select month, avg(attendance) from employee_performance_dataset group by month;
-- Top 5 employees by tasks completed
select employee_name, tasks_completed from employee_performance_dataset order by tasks_completed limit 5;
