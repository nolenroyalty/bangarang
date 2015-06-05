FROM golang:1.4

ENV DEBIAN_FRONTEND noninteractive

# fetch code generation deps
RUN go get -u github.com/pquerna/ffjson
RUN go get -u github.com/tinylib/msgp

# build the command_
RUN go get -u github.com/eliothedeman/bangarang/cmd/bangarang/
RUN go generate github.com/eliothedeman/bangarang/...
RUN go build -o /go/bin/bangaran github.com/eliothedeman/bangarang/cmd/bangarang
RUN export PATH=$PATH:/go/bin

EXPOSE 5555 
EXPOSE 5556 

ENTRYPOINT /go/bin/bangarang -conf=/etc/bangarang/conf.json
