FROM java:8-jdk

MAINTAINER Antonio Alonso Dominguez "alonso@codenibbles.com"

ENV DEBIAN_FRONTEND noninteractive
ENV TEAMCITY_VERSION 9.1.6
ENV TEAMCITY_AGENT_HOME /opt/lib/teamcity-agent


#Temcity
RUN mkdir -p /etc/teamcity-agent

COPY conf/* /etc/teamcity-agent/

RUN mkdir -p /opt/lib && \
    wget -nv http://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.war -O /tmp/TeamCity-$TEAMCITY_VERSION.war && \
    unzip -qq /tmp/TeamCity-$TEAMCITY_VERSION.war -d /tmp/teamcity && \
    unzip -qq /tmp/teamcity/update/buildAgent.zip -d $TEAMCITY_AGENT_HOME && \
    chmod +x $TEAMCITY_AGENT_HOME/bin/*.sh && \
    rm -f $TEAMCITY_AGENT_HOME/conf/buildAgent.properties && \
    ln -s /etc/teamcity-agent/buildAgent.properties $TEAMCITY_AGENT_HOME/conf/buildAgent.properties && \
    rm -fR /tmp/*

#Android sdk
ENV ANDROID_SDK_VERSION r24.4.1
ENV ANDROID_BUILD_TOOLS_VERSION 24.0.2
ENV ANDROID_API_LEVELS android-20,android-21,android-22,android-23,android-24
ENV EXTRA_PACKAGES build-tools-23.0.3

ENV ANDROID_SDK_FILENAME android-sdk_${ANDROID_SDK_VERSION}-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/${ANDROID_SDK_FILENAME}

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

##Packages for sdk
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y software-properties-common libncurses5:i386 libstdc++6:i386 zlib1g:i386 expect wget curl git build-essential \
    && apt-get update \
    && apt-get autoclean

RUN cd /opt && \
    wget -q ${ANDROID_SDK_URL} && \
    tar -xzf ${ANDROID_SDK_FILENAME} && \
    rm ${ANDROID_SDK_FILENAME} && \
    echo y | android update sdk --no-ui -a --filter tools,platform-tools,extra,${ANDROID_API_LEVELS},build-tools-${ANDROID_BUILD_TOOLS_VERSION},${EXTRA_PACKAGES}

#Entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 9090

VOLUME [ "/etc/teamcity-agent" ]

WORKDIR /opt/lib/teamcity-agent

ENTRYPOINT [ "/docker-entrypoint.sh" ]
