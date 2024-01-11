# Base image
FROM node:18.16.0-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json .
COPY package-lock.json .

# download google chrome for puppeteer 
RUN apk update apk add wget
RUN apk add chromium

#puppeteer environmentals variables
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser


# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .
RUN npm run build

# Expose the port (change if needed)
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start:prod"]
