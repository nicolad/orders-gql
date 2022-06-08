#bin/bash
# in this example we'll use two protoc plugins:
# 1 - the `go_opt` parameter generates golang objects representing the protobuf objects in Go
# 2 - the `go-grpc_out` parameter generates the necessary server objects to deploy the services as gRPC services.
# prerequisites: https://grpc.io/docs/languages/go/quickstart/#prerequisites
protoc --go_out=lib/go --go_opt=paths=source_relative --go-grpc_out=lib/go --go-grpc_opt=paths=source_relative orders.proto