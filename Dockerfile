FROM amd64/golang:1.21 as builder
WORKDIR /app
COPY . /app
RUN CGO_ENABLED=0 go build -o goflibustenet

FROM gcr.io/distroless/static-debian11
COPY --from=builder /app/goflibustenet /app/goflibustenet

# Run the web service on container startup.
ENV PORT 8080
EXPOSE 8080
WORKDIR /app
CMD ["/app/goflibustenet"]

