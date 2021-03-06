#include <iostream>
#include <memory>
#include <string>

#include <grpc++/grpc++.h>

#ifdef BAZEL_BUILD
#include "examples/protos/pwave.grpc.pb.h"
#else
#include "pwave.grpc.pb.h"
#endif

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using pwave::HelloRequest;
using pwave::HelloReply;
using pwave::Greeter;

class GreeterClient {
 public:
  GreeterClient(std::shared_ptr<Channel> channel)
      : stub_(Greeter::NewStub(channel)) {}

  // Assembles the client's payload, sends it and presents the response back
  // from the server.
  std::string SayHello(const std::string& user) {
    // Data we are sending to the server.
    HelloRequest request;
    request.set_name(user);

    // Container for the data we expect from the server.
    HelloReply reply;

    // Context for the client. It could be used to convey extra information to
    // the server and/or tweak certain RPC behaviors.
    ClientContext context;

    // The actual RPC.
    Status status = stub_->SayHello(&context, request, &reply);

    // Act upon its status.
    if (status.ok()) {
      return reply.message();
    } else {
      std::cout << status.error_code() << ": " << status.error_message()
                << std::endl;
      return "RPC failed";
    }
  }

 private:
  std::unique_ptr<Greeter::Stub> stub_;
};

int main(int argc, char** argv) {
  // Instantiate the client. It requires a channel, out of which the actual RPCs
  // are created. This channel models a connection to an endpoint (in this case,
  // localhost at port 50051). We indicate that the channel isn't authenticated
  // (use of InsecureChannelCredentials()).
  /* GreeterClient greeter(grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials())); */
  GreeterClient greeter(grpc::CreateChannel("104.154.238.95:80", grpc::InsecureChannelCredentials()));
  /* GreeterClient greeter(grpc::CreateChannel("104.197.15.119:31140", grpc::InsecureChannelCredentials())); */

  for (int i = 0; i < 1000; i++) {
    std::string user("world");
    std::string reply = greeter.SayHello(user);
    std::cout << reply << std::endl;
  }

  return 0;
}
