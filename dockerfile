# Use latest Go version (1.23)
FROM golang:1.23.4-alpine

# Set working directory inside the container
WORKDIR /app

# Copy go module files and download dependencies
COPY go.mod ./
RUN go mod download

# Copy the rest of the app files
COPY . .

# Build the Go application
RUN go build -o app

# Expose the port
EXPOSE 8080

# Run the application
CMD ["/app/app"]
