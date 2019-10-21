import json
import os
import boto3

def lambda_handler(event, context):
    print('event')
    print(event)
    params = {
        'Destination': {
            'ToAddresses': [os.getenv('TO_EMAIL_ADDRESS')]
        },
        'Message': {
            'Body': {
                'Text': { 
                    'Data': ''.join([
                        event['message'],
                        '\r\n',
                        'This mail is sent via aws lambda',
                        '\r\n',
                        event['headers']['Host'],
                    ])
                }
            },
            'Subject': { 
                'Data': event['subject']
            }
        },
        'Source': 'sourceEmailAddress'
    }
    response = boto3.client('ses').sendEmail(params)
    print(response)
    return {
        'statusCode': 201,
        'body': '',
    }
