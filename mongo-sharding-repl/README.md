# MongoDB with sharding and replication

## How to run

From root directory run:

```bash
docker compose -f mongo-sharding-repl/compose.yaml up -d
```

Run init script that setups:

- configuration server
- shard1-1 as primary with shard1-2 as secondary
- shard2-1 as primary with shard2-2 as secondary
- mongodb router
- inserts 1000 documents
- checks documents amount on shard1-1
- checks documents amount on shard1-2
- checks documents amount on shard2-1
- checks documents amount on shard2-2

```bash
./mongo-sharding-repl/scripts/mongo-init.sh
```

## FastAPI

Access integration handlers at `http://localhost:8080`
