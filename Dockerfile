FROM node:lts-alpine

ENV NODE_ENV=production
# Adding build tools to make yarn install work on Apple silicon / arm64 machines
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production

CMD node .