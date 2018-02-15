FROM alpine:3.7

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ENV HTTPLAB_VERSION v0.4.0
ENV UPSTREAM github.com/gchaincl/httplab

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN apk --no-cache update && apk --no-cache upgrade && \
 # Install dependencies for building httpdiff 
 apk --no-cache add ca-certificates && \
 apk --no-cache add --virtual build-dependencies curl git go musl-dev && \
 # Install bombardier client
 echo "Starting installing httplab." && \
 go get -d $UPSTREAM && \
 cd $GOPATH/src/$UPSTREAM/ && git checkout $HTTPLAB_VERSION && \
 go install $UPSTREAM/cmd/httplab && \
 apk del build-dependencies

ENTRYPOINT ["/gopath/bin/httplab"]
#CMD [""]
