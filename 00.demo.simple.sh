#-----------------------------------------------------------------------------
# Operator Demo
#-----------------------------------------------------------------------------

# Create demo namespace
oc new-project datagrid-demo

# Authorization & Authentication
# Create "connect-secret" secret
oc delete secret connect-secret --ignore-not-found
oc create secret generic --from-file=identities.yaml connect-secret

# Create the cluster
oc apply -f cluster/cluster.yaml

# Talk through the services
# datagrid-service          : Use from our applications inside the OCP cluster.
# datagrid-service-admin    : Used by the operator to configure and communicate with the cluster.
# datagrid-service-ping     : which ensures that the clusters are healthy and operational
oc get services


# Console Overview
# Console credentials are present in a secret : datagrid-service-generated-secret
oc get secret datagrid-service-generated-secret -o jsonpath="{.data.identities\.yaml}" | base64 --decode

# Datagrid Services : Two Types
  # Cache Service
  # DataGrid Service
