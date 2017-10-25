#!/bin/bash

export DOCKER_AUTH=$DOCKER_USERNAME/vento-auth
export DOCKER_CONFIG=$DOCKER_USERNAME/vento-config
export DOCKER_GATEWAY=$DOCKER_USERNAME/vento-gateway
export DOCKER_ELASTICSEARCH=$DOCKER_USERNAME/vento-elasticsearch
export DOCKER_KIBANA=$DOCKER_USERNAME/vento-kibana
export DOCKER_LOGSTASH=$DOCKER_USERNAME/vento-logstash
export DOCKER_MATCH=$DOCKER_USERNAME/vento-match
export DOCKER_MONITORING=$DOCKER_USERNAME/vento-monitoring
export DOCKER_PROFILE=$DOCKER_USERNAME/vento-profile
export DOCKER_REGISTRY=$DOCKER_USERNAME/vento-registry
export DOCKER_TRACING=$DOCKER_USERNAME/vento-tracing
export COMMIT=${TRAVIS_COMMIT::7}
export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`

if [ "$TRAVIS_BRANCH" == "master" ]; then
	docker --version
	docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
	
	echo ${DOCKER_AUTH}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/auth-service
	docker build -t ${DOCKER_AUTH} .
	docker tag ${DOCKER_AUTH}:${TAG} && docker push ${DOCKER_AUTH}:${TAG}

	echo ${DOCKER_CONFIG}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/config
	docker build -t ${DOCKER_CONFIG} .
	docker tag ${DOCKER_CONFIG}:${TAG} && docker push ${DOCKER_CONFIG}:${TAG}

	echo ${DOCKER_GATEWAY}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/gateway
	docker build -t ${DOCKER_GATEWAY} .
	docker tag ${DOCKER_GATEWAY}:${TAG} && docker push ${DOCKER_GATEWAY}:${TAG}

	echo ${DOCKER_ELASTICSEARCH}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/logging/elasticsearch
	docker build -t ${DOCKER_ELASTICSEARCH} .
	docker tag ${DOCKER_ELASTICSEARCH}:${TAG} && docker push ${DOCKER_ELASTICSEARCH}:${TAG}

	echo ${DOCKER_KIBANA}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/logging/kibana
	docker build -t ${DOCKER_KIBANA} .
	docker tag ${DOCKER_KIBANA}:${TAG} && docker push ${DOCKER_KIBANA}:${TAG}

	echo ${DOCKER_LOGSTASH}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/logging/logstash
	docker build -t ${DOCKER_LOGSTASH} .
	docker tag ${DOCKER_LOGSTASH}:${TAG} && docker push ${DOCKER_LOGSTASH}:${TAG}

	echo ${DOCKER_MATCH}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/match-service
	docker build -t ${DOCKER_MATCH} .
	docker tag ${DOCKER_MATCH}:${TAG} && docker push ${DOCKER_MATCH}:${TAG}

	echo ${DOCKER_MONITORING}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/monitoring
	docker build -t ${DOCKER_MONITORING} .
	docker tag ${DOCKER_MONITORING}:${TAG} && docker push ${DOCKER_MONITORING}:${TAG}

	echo ${DOCKER_PROFILE}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/profile-service
	docker build -t ${DOCKER_PROFILE} .
	docker tag ${DOCKER_PROFILE}:${TAG} && docker push ${DOCKER_PROFILE}:${TAG}

	echo ${DOCKER_REGISTRY}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/registry
	docker build -t ${DOCKER_REGISTRY} .
	docker tag ${DOCKER_REGISTRY}:${TAG} && docker push ${DOCKER_REGISTRY}:${TAG}

	echo ${DOCKER_TRACING}:${TAG}
	cd ${TRAVIS_BUILD_DIR}/tracing
	docker build -t ${DOCKER_TRACING} .
	docker tag ${DOCKER_TRACING}:${TAG} && docker push ${DOCKER_TRACING}:${TAG}

	cd ${TRAVIS_BUILD_DIR}
fi

echo $?

