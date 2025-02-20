# Étape 1 : Construire l'application React
FROM node:18-alpine AS build

WORKDIR /app

# Copier les fichiers package.json et package-lock.json pour installer les dépendances
COPY package.json package-lock.json ./
RUN npm install

# Copier tout le code source et builder l'application
COPY . .
RUN npm run build

# Étape 2 : Servir l'application avec un serveur HTTP léger
FROM node:18-alpine

WORKDIR /app

# Installer `serve` pour servir les fichiers statiques
RUN npm install -g serve

# Copier les fichiers buildés de l'étape précédente
COPY --from=build /app/build /app/build

# Exposer le port 3000
EXPOSE 3000

# Commande pour démarrer l'application
CMD ["serve", "-s", "build", "-l", "3000"]
