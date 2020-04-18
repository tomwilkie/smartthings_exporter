FROM golang:1.14.2
WORKDIR /go/src/github.com/kadaan/smartthings_exporter/
COPY go.mod go.sum smartthings_exporter.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o smartthings_exporter ./

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=0 /go/src/github.com/kadaan/smartthings_exporter/smartthings_exporter /usr/bin/smartthings_exporter
ENTRYPOINT [ "/usr/bin/smartthings_exporter" ]
