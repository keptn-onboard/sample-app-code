FROM bitnami/node:7
ENV NODE_ENV "production"
ENV PORT 8080
EXPOSE 8080

# Install additional dependencies required by the app
RUN install_packages libkrb5-dev

# Prepare app directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app/

COPY . /usr/src/app

RUN chown -R 1001:1001 /usr/src/app

USER 1001

# Start the app
#CMD ["/usr/local/bin/npm", "start", "--domain=.jx-staging.35.241.184.104.nip.io"] 
CMD ["npm", "start"]