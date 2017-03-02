FROM alpine:3.5

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

# Install dependencies for building httpdiff 
RUN apk --no-cache add ca-certificates && \
 apk --no-cache add --virtual build-dependencies curl git go musl-dev && \
 # Install bombardier client
 echo "Starting installing httplab." && \
 go get github.com/gchaincl/httplab && \
 go install github.com/gchaincl/httplab && \
 apk del build-dependencies

ENTRYPOINT ["/gopath/bin/httplab"]
#CMD [""]
