# Build the Go Binary.
FROM golang:1.20 as build_coffeeshop-api
ENV CGO_ENABLED 0
ARG BUILD_REF

# Create the service directory and the copy the module files first and then
# download the dependencies. If this doesn't change, we won't need to do this
# again in future builds.
RUN mkdir /coffeeshop
COPY go.* /coffeeshop/
WORKDIR /coffeeshop
RUN go mod download

# Copy the source code into the container.
COPY . /coffeeshop

# Build the service binary.
WORKDIR /coffeeshop/cmd/coffeeshop-api
RUN go build -ldflags "-X main.build=${BUILD_REF}"


# Run the Go Binary in Alpine.
FROM alpine:3.18
ARG BUILD_DATE
ARG BUILD_REF
RUN addgroup -g 1000 -S coffeeshop && \
    adduser -u 1000 -h /coffeeshop -G coffeeshop -S coffeeshop
COPY --from=build_coffeeshop-api --chown=coffeeshop:coffeeshop /coffeeshop/cmd/coffeeshop-api /coffeeshop/coffeeshop-api
WORKDIR /coffeeshop
USER coffeeshop
CMD ["./coffeeshop-api"]

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.title="coffeeshop-api" \
      org.opencontainers.image.authors="Jakub Jarosz <j.jarosz@f5.com>" \
      org.opencontainers.image.source="https://github.com/jjngx/coffeeshop/cmd/coffeeshop-api" \
      org.opencontainers.image.revision="${BUILD_REF}"
