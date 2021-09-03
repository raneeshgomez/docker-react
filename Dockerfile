# This is the Dockerfile for production environments

# When there are multi-step build processes in a container, it is better to alias a build step with a name (using AS instruction)
FROM node:lts-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# Copy the build dir from the "builder" step to the nginx dir
COPY --from=builder /app/build /usr/share/nginx/html

# Build with,
# docker build .

# Run with,
# docker run -p 8080:80 <container_id>