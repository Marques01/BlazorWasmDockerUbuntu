# Etapa 1: Build do projeto
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia todos os arquivos para dentro do container
COPY . ./

# Publica o projeto principal
RUN dotnet publish BlazorWasmDockerUbuntu.csproj -c Release -o /app/publish

# Etapa 2: Usa o Nginx para servir os arquivos do wwwroot
FROM nginx:alpine
COPY --from=build /app/publish/wwwroot /usr/share/nginx/html

EXPOSE 80
