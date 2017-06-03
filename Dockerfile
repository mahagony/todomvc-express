FROM alpine:3.5

# install node
RUN apk add --no-cache nodejs-current tini

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Build time argument to set NODE_ENV ('production'' by default)
ARG NODE_ENV
ENV NODE_ENV ${NODE_ENV:-production}

# install npm packages: clean obsolete files
COPY package.json /usr/src/app/
RUN npm config set depth 0 && \
    npm install && \
    npm cache clean && \
    rm -rf /tmp/*

# copy source files
COPY . /usr/src/app

EXPOSE 3000

# Set tini as entrypoint
ENTRYPOINT ["/sbin/tini", "--"]

CMD [ "npm", "start" ]