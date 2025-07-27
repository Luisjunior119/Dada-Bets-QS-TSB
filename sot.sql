CREATE TABLE default.databets_parquet_tsb
WITH (
  format = 'PARQUET',
  parquet_compression = 'SNAPPY',
  external_location = 's3://databets-project/databets_parquet/'
) AS
SELECT
  cast(game as varchar)                        as game,
  cast(bet as varchar)                      as bet,
  cast(replace(stake, ',', '.') as double)    as stake,
  cast(replace(odds, ',', '.') as double)     as odds,
  cast(status as varchar)                      as status,
  cast(replace(result, ',', '.') as double) as result,
  cast(tipster as varchar)                     as tipster,
  cast(sport as varchar)                     as sport,
  cast("bookie" as varchar)            as bookie,
  cast(replace(resultado_acumulado, ',', '.') as double) as resultado_acumulado,
  cast(date as date)                          as data_filtro,
  cast(replace(date, '-', '') as varchar)      as anomesdia
FROM databets_parquet_sor;