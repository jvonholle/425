-- James R Von Holle
-- midterm stuff q2.sql

select distinct 
    view_players.id as 'id',
    concat(view_players.first,' ',coalesce(view_players.mi,''),' ',view_players.last) as 'player', 
    view_players.Team_name,'Y' as captain, Player_Stats.assists, Player_Stats.rebounds, Player_Stats.points, 
    Player_Stats.fouls, Player_Stats.Game_date, Player_Stats.Game_Home, Game.home_score, 
    Player_Stats.Game_Visitor, Game.visitor_score 
    from (( Game join Player_Stats on Game.date = Player_Stats.Game_date and 
                                        Game.Home = Player_Stats.Game_Home and 
                                        Game.Visitor = Player_Stats.Game_Visitor)
                  join view_players on Player_Stats.Player_id = view_players.id)
            where view_players.id in (select Team.captain from Team)
    union
select distinct 
    view_players.id as 'id',
    concat(view_players.first,' ',coalesce(view_players.mi,''),' ',view_players.last) as 'player', 
    view_players.Team_name, 'N' as captain, Player_Stats.assists, Player_Stats.rebounds, Player_Stats.points, 
    Player_Stats.fouls, Player_Stats.Game_date, Player_Stats.Game_Home, Game.home_score, 
    Player_Stats.Game_Visitor, Game.visitor_score 
    from (( Game join Player_Stats on Game.date = Player_Stats.Game_date and 
                                        Game.Home = Player_Stats.Game_Home and 
                                        Game.Visitor = Player_Stats.Game_Visitor)
                  join view_players on Player_Stats.Player_id = view_players.id)
            where view_players.id not in (select Team.captain from Team) \G
