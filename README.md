## Configure environment

1. Install prerequisites:
    - IDE (e.g. [VS Code](https://code.visualstudio.com/docs/setup/setup-overview))
    - [Docker](https://docs.docker.com/engine/install/)

1. Fork & Clone this repository and open in IDE

1. Spin up Docker containers

    All the services are configured via [Docker containers](./docker-compose.yml).

    - devcontainer
    - Postgres

    ```bash
    # build dev container
    devcontainer build .

    # open dev container
    devcontainer open .
    ```

    ![](./docs/1_docker_compose_services.png)

1. Verify you are in a development container by running commands:

    ```bash
    dbt --version
    ```

    ![](./docs/2_dbt_version.png)

    If any of these commands fails printing out used software version then you are probably running it on your local machine not in a dev container!


## Install dbt packages

1. Install modules via [packages.yml](./packages.yml)

    ```bash
    dbt clean # clean temp files
    dbt deps # install dependencies (modules)
    ```
