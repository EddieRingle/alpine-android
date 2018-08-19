FROM frolvlad/alpine-glibc:alpine-3.8

RUN apk add --no-cache \
  openjdk8 \
  bash \
  unzip

ENV JAVA8_HOME /usr/lib/jvm/java-1.8-openjdk
ENV JAVA_HOME $JAVA8_HOME
ENV PATH $PATH:$JAVA_HOME/bin

ENV ANDROID_SDK_FILE sdk-tools-linux-4333796.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILE}
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
  echo "Wget'ing ${ANDROID_SDK_URL} ..." && \
  wget -q ${ANDROID_SDK_URL} && \
  unzip ${ANDROID_SDK_FILE} && \
  rm ${ANDROID_SDK_FILE} && \
  mkdir -p ${ANDROID_HOME}/licenses && \
  echo -e "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > ${ANDROID_HOME}/licenses/android-sdk-license && \
  echo -e "99c0028c33805669c5aafd6a51857a5e95b90d6e\n84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license && \
  echo y | sdkmanager --channel=3 tools platform-tools \
    "platforms;android-28" \
    "build-tools;28.0.2" && \
  mkdir -p ~/.gradle && echo "org.gradle.daemon=false" >> ~/.gradle/gradle.properties
