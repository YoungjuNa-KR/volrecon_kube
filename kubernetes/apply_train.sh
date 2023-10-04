#!/bin/bash

export TRAIN_NAME=$1
export YAML_FILE=$2
export NAS_PATH=/mnt/nas2
export SSD_PATH=/mnt/ssd1
export TRAIN_SH="dtu_train.sh"
export NUM_GPUS=${3:-1}


echo "TRAIN_NAME: $TRAIN_NAME, YAML_FILE: $YAML_FILE NUM_GPUS: $NUM_GPUS"

envsubst < volrecon_train.yaml > $TRAIN_NAME.yaml

kubectl apply -f $TRAIN_NAME.yaml