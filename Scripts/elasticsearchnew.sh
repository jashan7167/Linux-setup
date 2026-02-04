#!/bin/bash
# ─────────────────────────────────────────────────────────────────────
# Docker setup for Elasticsearch 8.11 + Kibana on custom ports
# (This is your NEW/TARGET cluster for the migration)
# ─────────────────────────────────────────────────────────────────────

# Stop and remove existing containers if they exist
docker stop elasticsearch8 kibana8 2>/dev/null || true
docker rm elasticsearch8 kibana8 2>/dev/null || true

# ── Elasticsearch 8.11 on host port 9200 ─────────────────────────────
# Maps: host 9200 → container 9200 (ES default port)
#       host 9300 → container 9300 (transport port)
docker run -d --name elasticsearch8 --network=elastic-net \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=false" \
  -e "http.host=0.0.0.0" \
  -e "transport.host=0.0.0.0" \
  -e "xpack.security.http.ssl.enabled=false" \
  -p 9200:9200 \
  -p 9300:9300 \
  docker.elastic.co/elasticsearch/elasticsearch:8.11.0

echo "Waiting for Elasticsearch 8.11 to start..."
sleep 15

# Verify ES is up
until curl -s http://localhost:9200 >/dev/null; do
  echo "Waiting for Elasticsearch..."
  sleep 3
done

echo "✓ Elasticsearch 8.11 is ready at http://localhost:9200"

# Get the auto-generated password (if security was enabled)
# docker exec elasticsearch8 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -b

# ── Kibana 8.11 on host port 5601 ────────────────────────────────────
# Maps: host 5601 → container 5601 (Kibana default port)
docker run -d --name kibana8 --network=elastic-net \
  -e "ELASTICSEARCH_HOSTS=http://elasticsearch8:9200" \
  -e "SERVER_HOST=0.0.0.0" \
  -p 5601:5601 \
  docker.elastic.co/kibana/kibana:8.11.0

echo "Waiting for Kibana to start..."
sleep 20

echo "✓ Kibana should be ready at http://localhost:5601"
echo ""
echo "─────────────────────────────────────────────────────────"
echo "Access URLs:"
echo "  Elasticsearch: http://localhost:9200"
echo "  Kibana:        http://localhost:5601"
echo ""
echo "Check status:"
echo "  curl http://localhost:9200"
echo "  docker logs elasticsearch8"
echo "  docker logs kibana8"
echo "─────────────────────────────────────────────────────────"
