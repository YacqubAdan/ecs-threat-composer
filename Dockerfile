FROM node:23-slim AS build

WORKDIR /app

COPY package*.json yarn.lock ./

RUN yarn install 

COPY . .

RUN yarn build

FROM node:23-alpine

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/build ./build

USER nonroot:nonroot

EXPOSE 3000

CMD ["npx","serve", "-s", "build"]