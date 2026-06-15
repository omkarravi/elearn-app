# Stage 1: Build
FROM node:20-bullseye-slim as builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Stage 2: NGINX
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
# uat branch ka dockerfile hai ye, isme humne do stages banayi hai. pehle stage me hum node image use kar rahe hai jisme hum apne app ko build karenge. dusre stage me hum nginx image use kar rahe hai jisme hum apne build files ko copy karenge aur nginx server ko start karenge. isse humara app production ready ho jayega aur nginx ke through serve hoga.