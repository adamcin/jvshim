FROM golang:1.10.3-alpine as build
RUN mkdir /app

ADD . /go/src/jvshim
#WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo jvshim
RUN CGO_ENABLED=0 GOOS=darwin go install -a -installsuffix cgo jvshim

FROM scratch
COPY --from=build /go/ /go/
COPY --from=build /go/bin/jvshim /root/jvshim
ENTRYPOINT ["/root/jvshim"]