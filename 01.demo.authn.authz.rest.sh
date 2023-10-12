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
   # Load Balancer
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


# Web Console
   # Login with monitor 	  : Show the authentication and Authorization
   # Login with admin 	    : Show the authentication and Authorization
   #  

# Creating Cache
   # Options and generate the yaml / json / xml
   # 

# Connecting to the cache example
   # Post man request variations

# Setting up the same cluster locally
# Setting up the cache locally
  ./cli.sh user create admin -p adminpwd -g admin
  ./cli.sh user create myapp -p myapppwd -g application
  ./cli.sh user create myobserver -p myobserverpwd -g observer   


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