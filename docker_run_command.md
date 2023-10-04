docker run --gpus 0 --ipc=host --name youngju-dev \
-v /mnt/nas2:/mnt/nas2 \
-p 22 \
-itd sgvrcluster.kaist.ac.kr/youngju/volrecon-base \
/bin/bash

docker exec -it youngju-dev /bin/bash

# docker commit
docker commit youngju-dev youngju-dev

# docker tag
docker tag youngju-dev sgvrcluster.kaist.ac.kr/youngju/volrecon-base

# docker push
docker push sgvrcluster.kaist.ac.kr/youngju/volrecon-base

# docker remove container
docker rm -f youngju-dev

# kubectl commands
sh apply_train.sh volrecon_base volrecon_train.yaml 2

# kubectl get jobs
kubectl describe job volrecon-train

kubectl logs <pods>
