FROM node:18-alpine
# Official Node.js 18 image

WORKDIR /usr/src/app
# Set work directory
COPY package*.json ./
# Copy package.json and package-lock.json if available to the container
RUN npm install
# Instal project dependencies
COPY . .
# Copy all files into container
EXPOSE 3000
CMD ["npm", "start"]
# Commands to run when the container starts