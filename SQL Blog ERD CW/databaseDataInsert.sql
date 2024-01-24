-- set time_zone = '+00:00';

insert into Article(articleTitle, articleText, articleCreationDate) 
    values ('why python is better than C', 'it just is', NOW()),
    ('why C is better than python', 'it just is', NOW());

insert into Member(email, verified, username, loginName, MemberPassword)
    values ('johnSmith@fake.co.uk', TRUE, 'jSmith', 'jSmith', 'password'),
    ('janeEvans@real.co.uk', FALSE, 'Jev', 'jevans', 'password1234');

insert into Staff(fName, lName, addressOne, addressTwo, town, postcode, phoneNumber, loginName, staffPassword)
    values ('jeff', 'bezos', '3 definitely real road', null, 'London', 'Lo51jkl', '05077543239', 'jezos', 'amazon');

insert into Label(label)
    values ('sql'),
    ('python'),
    ('java'),
    ('C'),
    ('biased'),
    ('constructors'),
    ('keywords');

insert into ArticleLabel(articleID, labelID)
    values (1, 2),
    (1, 4),
    (1, 5),
    (2, 4);

insert into Comment(memberID, articleID, comment, commentCreationDate)
    values (1, 2, 'python is great!', NOW()),
    (2, 1, 'C is great', NOW());

insert into Author(staffID, articleID)
    values (1,1),
    (1,2);
