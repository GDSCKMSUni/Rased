select * from user_cities as u inner join cities as c 
on c.city_id = u.city_id where u.user_id = 20 
order by u.is_default desc;