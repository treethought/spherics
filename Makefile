help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

SHELL := /bin/bash

nginx:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm install nginx ingress-nginx/ingress-nginx \
		--namespace nginx \
		--set rbac.create=true \
		--set controller.publishService.enabled=true

cert-manager:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	helm install \
		cert-manager jetstack/cert-manager \
		--namespace cert-manager \
		--create-namespace \
		--version v1.5.0 \
		--set installCRDs=true
	kubectl apply -f resources/cert-manager/prod-issuer.yaml

gitea:
	kubectl create secret generic -n gitea gitea-admin-secret \
		--from-literal=username=${GITEA_ADMIN_USERNAME} \
		--from-literal=password=${GITEA_ADMIN_PASSWORD} || true
	helm repo add gitea-charts https://dl.gitea.io/charts/
	helm upgrade --install \
		-f resources/gitea/gitea-values.yaml \
		--set gitea.admin.email=${GITEA_ADMIN_EMAIL} \
		--set postgres.global.postgresqlPassword=${GITEA_DB_PASSWORD} \
		-n gitea gitea gitea-charts/gitea



