/*
\set rookie_season 2025
\set season 2025
\set position 'WR'
*/

SELECT
	p.player_id,
	p.full_name,
	ps.rookie_season,
	SUM(pr.targets) as targets,
	SUM(pr.receptions) as receptions,
	SUM(pr.yards) as yards,
	SUM(pr.tds) as tds
FROM nflverse.players p 
JOIN nflverse.player_status ps
	ON p.player_id = ps.player_id
JOIN nflverse.player_receiving pr
	ON p.player_id = pr.player_id
WHERE p.position = :'rec_rookie_position'
  AND ps.rookie_season = :rookie_season
  AND pr.season = :current_season_for_rookie_wr
GROUP BY
	p.player_id,
	p.full_name,
	ps.rookie_season
ORDER BY yards DESC;
