# spherics stack


The repo consists of all the self-hosted apps and services deployed on my
personal domain spherics.space.

This repo is meant quick, easy, and simple to configure template for deploying a
collection of services t your own kubernetes cluster.



## Supported Components

- [ingress-nginx](https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx)
ingress controller, for exposing your services
- [cert-manager](https://cert-manager.io/docs/) for automatically issuing
  certificates for each of your components
- [gitea](https://docs.gitea.io) - self hosted git service
- owncloud
- nextcloud


## Why helmfile?

You may be wondering what the point of this repo even is, since all it does is
deploy helm charts. So why not just helm deploy aganst vaues file for each
service?


Good question, that's how it started off. However, instead of manually deploying
each chart individually and maintaining a values file that would need to be chaged for each
person using this repo, I decided to go with
[helmfiles](https://github.com/roboll/helmfile).

Helmfiles allow us to declaritively configure sets of helm charts, acting as a
kind of meta helm chart.

I had considered grouping all these charts as dependencies of a umbrella chart,
but wanted to have control over namespacing and versioning independent of the
parent and other sub charts.


By using helmfiles, each chart can still easily be managed and deployed in
isolation, but it become smuch easier to manage the entire set of services
including what is enabled for a domain and diffing the current state of the
cluster against the desired state configuration.




