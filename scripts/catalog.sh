#!/usr/bin/env bash

DIR=$(cd $(dirname "$0")/../olm && pwd)

NAME="gpte-operators"
NAMESPACE="operator-lifecycle-manager"
NAMEDISPLAY="GPTE Operators"

indent() {
  INDENT="      "
  sed "s/^/$INDENT/" | sed "s/^${INDENT}\($1\)/${INDENT:0:-2}- \1/"
}

CRD=$(cat $(ls $DIR/*crd.yaml) | grep -v -- "---" | indent apiVersion)
CSV=$(cat $(ls $DIR/*version.yaml) | indent apiVersion)
PKG=$(cat $(ls $DIR/*package.yaml) | indent packageName)

cat <<EOF | sed 's/^  *$//'
kind: ConfigMap
apiVersion: v1
metadata:
  name: $NAME
  namespace: $NAMESPACE

data:
  customResourceDefinitions: |-
$CRD
  clusterServiceVersions: |-
$CSV
  packages: |-
$PKG
---
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: $NAME
  namespace: $NAMESPACE
spec:
  configMap: $NAME
  displayName: $NAMEDISPLAY
  publisher: Red Hat
  sourceType: internal
EOF
