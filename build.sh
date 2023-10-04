DOCKER_HOME=$(dirname $0)
CODE_BASE_PATH=$(realpath ..)
IMAGE_NAME=sgvrcluster.kaist.ac.kr/youngju/volrecon-base:latest

docker build -f $DOCKER_HOME/Dockerfile \
-t $IMAGE_NAME $CODE_BASE_PATH

docker push $IMAGE_NAME
echo "[$(date +%F_%H:%M:%S)] DONE!"