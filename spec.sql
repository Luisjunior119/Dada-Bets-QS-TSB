CREATE TABLE default.databets_spec
WITH (
  format = 'PARQUET',
  parquet_compression = 'SNAPPY',
  external_location = 's3://databets-project/databets_spec/'
) AS
WITH etl as (
    select
        upper(game) as game ,
        upper(bet) as bet,
        stake,
        odds,
        case
            when status in ('push', 'push ', 'Push') then 'PUSH'
            when status = '' then 'SEM PREENCHIMENTO'
            else upper(status)
        end as status,
        result as resultado,
        case
            when tipster in ('Chico ', 'Chico') then 'CHICO'
            when tipster in ('Smart', 'SmartBettor') then 'SMART BETTOR'
            else upper(tipster)
        end as tipster,
        case
            when sport in ('Volleyball', 'Voleyball') then 'VOLLEYBALL'
            when sport in ('Tripla', 'Dupla', 'Multiupla', 'Multipla') then 'AO MENOS 2 ESPORTES'
            when sport in ('Tenns', 'Tennis ', 'Tennis', 'tennis') then 'TENNIS'
            when sport in ('League of Legends', 'League Of Legends', 'Esports', 'CS2') then 'ESPORTS'
            when sport in ('Handeball', 'Handball') then 'Handball'        
            when sport in ('Football ', 'Football', 'Fooball') then 'FOOTBALL'
            when sport in ('Basketball', 'Basketball ') then 'BASKETBALL'
            when sport in ('American Football', 'AmericanFootball') then 'AMERICAN FOOTBALL'
            else upper(sport)
        end as sport,
        case
            when bookie in ('Betfast', 'Betfast') then 'BETFAST'
            when bookie in ('Estrela', 'EstrelaBet', 'Estrelabet') then 'ESTRELA BET'
            when bookie in ('7kbet', '7KBet', '7kBet', '7Kbet', '7KBET') then '7K'
            when bookie in ('Apostaganha', 'ApostaGanha') then 'APOSTA GANHA'
            when bookie in ('Betano ', 'Betano') then 'BETANO'
            when bookie in ('BetNacional ', 'Betnacional') then 'BET NACIONAL'
            when bookie in ('Sportybet ', 'SportyBet', 'Sportybet') then 'SPORTY BET'
            when bookie in ('Superbet ', 'Superbet ') then 'SUPERBET'
            when bookie in ('Novibet ', 'Novibet') then 'NOVIBET'
            when bookie in ('PapiGames', 'Papigames') then 'PAPI GAMES'
            when bookie in ('Rei do Pitaco', 'ReiDoPitaco') then 'REI DO PITACO'
            else upper(bookie)
        end as bookie,
        resultado_acumulado,
        data_filtro,
        anomesdia,
        substring(anomesdia,1,6) as anomes,
        substring(anomesdia,1,4) as ano,
        substring(anomesdia,5,2) as mes,
        substring(anomesdia,7,2) as dia
    from default.databets_parquet_tsb
)
select * from etl