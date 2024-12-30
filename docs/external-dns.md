# External DNS

Source: <https://maxdon.tech/posts/k3s-raspberry-dns/>

## Namespace und Secret erstellen

```bash
sudo kubectl create namespace external-dns
sudo kubectl create secret generic api-key-cloudflare --from-literal=apiKey=replace_this_with_your_secret -n external-dns
```

## external-dns zum Helm Repo hinzufügen

```bash
sudo helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/ --force-update
```

## Helm Chart installieren

```bash
# sudo su (Config wird über sudo nicht geladen)
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm install external-dns external-dns/external-dns --values external-dns-config.yaml -n external-dns
```

## Gateway API installieren

```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/latest/download/standard-install.yaml
```

## Installation prüfen

```bash
sudo kubectl logs -l app.kubernetes.io/name=external-dns -n external-dns
# Alternativ:
sudo kubectl get pods -n external-dns
sudo kubectl logs -n external-dns external-dns-0123456789-abcde # Optional: --previous
```

## Aktualisierung nach Konfigurationsänderung

```bash
# sudo su (Config wird über sudo nicht geladen)
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm upgrade external-dns external-dns/external-dns --values external-dns/external-dns-config.yaml -n external-dns
```