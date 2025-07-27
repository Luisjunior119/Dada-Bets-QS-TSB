-- CC average_odd
avg(odds)

--CC average_stake
avg(stake)

--CC % WON BET
sum(ifelse(status = 'WON', 1, 0)) / count(status)

--CC - ROI
(sum(resultado) / sum(stake))


--CC - Valor apostado
sum(stake) * 100



--CC - Waterfall - PARAM 
ifelse(
    ${metricawaterfall} = 'Lucro', {CC - Lucro},
    ${metricawaterfall} = 'Quantidade de apostas', {CC - count_qtd_apostas},
    ${metricawaterfall} = 'Valor apostado', {CC - Valor apostado},
    NULL
)


--CC Colunas Param
ifelse(
    ${Colunaselecionada} = 'bookie', {bookie tratado},
    ${Colunaselecionada} = 'tipster', tipster,
    ${Colunaselecionada} = 'sport', sport,
    null
)

--CC METRICA
ifelse(
    ${MetricaSelecionada} = 'Lucro', {CC - Lucro},
    ${MetricaSelecionada} = 'ROI', {CC - ROI ANALITICA},
    ${MetricaSelecionada} = '% De Acerto', {CC % WON BET ANALITICA},
    ${MetricaSelecionada} = 'Valor apostado', {CC - Valor apostado},
    NULL
)

-- CC FAIXA DE ODDS
ifelse(
    odds >= 1.50 and odds <= 1.90, '1.50-1.70',
    odds >= 1.91 and odds <= 2.20, '1.71-1.92',
    odds >= 2.21 and odds <= 2.70, '1.93-2.40',
    odds >= 2.71 and odds <= 3.50, '2.41-3.50',
    odds >= 3.51 and odds <= 5.00, '3.51-5.00',
    odds >= 5.01, 'Acima de 5.00',
    'Fora da faixa'
)

--CC LAST MONTH
ifelse(dateDiff({data_filtro},now(),"MM") = 1, resultado, 0)

--CC THIS MONTH
ifelse(dateDiff({data_filtro},now(),"MM") = 0 AND {data_filtro}<=now(), resultado, 0)

--CC MoM Diff
sum({this month}) - sum(lastmonth)

--CC MoM Diff %
(sum({this month}) - sum(lastmonth)) / sum(lastmonth)

--CC LAST YEAR
ifelse(dateDiff({data_filtro},now(),"YYYY") = 1, resultado, 0)

--CC This Year
ifelse(dateDiff({data_filtro},now(),"YYYY") = 0 AND {data_filtro}<=now(), resultado, 0)

--CC YoY Diff
sum({this year}) - sum({last year})

--CC YoY Diff %
(sum({this year}) - sum({last year})) / sum({last year}) * 100







