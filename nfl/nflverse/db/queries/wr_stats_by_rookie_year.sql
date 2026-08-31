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
WHERE p.position = 'WR'
  AND ps.rookie_season = 2023
  AND pr.season = 2025
GROUP BY
	p.player_id,
	p.full_name,
	ps.rookie_season
ORDER BY yards DESC;
