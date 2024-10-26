#!/bin/bash

###
# Инициализируем сервер конфигурации
###
docker compose -f mongodb-sharding/mongodb-sharding.yaml exec -T configSrv mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
)
EOF
###
# Инициализируем шарды
###
docker compose -f mongodb-sharding/mongodb-sharding.yaml exec -T shard1 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1:27018" },
       // { _id : 1, host : "shard2:27019" }
      ]
    }
)
EOF
docker compose -f mongodb-sharding/mongodb-sharding.yaml exec -T shard2 mongosh --port 27019 <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
       // { _id : 0, host : "shard1:27018" },
        { _id : 1, host : "shard2:27019" }
      ]
    }
  )
EOF
###
# Инициализируем роутер
###
docker compose -f mongodb-sharding/mongodb-sharding.yaml exec -T mongos_router mongosh --port 27020 <<EOF
sh.addShard( "shard1/shard1:27018")
sh.addShard( "shard2/shard2:27019")
sh.enableSharding("somedb")
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
db.helloDoc.countDocuments()
EOF
###
# Проверяем шардирование
###
docker compose -f mongodb-sharding/mongodb-sharding.yaml exec -T shard1 mongosh --port 27018 <<EOF
use somedb
db.helloDoc.countDocuments()
EOF
docker compose -f mongodb-sharding/mongodb-sharding.yaml exec -T shard2 mongosh --port 27019 <<EOF
use somedb
db.helloDoc.countDocuments()
EOF