############################################################
# Dockerfile that contains SteamCMD
############################################################
FROM debian:stretch
LABEL maintainer="walentinlamonos@gmail.com"

# Install, update & upgrade packages
# Create user for the server
# This also creates the home directory we later need
# Clean TMP, apt-get cache and other stuff to make the image smaller
RUN apt-get update && apt-get install -y \
        lib32stdc++6 \
        lib32gcc1 \
        curl && \
        apt-get -y upgrade && \
        apt-get clean autoclean && \
        apt-get autoremove -y && \
        rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
        useradd -m steam

# Switch to user steam
USER steam

# Create Directory for SteamCMD
# Download SteamCMD
# Extract and delete archive
RUN mkdir -p /home/steam/steamcmd && cd /home/steam/steamcmd && \
        curl -o steamcmd_linux.tar.gz "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" && \
        tar zxf steamcmd_linux.tar.gz && \
        rm steamcmd_linux.tar.gz

VOLUME /home/steam/steamcmd
