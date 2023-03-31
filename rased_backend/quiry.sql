select * from user_cities as u inner join cities as c 
on c.city_id = u.city_id where u.user_id = 20 
order by u.is_default desc;


Select p.post_id, p.user_id, user_name,
 date, address, phone,
  details, image_url,CASE
    WHEN k.user_id IS Not NULL and k.user_id =1 THEN 1
    ELSE 0
END AS is_like,count(k.post_id) as likes
   from posts as p left join post_likes as k on
k.post_id = p.post_id group by k.post_id order by p.post_id desc;


Select po.post_id,count(pc.post_id) from post_comments as pc right join posts as po
on po.post_id = pc.post_id  group by pc.post_id order by po.post_id desc;