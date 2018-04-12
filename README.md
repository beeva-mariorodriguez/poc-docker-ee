# PoC docker EE 2.0 beta

infrastructure to run the Docker EE 2.0 public beta exercises

https://goto.docker.com/rs/929-FJL-178/images/Docker-EE-Beta-Exercises.pdf

## requirements

* terraform
* a valid docker EE license file in ./docker_subscription.lic

## installation
1. ``terraform apply``
2. tunnel to manager
    ```bash
    ssh -L 127.0.0.1:6443:127.0.0.1:6443 -L 127.0.0.1:8443:127.0.0.1:443 \
        ubuntu@$(terraform output manager)
    ```

    web interface is at https://127.0.0.1:8443
3. add nodes/managers from the UCP interface
    ```bash
    for n in $(terraform output -json nodes | jq -r '.value | .[]')
    do
        ssh ubuntu@$n docker swarm join --token ....
    done
    ```

