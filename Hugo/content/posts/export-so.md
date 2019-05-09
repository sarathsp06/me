+++
title = "Export StackOverflow"
tags = [
    "stackoverflow",
    "development",
]
date = 2019-05-09T16:08:41+02:00
toc = true
+++


### How to export StackOverflow data?


I wanted to show my StackOverflow posts on my personal website with links to the original question. There are multiple options to get the data.


1. [stackexchange api](https://api.stackexchange.com/)
2. [stackexchange dataexplorer](https://data.stackexchange.com/)


StackExchange data explorer exposes the data using SQL syntax. The home page has a set of already created queries.
For me, all I wanted was a way to get my answers in descending order of score and some details about the question. Here is how one can get that


Go to [compose query](https://data.stackexchange.com/stackoverflow/query/new) in [https://data.stackexchange.com](https://data.stackexchange.com) and use the following query in the query page

```sql
DECLARE @UserId int = ##UserId##
SELECT
  answ.Id "AnswerID",
  q.Id "QuestionID",
  answ.Body "AnswerBody",
  q.Body "QuestionBody",
  answ.Score "AnswerScore",
  q.Score "QuestionScore",
  answ.CreationDate "AnswerDate",
  q.CreationDate "QuestionDate"
FROM
  Posts answ JOIN Posts q on q.Id = answ.ParentId
WHERE
  answ.PostTypeID =  2 AND answ.OwnerUserId = @UserID
ORDER BY answ.Score DESC
```

The user id can be passed as a parameter.



**OR** you can check out the same [here](https://data.stackexchange.com/stackoverflow/query/1044629/top-20-answers-in-decending-order-of-score)
