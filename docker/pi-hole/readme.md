
TXT DNS Record:
```
mongodb-cluster1.web-service.org 300 IN TXT "authSource=admin&replicaSet=rs0"
```

SRV DNS Record:
```
_mongodb._tcp.mongodb-cluster1.web-service.org 300 IN SRV 0 0 27017 docker1.web-service.org
_mongodb._tcp.mongodb-cluster1.web-service.org 300 IN SRV 0 0 27017 docker2.web-service.org
_mongodb._tcp.mongodb-cluster1.web-service.org 300 IN SRV 0 0 27017 server1.web-service.org
_mongodb._tcp.mongodb-cluster1.web-service.org 300 IN SRV 0 0 27017 tp01-2066.web-service.org
```



