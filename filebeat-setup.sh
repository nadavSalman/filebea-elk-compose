
docker-compose exec elasticsearch bin/elasticsearch-reset-password --batch --user elastic

WARNING: Owner of file [/usr/share/elasticsearch/config/users] used to be [root], but now is [elasticsearch]
WARNING: Owner of file [/usr/share/elasticsearch/config/users_roles] used to be [root], but now is [elasticsearch]
Password for the [elastic] user successfully reset.
New value: mKTAvGy-4r6LJ2hT1+Q*


$ docker-compose exec elasticsearch bin/elasticsearch-reset-password --batch --user logstash_internal
Password for the [logstash_internal] user successfully reset.
New value: LpHys5vs0j0MqeXvVVc5


$ docker-compose exec elasticsearch bin/elasticsearch-reset-password --batch --user kibana_system
Password for the [kibana_system] user successfully reset.
New value: O0SxRM3WXiG5rI*nwgLy






#--------------------------------------------------------------------

# Filebeat


# configuration file
curl -L -O https://raw.githubusercontent.com/elastic/beats/8.4/deploy/docker/filebeat.docker.yml


# Volume-mounted configurationedit
One way to configure Filebeat on Docker is to provide filebeat.docker.yml via a volume mount. With docker run, the volume mount can be specified like this.





docker pull docker.elastic.co/beats/filebeat:8.4.3
docker run -d \
  --name=filebeat \
  --user=root \
  --volume="$(pwd)/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro" \
  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
  docker.elastic.co/beats/filebeat:8.4.3 filebeat -e --strict.perms=false \
  -E output.elasticsearch.hosts=["127.0.0.1:9200"]

