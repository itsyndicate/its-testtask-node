FROM node:14.21-alpine
COPY . /app
WORKDIR /app
RUN ["npm", "install"]
CMD ["npm", "run", "start:dev"]
EXPOSE 3000
