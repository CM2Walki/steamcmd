############################################################
# Dockerfile that contains SteamCMD and Box86/64
############################################################

############################################
# Box86/64 Build Stage
############################################
FROM arm64v8/debian:bullseye as box_build

RUN dpkg --add-architecture armhf && \
    apt-get update && \
    apt-get install --yes --no-install-recommends git python3 build-essential cmake ca-certificates && \
    apt-get install --yes --no-install-recommends gcc-arm-linux-gnueabihf libc6-dev-armhf-cross libc6:armhf libstdc++6:armhf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

RUN git clone https://github.com/ptitSeb/box86.git; mkdir /box86/build && \
    git clone https://github.com/ptitSeb/box64.git; mkdir /box64/build

WORKDIR /box86/build
RUN cmake .. -DRPI4ARM64=1 -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo && \
    make -j$(nproc) && \
    make install DESTDIR=/tmp/install

WORKDIR /box64/build
RUN cmake .. -DRPI4ARM64=1 -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo && \
    make -j$(nproc) && \
    make install DESTDIR=/tmp/install

############################################
# SteamCMD Build Stage
############################################

FROM arm64v8/debian:bullseye-slim as build_stage

COPY --from=box_build /tmp/install / 

LABEL maintainer="github@snry.me"
ARG PUID=1000

ENV USER steam
ENV HOMEDIR "/home/${USER}"
ENV STEAMCMDDIR "${HOMEDIR}/steamcmd"

ENV DEBUGGER "/usr/local/bin/box86"

RUN set -x \
	# Install, update & upgrade packages
        && dpkg --add-architecture armhf \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		libc6:armhf \
		libstdc++6:armhf \
		ca-certificates=20210119 \
		nano=5.4-2+deb11u2 \
		curl=7.74.0-1.3+deb11u11 \
		locales=2.31-13+deb11u7 \
	&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
	&& dpkg-reconfigure --frontend=noninteractive locales \
	# Create unprivileged user
	&& useradd -u "${PUID}" -m "${USER}" \
        # Download SteamCMD, execute as user
        && su "${USER}" -c \
		"mkdir -p \"${STEAMCMDDIR}\" \
                && curl -fsSL 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar xvzf - -C \"${STEAMCMDDIR}\" \
                && ${STEAMCMDDIR}/steamcmd.sh +quit \
                && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${STEAMCMDDIR}/steamservice.so\" \
                && ln -s \"${STEAMCMDDIR}/linux32/steamclient.so\" \"${STEAMCMDDIR}/linux32/steamservice.so\" \
                && ln -s \"${STEAMCMDDIR}/linux64/steamclient.so\" \"${STEAMCMDDIR}/linux64/steamservice.so\" \
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

# Cleanup
RUN rm -rf /var/lib/apt/lists/*

FROM build_stage AS bullseye-root
WORKDIR ${STEAMCMDDIR}

FROM bullseye-root AS bullseye
# Switch to user
USER ${USER}
