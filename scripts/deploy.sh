ssh mark@192.168.2.4 << EOF
  cd /docker/rss_router
  docker-compose pull
  docker-compose down
  docker-compose up -d
EOF