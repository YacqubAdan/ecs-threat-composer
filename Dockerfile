FROM node:23-slim AS build

WORKDIR /app

COPY app/package*.json yarn.lock ./

RUN yarn install 

COPY . .

RUN yarn build

FROM node:23-alpine

WORKDIR /app

COPY --from=build /app/build app/build

RUN addgroup -S nonroot && adduser -S nonroot -G nonroot

USER nonroot:nonroot

EXPOSE 3000

CMD ["npx","serve", "-s", "build"]