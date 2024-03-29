# Stage 1: Build assets
FROM node:14 as builder

WORKDIR /app

# Copy package.json and package-lock.json
COPY . ./

# Build assets
RUN cd demoapp && npm install && npm run build 

#Stage 2: Serve assets with nginx
FROM nginx:latest

# Copy nginx configuration
#COPY nginx.conf /etc/nginx/nginx.conf

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy assets from the builder stage to nginx
COPY --from=builder /app/demoapp/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
# CMD ["nginx", "-g", "daemon off;"]
