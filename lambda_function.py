import gspread
from google.oauth2.service_account import Credentials
import boto3
import os
import json
import csv
import io

def lambda_handler(event, context):
    # Carrega as credenciais da variável de ambiente
    creds_json = os.environ.get('GCP_CREDENTIALS_JSON')
    if not creds_json:
        return {'statusCode': 500, 'body': 'Variável de ambiente GCP_CREDENTIALS_JSON não definida.'}

    try:
        creds_dict = json.loads(creds_json)
        creds_dict['private_key'] = creds_dict['private_key'].replace('\\n', '\n')  # Corrige quebra de linha
        creds = Credentials.from_service_account_info(
            creds_dict,
            scopes=["https://www.googleapis.com/auth/spreadsheets.readonly"]
        )
    except Exception as e:
        return {'statusCode': 500, 'body': f'Erro ao carregar credenciais: {e}'}

    # Conecta ao Google Sheets
    try:
        client = gspread.authorize(creds)
        spreadsheet = client.open_by_url('https://docs.google.com/spreadsheets/d/1um4Dz0BD_Rkwig_nTueRVbl_mId9V3VfozOtHlY86mc/edit?usp=sharing')
        worksheet = spreadsheet.sheet1
        data = worksheet.get_all_values()
    except Exception as e:
        return {'statusCode': 500, 'body': f'Erro ao acessar Google Sheets: {e}'}

    if not data:
        return {'statusCode': 400, 'body': 'A planilha está vazia.'}

    # Separa cabeçalho e linhas
    header = data[0]
    rows = data[1:]

    # Converte dados para CSV em memória
    csv_buffer = io.StringIO(newline='')
    writer = csv.writer(csv_buffer)
    writer.writerow(header)
    writer.writerows(rows)

    # Envia para o S3
    try:
        s3 = boto3.client('s3')
        bucket_name = 'databets-project'
        file_name = 'databet_version_two/databet_tsb.csv'

        s3.put_object(
            Bucket=bucket_name,
            Key=file_name,
            Body=csv_buffer.getvalue()
        )
    except Exception as e:
        return {'statusCode': 500, 'body': f'Erro ao enviar para o S3: {e}'}

    return {
        'statusCode': 200,
        'body': f"Arquivo {file_name} enviado com sucesso para o bucket {bucket_name}."
    }
