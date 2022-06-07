export GO111MODULE=on
export GOOS:=$(shell go env GOOS)
export GOARCH:=$(shell go env GOARCH)
export GOVERSION:=1.12
export PROJECT=stats-api

export DOCKER_IMAGE_NAME?=stats-api
export DOCKER_IMAGE_TAG?=$(shell git rev-parse --short HEAD)
export DOCKER_REPO?=cloudnativeid

all: build run

run: build
	./bin/${PROJECT} --v=5 --logtostderr=true

test:
	go test ./...

build-docker:
	docker run -it -e GOOS=${GOOS} -e GOARCH=${GOARCH} -v $(shell pwd):/${PROJECT} -w /${PROJECT} golang:${GOVERSION} make build run

docker:
	docker build -t "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)" \
		-f ./Dockerfile .

docker-publish:
	docker push "$(DOCKER_REPO)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)"

build: clean
	go build -mod vendor -o bin/${PROJECT} .

generate:
	(cd api && go run github.com/99designs/gqlgen)

clean:
	sudo rm -f bin/${PROJECT}
