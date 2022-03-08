#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # For debugging

#############################################################
# 引数

purviewAccountName=$PURVIEWACCOUNTNAME
collectionId=$COLLECTIONID
serverEndpoint=$SERVERENDPOINT
sourceName=$SOURCENAME
resourceId=$RESOURCEID

##############################################################
# 定数
version='2018-12-01-preview'


##############################################################
# 変数

baseUrl=https://${purviewAccountName}.scan.purview.azure.com/
PutURL=${baseUrl}datasources/${sourceName}?api-version=${version}

body=$(printf '{
    "kind": "AzureSqlDataWarehouse",
    "properties": {
        "serverEndpoint":  "%s",
        "collection": {
            "type": "CollectionReference",
            "referenceName": "%s"
        },
        "resourceId": "%s"
    }
}' $serverEndpoint $collectionId $resourceId)


##############################################################

az rest --method put --resource "https://purview.azure.net" --url "$PutURL" --body "$body"