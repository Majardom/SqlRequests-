CREATE TABLE Employees (
    Id int NOT NULL IDENTITY PRIMARY KEY,
    LastName nvarchar(30),
    FirstName nvarchar(30)
);

CREATE TABLE Projects(
	Id int NOT NULL IDENTITY PRIMARY KEY,
	CurrentName nvarchar(30) NOT NULL,
	DateOfCreation date NOT NULL,
	IsOpened bit NOT NULL,
	DateOfClosing date
);

CREATE TABLE Tasks(
	Id int NOT NULL IDENTITY PRIMARY KEY,
	TaskInfo nvarchar(MAX) NOT NULL,
	Deadline date NOT NULL,
	EmployeeRole nvarchar(30) NOT NULL,
	ProjectId int NOT NULL FOREIGN KEY REFERENCES Projects(Id),
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id),
);


CREATE TABLE TaskStatuses(
	Id int NOT NULL IDENTITY PRIMARY KEY,
	NeedsAdditionalWork bit NOT NULL,
	IsCompleted bit NOT NULL,
	IsCLosed bit NOT NULL,
	DateOfLastChange date NOT NULL,
	StatusChangeEmployeeId int NOT NULL FOREIGN KEY REFERENCES Employees(Id),
	TaskId int NOT NULL UNIQUE FOREIGN KEY REFERENCES Tasks(Id)
);


INSERT INTO Employees(LastName, FirstName)
VALUES 
	('FirstEmployeeLastName', 'FirstEmployeeFirstName'),
	('SecondEmployeeLastName', 'SecondEmployeeFirstName'),
	('ThirdEmployeeLastName', 'ThirdEmployeeFirstName'),
	('FourthEmployeeLastName', 'FourthEmployeeFirstName'),
	('FifthEmployeeLastName', 'FifthEmployeeFirstName'),
	('SixthEmployeeLastName', 'SixthEmployeeFirstName'),
	('SeventhEmployeeLastName', 'SeventhEmployeeFirstName'),
	('EighthEmployeeLastName', 'EighthEmployeeFirstName'),
	('NinthEmployeeLastName', 'NinthEmployeeFirstName'),
	('TenthEmployeeLastName', 'TenthEmployeeFirstName'),
	('EleventhEmployeeLastName', 'EleventhEmployeeFirstName'),
	('TwelfthEmployeeLastName', 'TwelfthEmployeeFirstName'),
	('ThirdteenthEmployeeLastName', 'ThirdteenthEmployeeFirstName');

INSERT INTO Projects(CurrentName, DateOfCreation, IsOpened,DateOfClosing)
VALUES 
	('FirstProject', Convert(date, '190324'), 1, Convert(date, '190325')),
	('SecondProject',  Convert(date, '190324'), 1, Convert(date, '190326')),
	('ThirdProject',  Convert(date, '190324'), 1, Convert(date, '190327')),
	('ForthProject',  Convert(date, '190324'), 1, Convert(date, '190328'));

INSERT INTO Projects(CurrentName, DateOfCreation, IsOpened)
VALUES 
	('FifthProject',  Convert(date, '190324'), 1),
	('SixthProject',  Convert(date, '190324'), 1);


INSERT INTO Tasks(TaskInfo, Deadline, EmployeeRole, ProjectId)
VALUES
	('link',  CONVERT(date, '190331'), 'Senior developer', 1),
	('link',  CONVERT(date, '190331'), 'Resource manager', 1);

INSERT INTO Tasks(TaskInfo, Deadline, EmployeeRole, ProjectId, EmployeeId)
VALUES
	('link',  CONVERT(date, '190224'), 'Role', 2, 12),
	('link',  CONVERT(date, '190225'), 'Best Role EVER', 1, 8),
	('link',  CONVERT(date, '190226'), 'Some role', 1, 8),
	('link',  CONVERT(date, '190227'), 'Some role', 1, 8),
	('link',  CONVERT(date, '190324'), 'Role', 1, 13),
	('link',  CONVERT(date, '190328'), 'designer', 2, 2),
	('link',  CONVERT(date, '190329'), 'designer', 3, 3),
	('link',  CONVERT(date, '190330'), 'developer', 4, 4),
	('link',  CONVERT(date, '190331'), 'Resource manager', 5, 5),
	('link',  CONVERT(date, '190331'), 'Team leader', 2, 6),
	('link',  CONVERT(date, '190331'), 'Some role', 3, 7),
	('link',  CONVERT(date, '190331'), 'designer', 4, 1),
	('link',  CONVERT(date, '190324'), 'Role', 5, 11),
	('link',  CONVERT(date, '190324'), 'Role', 6, 11),
	('link',  CONVERT(date, '190324'), 'Role', 6, 11);
	

INSERT INTO TaskStatuses(NeedsAdditionalWork, IsCompleted, IsCLosed, DateOfLastChange, StatusChangeEmployeeId, TaskId)
VALUES
	(0, 0, 0, CONVERT(date, '190301'), 1, 1),
	(1, 0, 0, CONVERT(date, '190301'), 2, 2),
	(1, 0, 0, CONVERT(date, '190301'), 3, 3),
	(1, 0, 0, CONVERT(date, '190301'), 4, 4),
	(0, 1, 0, CONVERT(date, '190301'), 5, 5),
	(0, 1, 0, CONVERT(date, '190301'), 6, 6),
	(0, 0, 0, CONVERT(date, '190301'), 7, 7),
	(0, 0, 1, CONVERT(date, '190305'), 8, 8),
	(0, 0, 1, CONVERT(date, '190301'), 9, 9),
	(0, 0, 1, CONVERT(date, '190301'), 10, 10),
	(0, 0, 1, CONVERT(date, '190301'), 11, 11),
	(0, 0, 1, CONVERT(date, '190301'), 12, 12),
	(0, 0, 1, CONVERT(date, '190301'), 13, 13),
	(0, 0, 0, CONVERT(date, '190301'), 12, 14),
	(0, 0, 0, CONVERT(date, '190304'), 12, 15),
	(0, 0, 1, CONVERT(date, '190304'), 12, 16),
	(1, 0, 0, CONVERT(date, '190304'), 12, 17);



/*Get list of all employee roles in the company with the number of employees on each role*/
SELECT EmployeeRole, COUNT(EmployeeId) as NumberOfEmployees 
From Tasks
GROUP BY EmployeeRole;

/*Get list of employee roles without employees*/
SELECT EmployeeRole, Id as TaskId , ProjectId 
From Tasks
WHERE  EmployeeId IS NUll;

/*Get list of projects indicating employee roles with number of employees on each role*/
SELECT Tasks.ProjectId as ProjectId, Tasks.EmployeeRole as EmployeeRole, Count(Tasks.EmployeeRole) as NumberOfEmployees
FROM Tasks
GROUP BY Tasks.EmployeeRole, Tasks.ProjectId;
	
/*Get avarage number of tasks for each employee on each project*/
SELECT ProjectId, COUNT(Id) / COUNT(DISTINCT EmployeeId) as AvarageTaskCountForEmployee
FROM Tasks
WHERE EmployeeId IS NOT NULL 
Group BY ProjectId;

/*Get duration of each project*/
SELECT Id, DATEDIFF(day, DateOfCreation, DateOfClosing) as ProjectDuration
FROM Projects;

/*Get employees with the least number of opened tasks*/
DECLARE @min int
DECLARE @EmployeeNumberOfOpenedTasksTable Table(EmployeeId int, NumberOfOpenedTasks int)

INSERT  INTO @EmployeeNumberOfOpenedTasksTable 
SELECT Tasks.EmployeeId, COUNT(Tasks.Id)
FROM Tasks
INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.TaskId
WHERE TaskStatuses.IsCLosed <> 1
GROUP BY Tasks.EmployeeId

SELECT  @min = MIN(NumberOfOpenedTasks)
FROM @EmployeeNumberOfOpenedTasksTable

SELECT EmployeeId 
FROM @EmployeeNumberOfOpenedTasksTable 
WHERE NumberOfOpenedTasks = @min

/*Get employees with the gratest number of opened tasks with expired deadline*/
DECLARE @max int
DECLARE @EmployeeNumberOfOpenedTasksTableWithEndedDeadline Table(EmployeeId int, NumberOfOpenedTasks int)

INSERT  INTO @EmployeeNumberOfOpenedTasksTableWithEndedDeadline 
SELECT Tasks.EmployeeId, COUNT(Tasks.Id)
FROM Tasks
INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.TaskId
WHERE TaskStatuses.IsCLosed <> 1 and Tasks.Deadline < CURRENT_TIMESTAMP
GROUP BY Tasks.EmployeeId 

SELECT @max = MAX(NumberOfOpenedTasks)
FROM @EmployeeNumberOfOpenedTasksTableWithEndedDeadline

SELECT EmployeeId 
FROM @EmployeeNumberOfOpenedTasksTableWithEndedDeadline 
WHERE NumberOfOpenedTasks = @max

/*Extend the period of opened tasks for 5 days*/
GO  
IF OBJECT_ID('OpenedTasks', 'P') IS NOT NULL  
   DROP PROCEDURE ExtendThePeriodOfOpenedTasks; 
GO
	CREATE PROCEDURE ExtendThePeriodOfOpenedTasks (@NumberOfDaysToAdd int)
AS
BEGIN
	UPDATE Tasks
	Set Deadline = DATEADD(day, @NumberOfDaysToAdd, Deadline)
	WHERE Id in
	(SELECT Tasks.Id  
	FROM Tasks
	INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.TaskId
	WHERE TaskStatuses.IsCLosed <> 1)
END
GO

EXECUTE ExtendThePeriodOfOpenedTasks @NumberOfDaysToAdd = 5

/*Get list of projects with number of tasks without employee*/
SELECT ProjectId, COUNT(Tasks.Id) as NumberOfTasksWithoutEmployee
FROM Tasks
WHERE EmployeeId IS NULL
GROUP BY ProjectId

/*Set project status as closed for projects with all tasks closed and set time of closing equal to time of closing of the last task*/
GO  
IF OBJECT_ID('OpenedTasks', 'FN') IS NOT NULL  
   DROP FUNCTION OpenedTasks; 
GO
	CREATE FUNCTION OpenedTasks (@ProjectId int)
	RETURNS int
AS
BEGIN
	DECLARE @Count int
	SELECT @Count = Count(Tasks.Id)
	FROM Tasks
	INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.TaskId
	WHERE Tasks.ProjectId = @ProjectId and TaskStatuses.IsCLosed = 0
	GROUP BY ProjectId
	RETURN @Count
END
GO


DECLARE @ProjectDateOfClosingTable TABLE (ProjectId int, DateOfClosing date)

INSERT INTO @ProjectDateOfClosingTable 
SELECT TasksForProjectClosing.ProjectId, MAX(TaskStatuses.DateOfLastChange) as DateForClosedProject
FROM (SELECT * 
	FROM Tasks
	WHERE dbo.OpenedTasks(ProjectId) IS NULL) as TasksForProjectClosing
INNER JOIN TaskStatuses ON TasksForProjectClosing.Id = TaskStatuses.TaskId
GROUP BY TasksForProjectClosing.ProjectId


UPDATE Projects 
SET    DateOfClosing = (SELECT DateOfClosing 
                          FROM   @ProjectDateOfClosingTable 
                          WHERE  Projects.Id = ProjectId),
		IsOpened = 0
	
WHERE Projects.Id IN (SELECT ProjectId FROM @ProjectDateOfClosingTable)

/*Get through all projects list of employees without opened tasks*/
SELECT ClosedTasks.EmployeeId, ClosedTasks.ProjectId
FROM	(SELECT Tasks.EmployeeId as EmployeeId, Tasks.ProjectId as ProjectId, COUNT(TaskId) as NumberOfClosedTasks
		FROM Tasks 
		INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.Id
		WHERE TaskStatuses.IsCLosed = 1 and EmployeeId IS NOT NULL 
		GROUP BY Tasks.EmployeeId, Tasks.ProjectId) as ClosedTasks
INNER JOIN (SELECT Tasks.EmployeeId as EmployeeId, Tasks.ProjectId, COUNT(TaskId) as NumberOfAllTasks
			FROM Tasks 
			INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.Id
			WHERE  EmployeeId IS NOT NULL 
			GROUP BY Tasks.EmployeeId, Tasks.ProjectId) as AllTasks ON ClosedTasks.EmployeeId = AllTasks.EmployeeId AND ClosedTasks.ProjectId = AllTasks.ProjectId
WHERE ClosedTasks.NumberOfClosedTasks = AllTasks.NumberOfAllTasks

/*12.Заданную задачу проекта перевести на сотрудника с
минимальным количеством выполняемых им задач*/
/*Give selected task to an employee with the least number of opened tasks*/
GO  
IF OBJECT_ID('UpdeteTaskFroEmployee', 'P') IS NOT NULL  
   DROP PROCEDURE UpdeteTaskFroEmployee; 
GO
	CREATE PROCEDURE UpdeteTaskFroEmployee (@ProjectId int, @TaskId int)
AS
	DECLARE @EmployeeNUmberOfOpenedTasksTable TABLE (EmployeeId int, NumberOfTasks int)
	DECLARE @MinNumberOfTasks int

	INSERT INTO @EmployeeNUmberOfOpenedTasksTable SELECT Tasks.EmployeeId, COUNT(TaskId) as NumberOpenedTasks
	FROM Tasks 
	INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.Id
	WHERE TaskStatuses.IsCLosed <> 1 and EmployeeId IS NOT NULL and Tasks.ProjectId = @ProjectId 
	GROUP BY Tasks.EmployeeId, Tasks.ProjectId

	SELECT @MinNumberOfTasks = NumberOfTasks FROM @EmployeeNUmberOfOpenedTasksTable

	UPDATE Tasks
	SET EmployeeId = (SELECT TOP 1 EmployeeId 
					  FROM @EmployeeNUmberOfOpenedTasksTable
					  WHERE NumberOfTasks = @MinNumberOfTasks)
	WHERE Tasks.Id = @TaskId
GO

EXECUTE UpdeteTaskFroEmployee @ProjectId = 1, @TaskId = 4

SELECT Tasks.EmployeeId, TaskId 
FROM Tasks 
INNER JOIN TaskStatuses ON Tasks.Id = TaskStatuses.Id
WHERE TaskStatuses.IsCLosed <> 1 and EmployeeId IS NOT NULL and Tasks.ProjectId = 1

DROP TABLE TaskStatuses
DROP TABLE Tasks
DROP TABLE Projects
DROP TABLE Employees

