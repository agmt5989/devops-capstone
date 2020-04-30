FROM nginx:alpine
LABEL maintainer="agmt5989@yahoo.com"

## Step 1:
# Copy index.html file into web root
COPY . index.html /usr/share/nginx/html/

## Step 2:
# Expose port 80
EXPOSE 80