create database 

-- main tables

create table if not exists Article (
    articleID serial primary key,
    articleTitle varchar(30) not null,
    articleText text not null,
    articleCreationDate timestamp not null,
    articleLastEdited timestamp
);

create table if not exists Member (
    memberID serial primary key,
    email varchar(30) not null,
    verified boolean not null,
    username varchar(20) not null,
    loginName varchar(20) not null,
    memberPassword varchar(20) not null
);

create table if not exists Staff (
    staffID serial primary key,
    fName varchar(20) not null,
    lName varchar(20) not null,
    addressOne varchar(30) not null,
    addressTwo varchar(30),
    town varchar(20) not null,
    postcode varchar(8) not null,
    phoneNumber char(11) not null,
    loginName varchar(20) not null,
    staffPassword varchar(20) not null
);

create table if not exists Label (
    labelID serial primary key,
    label varchar(20) not null
);

-- intersection table

create table if not exists Comment (
    memberID int,
    articleID int,
    comment text not null,
    commentCreationDate timestamp not null,
    commentLastEdited timestamp,
    foreign key (memberID) references Member(MemberID),
    foreign key (articleID) references Article(articleID),
    primary key (memberID, articleID)
);

create table if not exists Author (
    staffID int,
    articleID int,
    foreign key (staffID) references Staff(staffID),
    foreign key (articleID) references Article(articleID),
    primary key (staffID, articleID)
);

create table if not exists ArticleLabel (
    articleID int,
    labelID int,
    foreign key (articleID) references Article(articleID),
    foreign key (labelID) references Label(LabelID),
    primary key (articleID, LabelID)
);