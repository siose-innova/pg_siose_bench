--3.4.3. Superficie ocupada por una cobertura con un determinado atributo.
WITH mapwindow AS(
	SELECT * 
	FROM siose.spain_grid_100k 
	WHERE gid = 15
),
polygons AS(
	SELECT * 
	FROM siose.siose_polygons p, mapwindow 
	WHERE st_intersects(mapwindow.geom, p.geom)
)

SELECT SUM(v.area_ha)
FROM siose.siose_values v, polygons p
WHERE v.id_polygon IN (p.id_polygon) 
AND v.id_cover=316 AND v.attributes @> ARRAY[40];