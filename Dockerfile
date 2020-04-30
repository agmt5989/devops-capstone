FROM nginx:alpine
LABEL maintainer="agmt5989@yahoo.com"

## Step 1:
# Remove default config file for nginx
RUN rm /etc/nginx/conf.d/default.conf

## Step 2:
# Copy index.html file into web root
COPY . index.html /usr/share/nginx/html/

## Step 3:
# Copy new config file into /etc
COPY . nginx.conf /etc/nginx/

## Step 4:
# Expose port 80
EXPOSE 80