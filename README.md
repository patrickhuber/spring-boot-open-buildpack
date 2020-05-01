# Spring Boot with buildpacks.io java buildpack

## Download dependencies

* [pack cli](https://github.com/buildpacks/pack/releases)
* [kpack cli]()

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

### Run the app using pack cli and docker

## Build the container with the pack cli

[build script](pack/build.ps1)

Example: 

```
pack build --builder cloudfoundry/cnb:bionic -p demo demo
```

## Run the container

[run script](docker/run.ps1)

Example: 

```
docker run --rm --name demo -p 8080:8080 demo
```

### Run the app using kubernetes

Tag the image 

```
docker tag demo patrickhuber/spring-boot-open-buildpack:v1.0.0
```

Push the image

```
docker push patrickhuber/spring-boot-open-buildpack:tagname
```

Apply the deployment and service

```
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```

Forward local port to service port

```
kubectl port-forward service/java-deployment 7000:8080
```

check in browser

```
curl http://localhost:7000
```

```
Greetings from Spring Boot!
```

### Run the app using kpack cli and kubernetes (not currently working)

[documentation](https://github.com/pivotal/kpack/blob/master/docs/install.md)

## Install kpack controller

```
kubectl apply -f https://github.com/pivotal/kpack/releases/download/v0.0.8/release-0.0.8.yaml
```

## Verify kpack is running

```
kubectl get pods --namespace kpack --watch
```

## Create the ClusterBuilder resource

[cluster-builder resource](kpack/cluster-builder.yml)

```
kubectl apply -f kpack/cluster-builder.yml
kubectl describe clusterbuilder default
```

```
Name:         default
Namespace:
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"build.pivotal.io/v1alpha1","kind":"ClusterBuilder","metadata":{"annotations":{},"name":"default"},"spec":{"image":"gcr.io/p...
API Version:  build.pivotal.io/v1alpha1
Kind:         ClusterBuilder
Metadata:
  Creation Timestamp:  2020-04-24T18:34:21Z
  Generation:          1
  Resource Version:    6938458
  Self Link:           /apis/build.pivotal.io/v1alpha1/clusterbuilders/default
  UID:                 976eb26b-8550-47ef-bc23-38194fb19b2a
Spec:
  Image:          gcr.io/paketo-buildpacks/builder:base
  Update Policy:  polling
Status:
  Builder Metadata:
    Id:       paketo-buildpacks/go
    Version:  v0.0.1
    Id:       paketo-buildpacks/dotnet-core
    Version:  v0.0.1
    Id:       paketo-buildpacks/nodejs
    Version:  v0.0.1
    Id:       paketo-buildpacks/dep
    Version:  0.0.109
    Id:       paketo-buildpacks/go-compiler
    Version:  0.0.112
    Id:       paketo-buildpacks/go-mod
    Version:  0.0.96
    Id:       paketo-buildpacks/dotnet-core-conf
    Version:  0.0.122
    Id:       paketo-buildpacks/dotnet-core-runtime
    Version:  0.0.135
    Id:       paketo-buildpacks/dotnet-core-sdk
    Version:  0.0.133
    Id:       paketo-buildpacks/icu
    Version:  0.0.52
    Id:       paketo-buildpacks/node-engine
    Version:  0.0.178
    Id:       paketo-buildpacks/dotnet-core-aspnet
    Version:  0.0.128
    Id:       paketo-buildpacks/dotnet-core-build
    Version:  0.0.70
    Id:       paketo-buildpacks/node-engine
    Version:  0.0.178
    Id:       paketo-buildpacks/npm
    Version:  0.1.11
    Id:       paketo-buildpacks/yarn-install
    Version:  0.1.19
    Id:       paketo-buildpacks/encrypt-at-rest
    Version:  1.2.0
    Id:       paketo-buildpacks/dist-zip
    Version:  1.2.0
    Id:       paketo-buildpacks/bellsoft-liberica
    Version:  2.3.0
    Id:       paketo-buildpacks/build-system
    Version:  1.2.0
    Id:       paketo-buildpacks/jmx
    Version:  1.1.0
    Id:       paketo-buildpacks/procfile
    Version:  1.3.0
    Id:       paketo-buildpacks/azure-application-insights
    Version:  1.1.0
    Id:       paketo-buildpacks/spring-boot
    Version:  1.5.0
    Id:       paketo-buildpacks/apache-tomcat
    Version:  1.1.0
    Id:       paketo-buildpacks/executable-jar
    Version:  1.2.0
    Id:       paketo-buildpacks/debug
    Version:  1.2.0
    Id:       paketo-buildpacks/google-stackdriver
    Version:  1.1.0
  Conditions:
    Last Transition Time:  2020-04-24T18:34:22Z
    Status:                True
    Type:                  Ready
  Latest Image:            gcr.io/paketo-buildpacks/builder@sha256:5ebc99f52778166bb410815f5c732f91a84d04b8a9a6da2b1fb5736133134a24
  Observed Generation:     1
  Stack:
    Id:         io.buildpacks.stacks.bionic
    Run Image:  gcr.io/paketo-buildpacks/run@sha256:fd87df6a892262c952559a164b8e2ad1be7655021ad50d520085a19a082cd379
Events:         <none>
```