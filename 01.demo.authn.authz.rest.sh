#---------------------------------------------------------------------------------------------------------
#                 AuthN + AuthZ + Cache
#---------------------------------------------------------------------------------------------------------

# Consider this as guidance

# First Lets talk about the Cache Types
  # Embedded Cache
  # Client Server Cache

# Protocol
   # HTTP : Rest Implementation
   # Hot rod : Because of its rich capabilities

# Create demo namespace
oc new-project datagrid-demo

# Talk : Operators
  # DataGrid Operator
  # Showcase the Operator

# Switch to the project "datagrid-demo"
oc project datagrid-demo

# Talk about Authentication and Authorization
   # Authorization is based on RBAC and Roles
   # Authentication is via the secrets that map the users with the roles
   # Custom Roles can also be defined for access
oc delete secret connect-secret --ignore-not-found
oc create secret generic --from-file=identities.yaml connect-secret

# Create an Instance of the DataGrid Instance
# Show Cluster Creating Options
   # Number of Nodes or Replicas
   # Service Type
      # Number of copies of Data
      # Cache Service
        # 
      # Datagrid Service
        # Good for cross replication
        # Storage Backing
   # Load Balancer / Route / Node Port
   # Configuration Listener Pod
      # Enabled
      # Configure resources (if needed)
   # Pod Scheduling
      # For cache to be effective, the configuration should be effective
        # Different Nodes     : Preferred vs Mandatory
        # Different AZ        : Preferred vs Mandatory
        # Different AZ/Nodes  : Preferred AZ and then Prefer Nodes
      # Node Affinity ways of creating datagrid cluster
      # 

# Services : Talk through the below
# datagrid-service          : Use from our applications inside the OCP cluster.
# datagrid-service-admin    : Used by the operator to configure and communicate with the cluster.
# datagrid-service-ping     : which ensures that the clusters are healthy and operational
# datagrid-service-external : used for external access outside the cluster
oc get services


# Web Console : Talk through the below
   # Available via the "datagrid-service-external" service abstraction
   # Authentication & Authorization
     # Login with random user and password
     # Login with myobserver
       # Show that everything is read only
     # Login with admin
       # Show the buttons indicating you have permissions

# Creating Cache  : Talking Points
   # Option#01    : Create configuration using the wizard. This generates the yaml / json / xml
   #              : Config Listener : Show the synchronization
   #              : Show the cache
   # Option#02    : Use the output with GitOps  
   # Option#03    : Programmatically

apiVersion: infinispan.org/v2alpha1
kind: Cache
metadata:
  name: custom-cache
  namespace: datagrid-demo
spec:
  clusterName: datagrid-service
  name: custom-cache
  template: |
    distributedCache: 
      owners: "2"
      mode: "SYNC"
      statistics: "true"
      encoding: 
        mediaType: "application/x-protostream"
      locking: 
        concurrencyLevel: "32"
        isolation: "REPEATABLE_READ"
        acquireTimeout: "100"
        striping: "false"
      memory: 
        storage: "OFF_HEAP"
  updates:
    strategy: retain

# Connect DataGrid : Talking Point(s)
   # Post man request variations
   # 

# Setting up the same cluster locally
# Setting up the cache locally
  ./cli.sh user create admin -p adminpwd -g admin
  ./cli.sh user create myapp -p myapppwd -g application
  ./cli.sh user create myobserver -p myobserverpwd -g observer   