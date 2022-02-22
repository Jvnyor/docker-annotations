# docker-annotations

Dockerfile Maven + JDK:

```
FROM maven:3.8.4-openjdk-11 as builder

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package
RUN mvn -f /usr/src/app clean compile assembly:single

FROM openjdk:11

COPY --from=builder /usr/src/app/target/projectname-VERSION-jar-with-dependencies.jar /usr/app/projectname-VERSION-jar-with-dependencies.jar

ENTRYPOINT ["java", "-cp", "/usr/app/projectname-VERSION-jar-with-dependencies.jar", "com.Jvnyor.projectname.App"]
```

pom.xml for Dockerfile Maven + JDK:

```
<plugin>
      <artifactId>maven-assembly-plugin</artifactId>
      <configuration>
        <archive>
          <manifest>
            <mainClass>org.example.projectname.App</mainClass>
          </manifest>
        </archive>
        <descriptorRefs>
          <descriptorRef>jar-with-dependencies</descriptorRef>
        </descriptorRefs>
      </configuration>
</plugin>
```

Dockerfile JDK for simple Java App:

```
FROM openjdk:11

COPY target/projectname-VERSION.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
```
