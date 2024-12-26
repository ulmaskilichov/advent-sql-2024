select
    s.song_title,
    sum(case when coalesce(up.duration, 0) = s.song_duration then 1 else 0 end) as total_plays,
    sum(case when coalesce(up.duration, 0) = s.song_duration then 0 else 1 end) as total_skips,
    count(*) as total_counts
from user_plays as up
left join users as u on up.user_id = u.user_id
left join songs as s on up.song_id = s.song_id
group by s.song_title
order by total_counts desc, total_plays desc
limit 5
