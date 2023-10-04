#!/usr/bin/env bash

echo "[$(date +%F_%H:%M:%S)] ### 1. [PRE] prepare dataset"

WORKDIR=$(pwd)
DATABASEPATH=$SSD_PATH/youngju/datasets
DATAPATH=$DATABASEPATH/DTU

mkdir -p $DATABASEPATH
ln -s $DATABASEPATH datasets

if [ -d "$DATAPATH" ]; then
    echo "Directory $DATAPATH exists. Skipping copy..."
else
    echo "Directory $DATAPATH not exists. Copying file..."
    apt-get -y install rsync
    rsync -avh --progress $NAS_PATH/youngju/DTU_train.zip $DATABASEPATH
    cd $DATABASEPATH
    unzip DTU_train.zip
fi

cd $WORKDIR

echo "[$(date +%F_%H:%M:%S)] ### 2. Training"

mkdir -p $NAS_PATH/youngju/volrecon-kube/checkpoints
ln -s $NAS_PATH/youngju/vorlecon-kube/checkpoints .

DATASET=datasets
LOG_DIR=checkpoints

python main.py --max_epochs 16 --batch_size 2 --lr 0.0001 \
--weight_rgb 1.0 --weight_depth 1.0 \
--train_ray_num 1024 --volume_reso 96 \
--root_dir=$DATASET --logdir=$LOG_DIR $@

