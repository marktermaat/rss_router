docker build -t marktermaat/rss_router -f docker/Dockerfile .
docker tag marktermaat/rss_router marktermaat/rss_router:0.3
docker push marktermaat/rss_router:0.3
docker push marktermaat/rss_router:latest
