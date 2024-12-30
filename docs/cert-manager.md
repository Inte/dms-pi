# cert-manager

## Installation von Helm

```bash
sudo curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Namespace cert-manager erstellen

```bash
sudo kubectl create namespace cert-manager
```

## Helm Repo hinzufügen

```bash
sudo helm repo add jetstack https://charts.jetstack.io --force-update
```

## cert-manager installieren

```bash
# sudo su (Config wird über sudo nicht geladen)
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
sudo helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true
```

```bash
# Deployment
sudo kubectl apply -f cert-manager/cert-manager-prod.yaml
sudo kubectl get ClusterIssuer -A
```

# Prüfung

```bash
sudo kubectl get pods -n cert-manager
sudo kubectl get crds | grep cert-manager
sudo kubectl logs -l app.kubernetes.io/name=cert-manager -n cert-manager
```