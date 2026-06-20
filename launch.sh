#!/bin/bash -eu

BUILD_ONLY=false

if [ "${1:-}" = "--build-only" ]; then
   BUILD_ONLY=true
   shift
fi

mkdir -p .m2

if [ ! -d third_party ]; then
   mkdir -p third_party
   git clone --branch v1-dev https://github.com/y-okumura-isp/markedj.git third_party/markedj
fi

export DUID=${UID}
export DGID=$(id -g)
MAVEN_REPO_LOCAL=/usr/src/mymaven/.m2/repository

docker-compose run --rm maven sh -c "cd third_party/markedj; mvn -Dmaven.repo.local=${MAVEN_REPO_LOCAL} install -DskipTests=true -Dmaven.javadoc.skip=true"
docker-compose run --rm maven sh -c "mvn -Dmaven.repo.local=${MAVEN_REPO_LOCAL} install -DskipTests=true -Dmaven.test.skip=true -Dmaven.javadoc.skip=true -e"
# docker-compose run --rm maven mvn clean test site -e
# docker-compose run --rm maven mvn clean package -e

if [ "$BUILD_ONLY" = true ]; then
   exit 0
fi

mkdir -p target/webapps
mv target/knowledge.war target/webapps/ROOT.war
docker-compose up --build -d tomcat
docker-compose logs -f tomcat
