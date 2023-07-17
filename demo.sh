#-----------------------------------------------------------------------------
# Operator Demo
#-----------------------------------------------------------------------------


# Create "connect-secret" secret
oc delete secret connect-secret --ignore-not-found
oc create secret generic --from-file=identities.yaml connect-secret

# Create the cluster
oc apply -f cluster/02.cluster.yaml



# Sample Cluster Provisioning
apiVersion: infinispan.org/v1
kind: Infinispan 
metadata:
  name: datagrid-service 
  namespace: datagrid-demo
spec:
  #Indicates two node DG cluster
  replicas: 2
  #Exposing it as external load Balancer
  expose:
    type: LoadBalancer

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