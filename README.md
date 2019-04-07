# SqlRequests
Work with sql requests to database.

### Database requirements
Database have to store information about:
- employees, who works on a projects(project data: name, date of creation, status open/closed, 
date of closing).
- employee can work on several projects and on each project he/she can have different role
- task for employee are given with specified deadline. Task can have different statuses: open, completed, need additional work, 
accepted, with specified date of last status change and specified employee, who changed the status.  

### Tables description
- Employees: Table stores information about employee;
- Projects: Table stores information about projects;
- Tasks: Table stores information about tasks on each projetc for each employee(Realization of many-to-many relationship Employee-Project);
- TaskStatuses: Table stroes inforamtion about status of each task. 


### SQl requsests list
- Get list of all employee roles in the company with the number of employees on each role;
- Get list of employee roles without employees;
- Get list of projects indicating employee roles with number of employees on each role;
- Get avarage number of tasks for each employee on each project;
- Get duration of each project;
- Get employees with the least number of opened tasks;
- Get employees with the gratest number of opened tasks with expired deadline;
- Extend the period of opened tasks for 5 days;
- Get list of projects with number of tasks without employee;
- Set project status as closed for projects with all tasks closed and set time of closing equal to time of closing of the last task;
- Get through all projects list of employees without opened tasks;
- Give selected task to an employee with the least number of opened tasks.
