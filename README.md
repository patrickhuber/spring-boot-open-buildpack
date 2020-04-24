# Spring Boot with buildpacks.io java buildpack

## Download dependencies

[pack cli](https://github.com/buildpacks/pack/releases)

## Generate your Application

[Spring Initializer for this demo](https://start.spring.io/#!type=gradle-project&language=java&platformVersion=2.2.6.RELEASE&packaging=jar&jvmVersion=14&groupId=com.example&artifactId=demo&name=demo&description=Demo%20project%20for%20Spring%20Boot&packageName=com.example.demo&dependencies=web)

## Download the application from spring initializer

```
curl https://start.spring.io/starter.tgz \
    -d dependencies=web,actuator \
    -d language=java \
    -d platformVersion=2.2.6.RELEASE \
    -d packaging=jar \
    -d packageName=com.example.demo \
    -d jvmVersion=14 \
    -d type=gradle-project \
    -d baseDir=demo \
| tar -xzvf -
```

## Create a Home Controller

[documentation](https://spring.io/guides/gs/spring-boot/)

> make sure to put your controller in the correct package namespace

Install the source [Home Controller](demo\src\main\java\com\example\demo\HelloController.java)

## Build the container with the pack cli

[build script](build.ps1)

Example: 

```
pack build --builder cloudfoundry/cnb:bionic -p demo demo
```

## Run the container

Example: 

```
docker run 
```