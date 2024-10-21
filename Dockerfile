FROM openjdk:17-oracle

RUN mkdir -p /home/petclinic

WORKDIR /home/petclinic/

COPY target/*.jar /home/petclinic/

EXPOSE 8080

ENV MYSQL_URL=jdbc:mysql://petclinic-mysql:3306/petclinic

CMD ["java", "-jar", "spring-petclinic-3.2.0-SNAPSHOT.jar"]
