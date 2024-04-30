# 第一阶段，用maven镜像进行编译
FROM maven:3.9.6-amazoncorretto-21 AS compile_stage
#定义工程名称
ENV PROJECT_NAME httpserver-spring
#定义工作目录
ENV WORK_PATH /usr/src/$PROJECT_NAME
#将源码复制到当前目录
COPY ./* $WORK_PATH
WORKDIR $WORK_PATH
#编译构建
RUN mvn clean package -U -DskipTests

# 第二阶段，用第一阶段的jar和jre镜像合成一个小体积的镜像
FROM eclipse-temurin:21-jre-alpine
#定义工程名称
ENV PROJECT_NAME httpserver-spring
LABEL app=$PROJECT_NAME
EXPOSE 9094
#定义工作目录
ENV WORK_PATH /usr/src/$PROJECT_NAME
#工作目录是/app
WORKDIR /app
#从名为compile_stage的stage复制构建结果到工作目录
COPY --from=compile_stage $WORK_PATH/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]