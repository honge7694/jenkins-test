#!/bin/bash

cd /home/ubuntu

DOCKER_APP_NAME=ec2-application
IMAGE_NAME=cms-app-image
CONTAINER_NAME=cms-app-container
PORT=8080
JAR_FILE="cms-0.0.1-SNAPSHOT.jar"

# 이전에 실행 중인 컨테이너 중지 및 삭제
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
  echo "실행중인 애플리케이션을 정지 후 삭제합니다."
  docker stop ${CONTAINER_NAME}
  docker rm ${CONTAINER_NAME}
fi

# 이전에 존재하는 이미지 삭제
if [ "$(docker iamges -q ${IMAGE_NAME})" ]; then
  echo "기존의 이미지를 삭제합니다."
  docker rmi ${IMAGE_NAME}
fi

# Docker 이미지를 빌드
echo "Building new Docker Image..."
docker build -t ${IMAGE_NAME} --build-arg JAR_FILE=${JAR_FILE} .

# 새 컨테이너를 실행
echo "Starting new container..."
docker run -d --name ${CONTAINER_NAME} -p ${PORT}:8080 ${IMAGE_NAME}

# 배포 상태 확인
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ];
  echo "배포 성공! 어플리케이션 실행합니다. PORT : ${PORT}"
else
  echo "배포 실패"
  exit 1
fi





