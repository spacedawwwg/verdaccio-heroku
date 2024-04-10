# Use an official Node runtime as a parent image
FROM node:20-alpine

# Set the working directory in the container to /verdaccio
WORKDIR /verdaccio

# Copy package.json and package-lock.json
COPY package*.json ./

# Install Verdaccio
RUN npm install verdaccio@latest-6

# Copy the Verdaccio configuration file into the Docker container
COPY ./config.yaml ./
COPY ./.htpasswd ./conf/

EXPOSE $PORT

# Heroku dynamically assigns a port which is accessible via the PORT environment variable
CMD npx verdaccio --config ./config.yaml --listen 0.0.0.0:$PORT