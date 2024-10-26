# MongoDB with sharding

## How to run

From root directory run:

```bash
docker compose -f ./mongodb-sharding/mongodb-sharding.yaml up -d
```

Run init script that setups:

- configuration server
- shard1 and shard2 of mongodb instances
- mongodb router
- inserts 1000 documents
- checks documents amount on shard1
- checks documents amount on shard2

```bash
./mongodb-sharding/scripts/mongodb-sharding-init.sh
```

## FastAPI

Access integration handlers at `http://localhost:8080`
