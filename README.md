# PoC docker EE 2.0 beta

infrastructure to run the Docker EE 2.0 public beta exercises

https://goto.docker.com/rs/929-FJL-178/images/Docker-EE-Beta-Exercises.pdf

## requirements

* terraform
* a valid docker EE license file in ./docker_subscription.lic

## UCP installation
1. ``terraform apply``
2. get manager URL
    ```bash
    terraform output manager-url
    ```
3. add nodes from the UCP interface
    ```bash
    for n in $(terraform output -json nodes | jq -r '.value | .[]')
    do
        ssh ubuntu@$n docker swarm join --token ....
    done
    ```

## DTR

1. add the DTR node to the swarm as worker
```bash
ssh ubuntu@$(terraform output dtr) docker swam join --token ...
```
2. wait a minute until node is ready ...
2. install DTR
```bash
docker run -it --rm docker/dtr:2.5.0-beta3 install \                                                                                                           ✭ 
--dtr-external-url $(terraform output dtr-url) \
--ucp-node $(terraform output dtr-node | awk -F'.' '{print $1}') \
--ucp-username admin \
--ucp-url $(terraform output manager-url) \
--uc-insecure-tls
```
