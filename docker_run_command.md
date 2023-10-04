docker run --gpus 0 --ipc=host --name youngju-dev \
-v /mnt/nas2:/mnt/nas2 \
-p 22 \
-itd sgvrcluster.kaist.ac.kr/youngju/volrecon-base \
/bin/bash

docker exec -it youngju-dev /bin/bash