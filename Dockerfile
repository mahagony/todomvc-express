FROM node:6-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# pass node environment: production (by default)
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

# install npm packages: clean obsolete files
COPY package.json /usr/src/app/
RUN npm install && npm cache clean

# copy source files
COPY . /usr/src/app

EXPOSE 3000

CMD [ "npm", "start" ]