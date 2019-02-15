# kubectl-all

## Motivation

* Kubectl get all - list's a subset of all the resources available, wanted to make all the resources visible.

## Installation

### Dependencies

* bash

### With [krew](https://github.com/GoogleContainerTools/krew) (recommended)

```sh
kubectl krew install all
kubectl all
```

### Without krew

* Copy `all.sh` to a file called `kubectl-all`
* Run `chmod +x kubectl-all`
* Add the path to directory in your $PATH. eg `export PATH="/path/to/dir:$PATH"`
* Test `kubectl all`

## Features

* list all resources in the default namespace
* list all resources within a specific namespace

## Usage

```sh
kubectl all resources                 : list all resources in the default namespace

kubectl all -h | --help               : Usage of this command line

kubectl all resources <namespace>     : list all namespaced resources

```
