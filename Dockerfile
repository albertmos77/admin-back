# Usar una imagen base con Maven y Java
FROM maven:3.8.7-eclipse-temurin-17 AS build

WORKDIR /app

# Copia el código fuente y archivos de configuración
COPY . .

# Construir el proyecto y empaquetar el jar
RUN mvn clean package -DskipTests

# Usar una imagen ligera de Java para ejecutar el jar
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copiar el jar generado desde la etapa de build
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto de la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]