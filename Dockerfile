    FROM golang:1.22 AS builder
    WORKDIR /app
    COPY go.mod .
    RUN go mod download
    COPY . .
    RUN go build -o main .

    #final stage distroless image
    FROM gcr.io/distroless/base
    COPY --from=builder /app/main .
    COPY --from=builder /app/static ./static
    EXPOSE 8081
    CMD [ "./main" ]