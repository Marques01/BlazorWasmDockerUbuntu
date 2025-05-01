# Etapa 1: Build do projeto
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia tudo e publica
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Nginx para servir os arquivos estáticos
FROM nginx:alpine
COPY --from=build /app/publish/wwwroot /usr/share/nginx/html

# Copia uma config personalizada opcional (para SPA routing, por exemplo)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80