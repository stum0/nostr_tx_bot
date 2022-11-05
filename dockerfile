FROM node:alpine AS builder
WORKDIR /app
COPY ["package.json", "package-lock.json", "tsconfig.json", "jest.config.ts", "./"],
COPY ["src/", "./src/"]
COPY ["test/", "./test/"]
RUN npm install \ 
&& npm run test \
&& npm run build 

FROM node:alpine AS final
WORKDIR /app
COPY --from=builder ./app/dist ./dist
COPY ["package.json", "package-lock.json", "./"],
RUN npm install --production
CMD npm start