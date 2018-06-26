FROM golang:1.10.3-alpine as build
#RUN apk add --no-cache --virtual git
#RUN go get \
    #github.com/aws/aws-sdk-go-v2 \
    #github.com/jmespath/go-jmespath \
    #github.com/hashicorp/golang-lru \
    #github.com/go-ini/ini
RUN mkdir /app

ADD . /app/
WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch
COPY --from=build /app/main /root/jvshim
ENTRYPOINT ["/root/jvshim"]