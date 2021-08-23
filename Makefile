help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

SHELL := /bin/bash


gitea:
	kubectl create secret generic gitea-admin-secret \
		--from-literal=username=gitea_admin \
		--from-literal=password=${GITEA_ADMIN_PASSWORD}
	helm repo add gitea-charts https://dl.gitea.io/charts/
	helm upgrade -f resources/gitea/gitea-values.yaml \
		--set postgres.global.postgresqlPassword=${GITEA_DB_PASSWORD} \
		-n gitea gitea gitea-charts/gitea



