CREATE TABLE default.databets_parquet_sor
WITH (
  format = 'PARQUET',
  parquet_compression = 'SNAPPY',
  external_location = 's3://databets-project/databet_version_two/tsb_parquet_sor/'
) AS
SELECT
  cast(replace(data, '-', '') as varchar)      as anomesdia,
  cast(jogo as varchar)                        as jogo,
  cast(aposta as varchar)                      as aposta,
  cast(replace(stake, ',', '.') as double)    as stake,
  cast(replace(odds, ',', '.') as double)     as odds,
  cast(status as varchar)                      as status,
  cast(replace(resultado, ',', '.') as double) as resultado,
  cast(tipster as varchar)                     as tipster,
  cast(esporte as varchar)                     as esporte,
  cast("casa_de_aposta" as varchar)            as casa_de_aposta
FROM databets_csv_staging;