DROP SCHEMA if exists TAZEDaily;
CREATE SCHEMA TAZEDaily;
USE TAZEDaily;
CREATE TABLE if not exists USER(
    ID BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    LOGIN CHARACTER VARYING(50) NOT NULL,
    PASSWORD CHARACTER VARYING(60) NOT NULL,
    FIRST_NAME CHARACTER VARYING(50),
    LAST_NAME CHARACTER VARYING(50),
    EMAIL CHARACTER VARYING(191),
    IMAGE_URL CHARACTER VARYING(255)
);             
-- ALTER TABLE USER ADD CONSTRAINT PK_USER PRIMARY KEY(ID);       
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.USER; 
INSERT INTO USER VALUES(1, 'admin', '$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC', 'Administrator', 'Administrator', 'admin@localhost', '');     
INSERT INTO USER VALUES(2, 'user', '$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K', 'User', 'User', 'user@localhost', '');         
CREATE TABLE if not exists AUTHORITY(
    ROLE CHARACTER VARYING(50) PRIMARY KEY NOT NULL
);     
-- ALTER TABLE AUTHORITY ADD CONSTRAINT PK_AUTHORITY PRIMARY KEY(NAME);           
-- 2 +/- SELECT COUNT(*) FROM PUBLIC.AUTHORITY;            
INSERT INTO AUTHORITY VALUES('ADMIN');     
INSERT INTO AUTHORITY VALUES('USER');      
CREATE TABLE if not exists USER_AUTHORITY(
    LOGIN CHARACTER VARYING(50) PRIMARY KEY NOT NULL,
    AUTHORITY_ROLE CHARACTER VARYING(50) NOT NULL
);       
-- ALTER TABLE USER_AUTHORITY ADD CONSTRAINT CONSTRAINT_E PRIMARY KEY(USER_ID, AUTHORITY_NAME);     
-- 3 +/- SELECT COUNT(*) FROM PUBLIC.USER_AUTHORITY;       
INSERT INTO USER_AUTHORITY VALUES('admin', 'ADMIN');            
INSERT INTO USER_AUTHORITY VALUES('user', 'USER');              
CREATE TABLE if not exists COMMENT(
    ID BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    BODY CHARACTER VARYING(255),
    AUTHOR CHARACTER VARYING(255),
    TIME_STAMP DATE,
    NEWS_ARTICLE_ID BIGINT,
    USER_ID BIGINT
);     
-- ALTER TABLE COMMENT ADD CONSTRAINT PK_COMMENT PRIMARY KEY(ID);               
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.COMMENT;             
CREATE TABLE if not exists NEWS_ARTICLE(
    ID BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    TITLE CHARACTER VARYING(255),
    AUTHOR CHARACTER VARYING(255),
    ARTICLE CHARACTER VARYING(255),
    IMAGE BLOB(255),
    GENRE CHARACTER VARYING(255),
    DATE DATE,
    LIKES INTEGER
);               
-- ALTER TABLE NEWS_ARTICLE ADD CONSTRAINT PK_NEWS_ARTICLE PRIMARY KEY(ID);               
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.NEWS_ARTICLE;             
CREATE TABLE if not exists BOOKMARK(
    ID BIGINT,
    NEWS_ARTICLE_ID BIGINT,
    USER_ID BIGINT
);

CREATE TABLE if not exists CHANNEL(
    ID BIGINT PRIMARY KEY NOT NULL,
    USER_ID BIGINT,
    PREFERENCES CHARACTER VARYING(20)
);
-- ALTER TABLE BOOKMARK ADD CONSTRAINT PK_BOOKMARK PRIMARY KEY(ID);       
-- 0 +/- SELECT COUNT(*) FROM PUBLIC.BOOKMARK; 
ALTER TABLE USER ADD CONSTRAINT USER_LOGIN UNIQUE(LOGIN);
ALTER TABLE USER ADD CONSTRAINT USER_EMAIL UNIQUE(EMAIL);       
ALTER TABLE COMMENT ADD CONSTRAINT FK_COMMENT__NEWS_ARTICLE_ID FOREIGN KEY(NEWS_ARTICLE_ID) REFERENCES NEWS_ARTICLE(ID);
ALTER TABLE COMMENT ADD CONSTRAINT FK_COMMENT__USER_ID FOREIGN KEY(USER_ID) REFERENCES USER(ID);    
ALTER TABLE USER_AUTHORITY ADD CONSTRAINT FK_USER_LOGIN FOREIGN KEY(LOGIN) REFERENCES USER(LOGIN);
ALTER TABLE USER_AUTHORITY ADD CONSTRAINT FK_AUTHORITY_NAME FOREIGN KEY(AUTHORITY_ROLE) REFERENCES AUTHORITY(ROLE);       
ALTER TABLE BOOKMARK ADD CONSTRAINT FK_BOOKMARK__USER_ID FOREIGN KEY(USER_ID) REFERENCES USER(ID);            
ALTER TABLE BOOKMARK ADD CONSTRAINT FK_BOOKMARK__NEWSARTICLE_ID FOREIGN KEY(NEWS_ARTICLE_ID) REFERENCES NEWS_ARTICLE(ID);
ALTER TABLE CHANNEL ADD CONSTRAINT FK_CHANNEL__USER_ID FOREIGN KEY(USER_ID) REFERENCES USER(ID);