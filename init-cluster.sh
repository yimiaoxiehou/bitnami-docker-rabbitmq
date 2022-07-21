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
root@VM-4-13-ubuntu:~/rabbitmq# cat init-cluster.sh
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
