#!/bin/bash
# ─────────────────────────────────────────────────────────────────────
# Corrected Docker setup for Elasticsearch 6.4.2 + Kibana on custom ports
# ─────────────────────────────────────────────────────────────────────

# Stop and remove existing containers if they exist
docker stop elasticsearch2 kibana2 2>/dev/null || true
docker rm elasticsearch2 kibana2 2>/dev/null || true

# ── Elasticsearch 6.4.2 on host port 9201 ────────────────────────────
# Maps: host 9201 → container 9200 (ES default port)
#       host 9301 → container 9300 (transport port)
docker run -d --name elasticsearch2 --network=elastic-net \
  -e "discovery.type=single-node" \
  -e "xpack.security.enabled=false" \
  -e "http.host=0.0.0.0" \
  -e "transport.host=0.0.0.0" \
  -p 9201:9200 \
  -p 9301:9300 \
  elastic/elasticsearch:6.4.2

echo "Waiting for Elasticsearch to start..."
sleep 15

# Verify ES is up
until curl -s http://localhost:9201 >/dev/null; do
  echo "Waiting for Elasticsearch..."
  sleep 3
done

echo "✓ Elasticsearch is ready at http://localhost:9201"

# ── Kibana 6.4.2 on host port 5602 ───────────────────────────────────
# Maps: host 5602 → container 5601 (Kibana default port)
docker run -d --name kibana2 --network=elastic-net \
  -e "ELASTICSEARCH_URL=http://elasticsearch2:9200" \
  -e "SERVER_HOST=0.0.0.0" \
  -p 5602:5601 \
  docker.elastic.co/kibana/kibana:6.4.2

echo "Waiting for Kibana to start..."
sleep 20

echo "✓ Kibana should be ready at http://localhost:5602"
echo ""
echo "─────────────────────────────────────────────────────────"
echo "Access URLs:"
echo "  Elasticsearch: http://localhost:9201"
echo "  Kibana:        http://localhost:5602"
echo ""
echo "Check status:"
echo "  curl http://localhost:9201"
echo "  docker logs elasticsearch2"
echo "  docker logs kibana2"
echo "─────────────────────────────────────────────────────────"
