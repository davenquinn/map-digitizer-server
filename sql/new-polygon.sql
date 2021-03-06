WITH newfeature AS (
INSERT INTO ${schema~}.polygon
  (geometry, type, pixel_width, map_width, certainty, zoom_level)
VALUES (
  ST_Multi(
    ST_MakeValid(
      ST_Transform(
      ST_SetSRID(${geometry}::geometry, 4326),
      ${schema~}.Polygon_SRID()
    ))
  ),
  ${type},
  ${pixel_width},
  ${map_width},
  ${certainty},
  ${zoom_level}
  )
RETURNING *
)
SELECT
  f.id,
  ST_Transform(geometry, 4326) geometry,
  type,
  map_width,
  certainty,
  coalesce(color, '#888888') color,
  false AS erased
FROM newfeature f
JOIN ${schema~}.polygon_type t
  ON f.type = t.id

