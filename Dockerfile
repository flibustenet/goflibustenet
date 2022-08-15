FROM amd64/golang as builder
WORKDIR /app
COPY . /app
RUN go mod download
RUN go build -o goflibustenet

FROM debian:buster-slim
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/goflibustenet /app/goflibustenet
#COPY template/ /app/template/
#COPY static/ /app/static/

# Run the web service on container startup.
ENV PORT 8080
EXPOSE 8080
WORKDIR /app
CMD ["/app/goflibustenet"]

