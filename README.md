# GPTE Operators

Catalog of operators for use in the [Operator Lifecycle Manger (OLM)](https://github.com/operator-framework/operator-lifecycle-manager/).

## Installation

To install the _CatalogSource_ into the OLM, execute the following command:

```
oc apply -f gpte-catalogsource.yaml
```

## Generating the CatalogSource

A script called `catalog.sh` is located in the _scripts_ directory that will take the contents of the _olm_ folder to generate the _CatalogSource_ that can be applied to a running cluster.

Execute the following command to generate the catalog

```
./scripts/catalog.sh > gpte-catalogsource.yaml
```