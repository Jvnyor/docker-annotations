FROM maven:3.8.4-openjdk-11 as builder

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package
RUN mvn -f /usr/src/app mvn clean compile assembly:single

FROM openjdk:11

COPY --from=builder /usr/src/app/target/projectname-VERSION-jar-with-dependencies.jar /usr/app/projectname-VERSION-jar-with-dependencies.jar

ENTRYPOINT ["java", "-cp", "/usr/app/projectname-VERSION-jar-with-dependencies.jar", "com.Jvnyor.projectname.App"]
