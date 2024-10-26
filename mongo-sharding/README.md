# MongoDB with sharding

## How to run

From root directory run:

```bash
docker compose -f -f mongo-sharding/compose.yaml up -d
```

Run init script that setups:

- configuration server
- shard1 and shard2 of mongodb instances
- mongo router
- inserts 1000 documents
- checks documents amount on shard1
- checks documents amount on shard2

```bash
./mongo-sharding/scripts/mongo-init.sh
```

## FastAPI

Access integration handlers at `http://localhost:8080`
