FROM gradle:6.3.0-jdk11 as compile
COPY . /home/source/java
WORKDIR /home/source/java
# Default gradle user is `gradle`. We need to add permission on working directory for gradle to build.
USER root
RUN chown -R gradle /home/source/java
USER gradle
RUN gradle clean build

FROM adoptopenjdk/openjdk11:alpine-jre 
WORKDIR /home/application/java
RUN mkdir cidemo
COPY --from=compile "/home/source/java/build/libs/ci-demo-0.0.1-SNAPSHOT.jar" cidemo/ci-demo-0.0.1-SNAPSHOT.jar
EXPOSE 3000
ENTRYPOINT [ "java", "-jar", "/home/application/java/cardinal-cidemo-0.1.0.jar"]
