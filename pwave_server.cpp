#include <iostream>
#include <memory>
#include <string>

#include <grpc++/grpc++.h>

#ifdef BAZEL_BUILD
#include "examples/protos/pwave.grpc.pb.h"
#else
#include "pwave.grpc.pb.h"
#endif

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;
using pwave::HelloRequest;
using pwave::HelloReply;
using pwave::Greeter;
using pwave::Raytrace;
using pwave::ray_config_t;
using pwave::ray_t;

// Logic and data behind the server's behavior.
class GreeterServiceImpl final : public Greeter::Service 
{

  Status SayHello(ServerContext* context, const HelloRequest* request, HelloReply* reply) override 
  {
		const char *my_pod_name = std::getenv("MY_POD_NAME");
		const char *my_node_name = std::getenv("MY_NODE_NAME");

    std::string info;

    if (my_pod_name && my_node_name)  {
      std::string str_pod_name(my_pod_name);
      std::string str_node_name(my_node_name);

      info = "[" + str_node_name + ":" + str_pod_name + "] ";
    } else {
      info = "[unknown]";
    }

    std::string prefix("Hello");
    reply->set_message(info + prefix + request->name());
    printf("said hello\n");
    return Status::OK;
  }

};


class RaytraceServiceImpl final : public Raytrace::Service 
{
  Status compute(ServerContext* context, const ray_config_t *request, ray_t *reply) override 
  {
    return Status::OK;
  }

};


void RunServer() {
  std::string server_address("0.0.0.0:50051");
  GreeterServiceImpl service;

  ServerBuilder builder;
  // Listen on the given address without any authentication mechanism.
  builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
  // Register "service" as the instance through which we'll communicate with
  // clients. In this case it corresponds to an *synchronous* service.
  builder.RegisterService(&service);
  // Finally assemble the server.
  std::unique_ptr<Server> server(builder.BuildAndStart());
  std::cout << "Server listening on " << server_address << std::endl;

  // Wait for the server to shutdown. Note that some other thread must be
  // responsible for shutting down the server for this call to ever return.
  server->Wait();
}

int main(int argc, char** argv) {
  RunServer();

  return 0;
}
