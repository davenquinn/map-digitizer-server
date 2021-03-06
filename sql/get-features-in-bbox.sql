SELECT
  l.id,
  ST_Transform(geometry, 4326) geometry,
  type,
  map_width,
  certainty,
  coalesce(color, '#888888') color
FROM
  ${schema~}.${table~} l
JOIN ${schema~}.${type_table~} t
  ON l.type = t.id
WHERE geometry && ST_Transform(
    ST_MakeEnvelope($1, $2, $3, $4, 4326),
    ${schema~}.Linework_SRID()
  )
  AND NOT l.hidden


