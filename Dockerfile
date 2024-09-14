FROM ubuntu:oracular

ENV MINECRAFT_VERSION=1.21.1
ENV FORGE_VERSION=52.0.15
ENV FORGE_URL=https://maven.minecraftforge.net/net/minecraftforge/forge/${MINECRAFT_VERSION}-${FORGE_VERSION}/forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar

RUN apt update -y && apt upgrade -y && apt install -y default-jre curl

RUN curl --create-dirs -sLo /usr/share/minecraft/forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar ${FORGE_URL} && \
    cd /usr/share/minecraft && \
    mkdir mods && \
    java -jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar --installServer && \
    rm -f forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-installer.jar.log run.bat run.sh

WORKDIR /usr/share/minecraft

COPY ./server.properties .
RUN echo eula=true > eula.txt
RUN echo "java -Xmx1024M -Xms1024M -jar forge-${MINECRAFT_VERSION}-${FORGE_VERSION}-shim.jar --nogui" > server.sh && chmod +x server.sh

EXPOSE 25565 25575

CMD ["bash", "-c", "/usr/share/minecraft/server.sh"]