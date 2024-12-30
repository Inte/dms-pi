# Paperless-ngx

## Kubernetes Ressourcen anwenden

```bash
# Settings
sudo kubectl apply -f config/paperless-ngx-configmap.yaml

# PostgreSQL
sudo kubectl apply -f persistent-volumes/paperless-ngx-db-pvc-pgdata.yaml
sudo kubectl apply -f deployments/paperless-ngx-db.yaml
sudo kubectl apply -f services/paperless-ngx-db-service.yaml

# Redis
sudo kubectl apply -f persistent-volumes/paperless-ngx-broker-pvc-redisdata.yaml
sudo kubectl apply -f deployments/paperless-ngx-broker.yaml
sudo kubectl apply -f services/paperless-ngx-broker-service.yaml

# Gotenberg
sudo kubectl apply -f deployments/paperless-ngx-gotenberg.yaml
sudo kubectl apply -f services/paperless-ngx-gotenberg-service.yaml

# Tika
sudo kubectl apply -f deployments/paperless-ngx-tika.yaml
sudo kubectl apply -f services/paperless-ngx-tika-service.yaml

# Paperless-ngx
sudo kubectl apply -f persistent-volumes/paperless-ngx-webserver-pvc-data.yaml
sudo kubectl apply -f persistent-volumes/paperless-ngx-webserver-pvc-media.yaml
sudo kubectl apply -f persistent-volumes/paperless-ngx-webserver-pvc-export.yaml
sudo kubectl apply -f persistent-volumes/paperless-ngx-webserver-pvc-consume.yaml
sudo kubectl apply -f deployments/paperless-ngx-webserver.yaml
sudo kubectl apply -f services/paperless-ngx-webserver-service.yaml

# Traefik
sudo kubectl apply -f ingress/paperless-ngx-ingress.yaml
```

## Status der PVC prüfen

```bash
sudo kubectl get pvc
```

## Status der Pods prüfen

```bash
sudo kubectl get pods
```

## Status der Services prüfen

```bash
sudo kubectl get services
```

## Status der Ingress prüfen

```bash
sudo kubectl get ingress
```