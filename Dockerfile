FROM golang:1.20 as builder
WORKDIR /go/src
COPY go.mod go.sum ./
RUN go mod download
COPY ./src/ .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./cmd/main.go

FROM gcr.io/distroless/base
COPY --from=builder /go/src/main .
USER nonroot:nonroot
CMD ["/main"]