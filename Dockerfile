FROM openjdk:17-oracle

WORKDIR /home/springpetclic/

COPY /var/lib/jenkins/workspace/Stage-2/artifacts/spring-petclinic-3.3.0-SNAPSHOT.jar .

EXPOSE 8080

ENV MYSQL_URL=jdbc:mysql://petclinic-mysql:3306/petclinic

CMD ["java", "-jar", "spring-petclinic-3.3.0-SNAPSHOT.jar"]

