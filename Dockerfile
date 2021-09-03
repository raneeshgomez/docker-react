# This is the Dockerfile for production environments

FROM node:lts-alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# Copy the build dir from the 0th build stage to the nginx dir
COPY --from=0 /app/build /usr/share/nginx/html

# Build with,
# docker build .

# Run with,
# docker run -p 8080:80 <container_id>