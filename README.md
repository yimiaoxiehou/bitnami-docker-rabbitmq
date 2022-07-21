## base on Bitnami RabbitMQ (https://hub.docker.com/r/bitnami/rabbitmq)

add init-cluster.sh into /docker-entrypoint-initdb.d for init mq with init cluster.


```bash
# init-cluster.sh
#!/bin/bash

. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libos.sh

if [[ -z $OTHER_NODE ]]; then
    info "The environment OTHER_NODE exist. this node will create cluster with it."
fi
if [[ -s ${RABBITMQ_DATA_DIR}/${RABBITMQ_NODE_NAME}/cluster_nodes.config && -n `cat ${RABBITMQ_DATA_DIR}/${RABBITMQ_NODE_NAME}/cluster_nodes.config | grep $OTHER_NODE` ]]; then
    cat ${RABBITMQ_DATA_DIR}/${RABBITMQ_NODE_NAME}/cluster_nodes.config
    info "Cluster already inited."
else
    info "Clster initing."
    cat ${RABBITMQ_HOME_DIR}/.erlang.cookie
    rabbitmqctl stop_app
    rabbitmqctl reset
    rabbitmqctl join_cluster ${OTHER_NODE}
    rabbitmqctl start_app
    rabbitmqctl cluster_status
    rabbitmqctl set_policy replica "^" '{"ha-mode":"all","ha-sync-mode":"automatic"}'
    rabbitmqctl list_policies
fi

```


You can set environment OTHER_NODE to take a node join_cluster.



