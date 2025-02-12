# 🚀 Use Go Alpine as the base builder image
FROM golang:1.23-alpine AS builder

# Set working directory inside the container
WORKDIR /app

# Copy go module files first (optimizes Docker layer caching)
COPY go.mod ./
RUN go mod download

# Copy the rest of the application
COPY . .

# Build the Go application
RUN go build -o app

# 🎯 Use a smaller final image for production
FROM alpine:latest

# Set working directory
WORKDIR /app

# Copy only the built application from the builder stage
COPY --from=builder /app/app /app/app

# Copy static files if applicable
COPY --from=builder /app/static /app/static

# Expose the port used by the app
EXPOSE 8080

# Run the application
CMD ["/app/app"]
