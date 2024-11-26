# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Copy the custom index.html file to the Nginx HTML directory
COPY index.html /usr/share/nginx/html/index.html

# Copy the images directory to the Nginx HTML directory
COPY img /usr/share/nginx/html/img

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
