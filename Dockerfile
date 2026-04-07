# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia csproj primeiro (cache de restore)
COPY *.csproj ./
RUN dotnet restore

# Copia o restante
COPY . ./

# Publica
RUN dotnet publish BlazorApp.csproj -c Release -o /app/publish

# Etapa 2: Nginx
FROM nginx:alpine

# Copia arquivos do Blazor
COPY --from=build /app/publish/wwwroot /usr/share/nginx/html

# Corrige problema de refresh no Blazor
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
