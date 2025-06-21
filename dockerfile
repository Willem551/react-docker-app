# Étape 1 : Build de l'app React
FROM node:18-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Étape 2 : Serveur web (Nginx)
FROM nginx:alpine

# Copie du build vers le répertoire de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Copie optionnelle d’un fichier custom de conf Nginx
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
