help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

SHELL := /bin/bash


	helm repo update

	helm repo update
	kubectl create ns ocis || true
	helm upgrade --install \
	
lint:
	helmfile lint

diff:
	helmfile diff



