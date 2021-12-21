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
        }
    }
}'$serverEndpoint $collectionId  )


##############################################################

curl -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $token" --data "$body" "$PutURL"

