FROM node:8.9.3
COPY . /app
WORKDIR /app
RUN ["npm", "install"]
CMD ["npm", "run", "start:dev"]
EXPOSE 3000
