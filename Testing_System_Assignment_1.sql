DROP DATABASE IF EXISTS testingsystem;

CREATE DATABASE testingsystem;

USE testingsystem;

/*department*/
DROP TABLE IF EXISTS department;

CREATE TABLE department (
	DepartmentID 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName 	VARCHAR(50) NOT NULL UNIQUE
);

/*postion*/
DROP TABLE IF EXISTS position;

CREATE TABLE position (
	PositionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	ENUM ('Dev', 'Test', 'Scrum Master', 'PM')
);

ALTER TABLE position MODIFY COLUMN PositionName ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master', 'Tester');

/* account */
DROP TABLE IF EXISTS account; 

CREATE TABLE `account` (
	AccountID		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email 			VARCHAR(50) UNIQUE,
    UserName		VARCHAR(50) NOT NULL,
    FullName		VARCHAR(50),
    DepartmentID	TINYINT UNSIGNED,
    PositionID		TINYINT UNSIGNED,
    CreatedDate		DATETIME,
    CONSTRAINT fk_account_department	FOREIGN KEY (DepartmentID)	REFERENCES department (DepartmentID)	ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_account_position		FOREIGN KEY (PositionID)	REFERENCES	position (PositionID) 		ON DELETE SET NULL ON UPDATE CASCADE
    );

/* group */
DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
	GroupID		MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
    GroupName 	VARCHAR(50) NOT NULL,
    CreatorID	MEDIUMINT UNSIGNED, 
    CreatedDate	DATETIME
    );
    
/* groupaccount */
DROP TABLE IF EXISTS groupaccount;

CREATE TABLE groupaccount (
	GroupID		MEDIUMINT,
    AccountID	MEDIUMINT,
    JoinDate	DATETIME DEFAULT NOW()
);

/* typequestion */
DROP TABLE IF EXISTS typequestion;

CREATE TABLE typequestion (
	TypeID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    TypeName	VARCHAR(50)
);

/* categoryquestion */
DROP TABLE IF EXISTS categoryquestion;

CREATE TABLE categoryquestion (
	CategoryID 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CatergoryName	ENUM('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS', 'HTML', 'CSS', 'JavaScript')
);

/* question */
DROP TABLE IF EXISTS question;

CREATE TABLE question (
	QuestionID	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content 	VARCHAR(50),
    CategoryID	TINYINT UNSIGNED,
    TypeID		TINYINT UNSIGNED,
    CreatorID	MEDIUMINT UNSIGNED,
    CreatedDate	DATETIME,
    CONSTRAINT question FOREIGN KEY (CreatorID) REFERENCES `account` (AccountID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_question_catergoryquestion FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_question_typequestion FOREIGN KEY (typeID) REFERENCES typequestion (TypeID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* answer */
DROP TABLE IF EXISTS answer;

CREATE TABLE answer (
	AnswerID	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Content		VARCHAR(50),
    QuestionID	TINYINT UNSIGNED,
    IsCorrect	BIT,
    CONSTRAINT	fk_answer_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* exam */
DROP TABLE IF EXISTS exam;

CREATE TABLE exam (
	ExamID		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code` 		VARCHAR(20) NOT NULL,
    Title		VARCHAR(50) NOT NULL,
    CategoryID	TINYINT UNSIGNED,
    Duration	TINYINT,
    CreatorID	MEDIUMINT UNSIGNED,
    CreatedDate	DATETIME,
    CONSTRAINT fk_exam_account FOREIGN KEY (CreatorID) 	REFERENCES `account` (AccountID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_exam_categoryquestion FOREIGN KEY (CategoryID) REFERENCES categoryquestion (CategoryID) ON DELETE SET NULL ON UPDATE CASCADE
);

/* examquestion */
DROP TABLE IF EXISTS examquestion;

CREATE TABLE examquestion (
	ExamID TINYINT UNSIGNED, 
    QuestionID TINYINT  UNSIGNED, 
    CONSTRAINT fk_examquestion_exam FOREIGN KEY (ExamID) REFERENCES exam (ExamID) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_examquestion_question FOREIGN KEY (QuestionID) REFERENCES question (QuestionID) ON DELETE SET NULL ON UPDATE CASCADE
    );
    

