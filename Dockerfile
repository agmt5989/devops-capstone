FROM nginx:alpine

## Step 1:
# Create a working directory
#WORKDIR /app


COPY . index.html /usr/share/nginx/html/

# Run a command
CMD ["nginx"]

# Expose
EXPOSE 80