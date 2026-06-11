use film_evaluate;

insert into users (username, password, nickname, role, created_at) values
('demo01', 'demo123', '影迷一号', 'USER', now()),
('demo02', 'demo123', '影迷二号', 'USER', now()),
('demo03', 'demo123', '影迷三号', 'USER', now()),
('demo04', 'demo123', '影迷四号', 'USER', now()),
('demo05', 'demo123', '影迷五号', 'USER', now()),
('demo06', 'demo123', '影迷六号', 'USER', now())
on duplicate key update nickname = values(nickname);

delete c from comments c
join users u on c.user_id = u.id
where u.username in ('demo01', 'demo02', 'demo03', 'demo04', 'demo05', 'demo06');

delete r from ratings r
join users u on r.user_id = u.id
where u.username in ('demo01', 'demo02', 'demo03', 'demo04', 'demo05', 'demo06');

insert into ratings (user_id, movie_id, score, created_at, updated_at)
select u.id,
       m.id,
       case u.username
           when 'demo01' then 10
           when 'demo02' then 8
           when 'demo03' then 9
           when 'demo04' then 7
           when 'demo05' then 10
           else 8
       end as score,
       now(),
       now()
from users u
cross join movies m
where u.username in ('demo01', 'demo02', 'demo03', 'demo04', 'demo05', 'demo06');

insert into comments (user_id, movie_id, content, created_at)
select u.id,
       m.id,
       concat('看完《', m.title, '》很有感触，故事完整，人物也很打动人。'),
       now()
from users u
cross join movies m
where u.username = 'demo01';

insert into comments (user_id, movie_id, content, created_at)
select u.id,
       m.id,
       concat('《', m.title, '》的节奏和画面都不错，适合写进电影评分系统的示例评论。'),
       date_add(now(), interval 1 minute)
from users u
cross join movies m
where u.username = 'demo03';

insert into comments (user_id, movie_id, content, created_at)
select u.id,
       m.id,
       concat('我给《', m.title, '》较高评价，推荐给喜欢', m.genre, '类型的同学。'),
       date_add(now(), interval 2 minute)
from users u
cross join movies m
where u.username = 'demo05';
