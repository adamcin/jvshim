FROM golang:1.10.3-alpine as build
RUN mkdir /app

ADD . /app/
WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o jvshim .

FROM scratch
COPY --from=build /app/jvshim /root/jvshim
ENTRYPOINT ["/root/jvshim"]