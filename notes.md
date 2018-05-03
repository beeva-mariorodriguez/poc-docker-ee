# docker EE - UCP

* beta problems (test again if possible with finished product)
    * documentation? hard to find _beta_ documentation, but docker docs quality for published products is usually OK so ...
    * differences between orchestrators k8s vs swarm vs mixed
        * swarm nodes appear on ``kubectl get nodes``
        * k8s nodes appear as part of the swarm on ``docker info``
        * volumes are created on all nodes
        * kubelet ... runs on swarm nodes
    * if a machine's role is changed fron worker to manager and again to worker
        * RethinkDB error: rethinkdb cluster unhealthy 3 of 4 replicas are healthy
        * # of managers scales down, but not # of rethinkdb replicas
    * disable application workloads on manager (mixed orchestrator?)
    * expensive! $75 x node x month for server edition (Ubuntu), $0.119 x node x hour for cloud edition (AWS)

* the good
    * access control
    * kubernetes support
    * docker-compose support
    * namespaces and collections

* the ugly
    * namespaces: no web UI to create namespace, have to upload yaml file or edit on ucp web editor

# docker EE - DTR

* requires docker EE, so everything about docker EE and UCP applies here
* the good
    * (automatic) garbage collection for old images
    * access control
    * LDAP/AD integration
    * user audit logs
    * powerful web interface
    * API
    * easy installation (provided you have UCP running)
