#!/usr/bin/env bash

echo "[$(date +%F_%H:%M:%S)] ### 1. [PRE] prepare dataset"

WORKDIR=$(pwd)
DATABASEPATH=$NAS_PATH/youngju/
DATAPATH=$DATABASEPATH/DTU

# mkdir -p $DATABASEPATH
ln -s $DATAPATH datasets

if [ -d "$DATAPATH" ]; then
    echo "Directory $DATAPATH exists. Skipping copy..."
else
    rsync -avh --progress $DATABASEPATH/DTU_train.zip $DATABASEPATH
    cd $DATABASEPATH
    unzip DTU_trian.zip
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

