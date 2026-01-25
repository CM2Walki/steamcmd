############################################################
# Dockerfile that contains SteamCMD
############################################################
FROM debian:trixie-slim AS build_stage

LABEL maintainer="walentinlamonos@gmail.com"
ARG PUID=1000

ENV USER=steam
ENV HOMEDIR="/home/${USER}"
ENV STEAMCMDDIR="${HOMEDIR}/steamcmd"

RUN set -x \
    # Install, update & upgrade packages
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6=14.2.0-19 \
        lib32gcc-s1=14.2.0-19 \
        ca-certificates=20250419 \
        nano=8.4-1 \
        curl=8.14.1-2+deb13u2 \
        locales=2.41-12+deb13u1 \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    # Create unprivileged user
    && useradd -u "${PUID}" -m "${USER}" \
    # Download SteamCMD, execute as user
    && su "${USER}" -c \
        "mkdir -p \"${STEAMCMDDIR}\" \
                && curl -fsSL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
                && \"./${STEAMCMDDIR}/steamcmd.sh\" +quit \
                && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${STEAMCMDDIR}/steamservice.so\" \
                && mkdir -p \"${HOMEDIR}/.steam/sdk32\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${HOMEDIR}/.steam/sdk32/steamclient.so\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamcmd\" \"${STEAMCMDDIR}/linux32/steam\" \
                && mkdir -p \"${HOMEDIR}/.steam/sdk64\" \
                && ln -s \"${STEAMCMDDIR}/linux64/steamclient.so\" \"${HOMEDIR}/.steam/sdk64/steamclient.so\" \
                && ln -s \"${STEAMCMDDIR}/linux64/steamcmd\" \"${STEAMCMDDIR}/linux64/steam\" \
                && ln -s \"${STEAMCMDDIR}/steamcmd.sh\" \"${STEAMCMDDIR}/steam.sh\"" \
    # Symlink steamclient.so; So misconfigured dedicated servers can find it
    && ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so" \
    && rm -rf /var/lib/apt/lists/*

FROM build_stage AS trixie-root
WORKDIR ${STEAMCMDDIR}

FROM trixie-root AS trixie
# Switch to user
USER ${USER}
