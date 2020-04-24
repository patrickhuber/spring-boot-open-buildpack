FROM gradle:jdk14 as build
COPY demo /opt/demo
RUN cd /opt/demo && \
    gradle clean build 

FROM java:jre14
COPY --from=build /opt/demo/build/libs/* /opt/demo/