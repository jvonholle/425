-- James R Von Holle
-- midterm stuff q1.sql

select distinct
    Team.name as 'team',
    concat(view_coaches.first,' ',coalesce(view_coaches.mi,''),' ',view_coaches.last) as 'coach', 
    concat(view_players.first,' ',coalesce(view_players.mi,''),' ',view_players.last) as 'captain',
    Team.city as team_city, Team.State_name, Team.color,
    count(distinct Fan.Person_id) as 'fans'
    from ((( Team
                join view_coaches on Team.name = view_coaches.Team_name)
                join view_players on Team.captain = view_players.id)
                join Fan on Team.name = Fan.Team_name) group by Team.name, view_coaches.first\G
