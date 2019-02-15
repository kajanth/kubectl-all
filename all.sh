#!/usr/bin/env bash

# Usage:
#   kubectl all resources
#   kubectl all resources [namespace]

# Requires:
# - kubectl

set -eo pipefail

function usage() {
  echo "USAGE"
  echo "-----"
  echo "kubectl all resources"
  echo ""
  echo "kubectl all resources namespace"
  echo ""
  echo "kubectl all -h | --help               : Usage of this command line";
  echo ""
}

#Add any resources that need to be ignored
list=(bindings localsubjectaccessreviews.authorization.k8s.io pods.metrics.k8s.io events.events.k8s.io)

elementIn () {
    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
    return 1
}

function get_resources() {
    if [ -z "$1" ]; then namespace='default'; else namespace="$1"; fi
    resources=$(kubectl api-resources --namespaced=true --output=name)
    for resource in $resources; do
        if elementIn "$resource" "${list[@]}"; then
            continue
        else
            data=$(kubectl get $resource -n $namespace --ignore-not-found=true)
            if [[ ! -z $data ]]; then 
                 echo $resource':' 
                 echo -e "$data"
                 printf '\n'
            fi
        fi
    done
    

}

if [ -z "$1" ]; then usage && exit; fi
while [ -n "$1" ]; do
  case "$1" in
    resources)      shift; get_resources "$@";   exit;;
    -h|--help)      usage;              exit;; # quit and show usage
    * ) echo "$1 not recognized";       exit 1;; # if no match, add it to the positional args
  esac
done
