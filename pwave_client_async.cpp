#include <iostream>
#include <memory>
#include <chrono>
#include <string>

#include <grpc++/grpc++.h>
#include <grpc/support/log.h>
#include <thread>

#include "pwave.grpc.pb.h"

using grpc::Channel;
using grpc::ClientAsyncResponseReader;
using grpc::ClientContext;
using grpc::CompletionQueue;
using grpc::Status;
using pwave::HelloRequest;
using pwave::HelloReply;
using pwave::Greeter;


class GreeterClient {
  public:
    explicit GreeterClient(std::shared_ptr<Channel> channel)
            : stub_(Greeter::NewStub(channel)) {}

    // Assembles the client's payload and sends it to the server.
    void SayHello(const std::string& user) {
        // Data we are sending to the server.
        HelloRequest request;
        request.set_name(user);

        // Call object to store rpc data
        AsyncClientCall* call = new AsyncClientCall;

        // stub_->AsyncSayHello() performs the RPC call, returning an instance to
        // store in "call". Because we are using the asynchronous API, we need to
        // hold on to the "call" instance in order to get updates on the ongoing RPC.
        call->response_reader = stub_->AsyncSayHello(&call->context, request, &cq_);


        // Request that, upon completion of the RPC, "reply" be updated with the
        // server's response; "status" with the indication of whether the operation
        // was successful. Tag the request with the memory address of the call object.
        call->response_reader->Finish(&call->reply, &call->status, (void*)call);

    }

    // Loop while listening for completed responses.
    // Prints out the response from the server.
    void AsyncCompleteRpc() {
        void* got_tag;
        bool ok = false;

        // Block until the next result is available in the completion queue "cq".
        while (cq_.Next(&got_tag, &ok)) {
            // The tag in this example is the memory location of the call object
            AsyncClientCall* call = static_cast<AsyncClientCall*>(got_tag);

            // Verify that the request was completed successfully. Note that "ok"
            // corresponds solely to the request for updates introduced by Finish().
            GPR_ASSERT(ok);

            if (call->status.ok())
                std::cout << "Greeter received: " << call->reply.message() << std::endl;
            else
                std::cout << "RPC failed" << std::endl;

            // Once we're complete, deallocate the call object.
            delete call;
        }
    }

  private:

    // struct for keeping state and data information
    struct AsyncClientCall {
        // Container for the data we expect from the server.
        HelloReply reply;

        // Context for the client. It could be used to convey extra information to
        // the server and/or tweak certain RPC behaviors.
        ClientContext context;

        // Storage for the status of the RPC upon completion.
        Status status;


        std::unique_ptr<ClientAsyncResponseReader<HelloReply>> response_reader;
    };

    // Out of the passed in Channel comes the stub, stored here, our view of the
    // server's exposed services.
    std::unique_ptr<Greeter::Stub> stub_;

    // The producer-consumer queue we use to communicate asynchronously with the
    // gRPC runtime.
    CompletionQueue cq_;
};

int main(int argc, char** argv) {


    // Instantiate the client. It requires a channel, out of which the actual RPCs
    // are created. This channel models a connection to an endpoint (in this case,
    // localhost at port 50051). We indicate that the channel isn't authenticated
    // (use of InsecureChannelCredentials()).
    /* GreeterClient greeter(grpc::CreateChannel("192.168.1.200:30080", grpc::InsecureChannelCredentials())); */
    GreeterClient greeter(grpc::CreateChannel("10.11.241.49:30080", grpc::InsecureChannelCredentials()));
    /* GreeterClient greeter(grpc::CreateChannel("192.168.1.200:80", grpc::InsecureChannelCredentials())); */

    // Spawn reader thread that loops indefinitely
    std::thread thread_ = std::thread(&GreeterClient::AsyncCompleteRpc, &greeter);

    for (int i = 0; i < 1000; i++) {
        std::string user("world " + std::to_string(i));
        printf("sending call %d\n", i);
        greeter.SayHello(user);  // The actual RPC call!
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
    }

    std::cout << "Press control-c to quit" << std::endl << std::endl;
    thread_.join();  //blocks forever

    return 0;
}
