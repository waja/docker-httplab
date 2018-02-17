FROM alpine:3.7

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ARG "BUILD_DATE=unknown"
ARG "BUILD_VERSION=unknown"
ARG "VCS_URL=unknown"
ARG "VCS_REF=unknown"
ARG "VCS_BRANCH=unknown"

# See http://label-schema.org/rc1/ and https://microbadger.com/labels
LABEL org.label-schema.name="httplab - an interactive web server" \
    org.label-schema.description="Let you inspect HTTP requests and forge responses on Alpine Linux based container" \
    org.label-schema.vendor="Cyconet" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$BUILD_VERSION \
    org.label-schema.vcs-url=$VCS_URL \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-branch=$VCS_BRANCH

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
