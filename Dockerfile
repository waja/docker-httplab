FROM golang:alpine as builder

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_URL
ARG VCS_REF
ARG VCS_BRANCH

# See http://label-schema.org/rc1/ and https://microbadger.com/labels
LABEL org.label-schema.name="httplab - an interactive web server" \
    org.label-schema.description="Let you inspect HTTP requests and forge responses on Alpine Linux based container" \
    org.label-schema.vendor="Cyconet" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date="${BUILD_DATE:-unknown}" \
    org.label-schema.version="${BUILD_VERSION:-unknown}" \
    org.label-schema.vcs-url="${VCS_URL:-unknown}" \
    org.label-schema.vcs-ref="${VCS_REF:-unknown}" \
    org.label-schema.vcs-branch="${VCS_BRANCH:-unknown}"

ENV HTTPLAB_VERSION v0.4.1
ENV UPSTREAM github.com/gchaincl/httplab

ENV GOPATH /gopath
ENV GOBIN /go/bin

RUN apk --no-cache update && apk --no-cache upgrade && \
 # Install dependencies for building httplab
 apk --no-cache add ca-certificates git && \
 # Build httplab client
 echo "Fetching httplab source" && \
 go get -d $UPSTREAM && \
 cd $GOPATH/src/$UPSTREAM/ && git checkout $HTTPLAB_VERSION && \
 echo "Getting dependancies" && \
 go get -d -v && \
 echo "Building httplab" && \
 CGO_ENABLED=0 go install -v -ldflags '-extldflags "-static"' $UPSTREAM/cmd/httplab

# start from scratch
FROM scratch
# Copy our static executable
COPY --from=builder /go/bin/httplab /go/bin/httplab

ENTRYPOINT ["/go/bin/httplab"]
#CMD [""]
