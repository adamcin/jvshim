FROM golang:1.10.3-alpine as build
ADD . /go/src/jvshim
RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo jvshim

FROM scratch
COPY --from=build /go/ /go/
ENTRYPOINT ["/go/bin/jvshim"]