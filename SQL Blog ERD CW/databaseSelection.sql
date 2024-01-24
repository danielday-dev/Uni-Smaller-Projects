select articleTitle as "Article Title"
from Article;


-- select all labels for the 
-- article why python is better than C
select articleTitle as "Article Title",
    label as "Label"
from Label l
right join ArticleLabel al on l.labelID = al.labelID
right join Article a on a.articleId = al.articleID
where articleTitle like '%python%';

-- select all staff who have posted more than 2 articles
select s.fName as "First Name",
    s.lName as "Last Name",
    count(a.staffID) as "Number of Articles"
from Staff s
right join Author a on a.staffID = s.staffID
group by s.fName, s.lName
having count(a.staffID) >= 2;

-- select all comments by member Jev
select m.username as "User",
    c.comment as "Comment",
    c.commentCreationDate as "Comment Created",
    c.commentLastEdited as "Last Edited"
from Member m
right join Comment c on m.memberID = c.memberID
where m.username = 'Jev';