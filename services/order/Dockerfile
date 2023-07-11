FROM node:14.15.4-alpine3.12

# RUN apk add --no-cache bash curl && \                                         
#     curl -o- -L https://yarnpkg.com/install.sh | bash \
#     curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh && \
#     chmod +x /usr/bin/wait-for

RUN npm install -g @nestjs/cli

USER node

WORKDIR /home/node/app