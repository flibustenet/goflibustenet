# syntax = docker/dockerfile:1-experimental
FROM amd64/golang as builder
WORKDIR /app
COPY go.* /app/
RUN go mod download
COPY . /app
RUN --mount=type=cache,target=/root/.cache/go-build \
    go build -o goflibustenet

FROM gcr.io/distroless/static-debian11
COPY --from=builder /app/goflibustenet /app/goflibustenet

# Run the web service on container startup.
ENV PORT 8080
EXPOSE 8080
WORKDIR /app
CMD ["/app/goflibustenet"]

