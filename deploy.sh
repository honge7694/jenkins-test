#!/bin/bash

cd /home/ubuntu

DOCKER_APP_NAME=ec2-application
IMAGE_NAME=cms-app-image
CONTAINER_NAME=cms-app-container
PORT=8080
JAR_FILE="cms-0.0.1-SNAPSHOT.jar"

# 이전에 실행 중인 컨테이너 중지 및 삭제 (Compose 사용)
echo "Docker Compose를 사용하여 기존 컨테이너 중지 및 삭제 중..."
docker-compose down

# JAR 파일을 현재 디렉토리로 복사
echo "빌드된 JAR 파일을 복사 중..."
cp /home/ubuntu/build/libs/${JAR_FILE} .

# Docker Compose를 사용하여 새 이미지 빌드 및 컨테이너 실행
echo "Docker Compose로 새로운 이미지 빌드 및 컨테이너 실행 중..."
docker-compose up --build -d

# 배포 상태 확인
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
  echo "배포 성공! 어플리케이션이 실행 중입니다. PORT : ${PORT}"
else
  echo "배포 실패"
  exit 1
fi
