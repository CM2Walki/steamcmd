[![](https://img.shields.io/codacy/grade/6a8e207cf98246169e633d6f22da9d9c)](https://hub.docker.com/r/sonroyaalmerol/steamcmd-arm64/) [![Docker Build Status](https://img.shields.io/docker/cloud/build/sonroyaalmerol/steamcmd-arm64.svg)](https://hub.docker.com/r/sonroyaalmerol/steamcmd-arm64/) [![Docker Stars](https://img.shields.io/docker/stars/sonroyaalmerol/steamcmd-arm64.svg)](https://hub.docker.com/r/sonroyaalmerol/steamcmd-arm64/) [![Docker Pulls](https://img.shields.io/docker/pulls/sonroyaalmerol/steamcmd-arm64.svg)](https://hub.docker.com/r/sonroyaalmerol/steamcmd-arm64/) [![](https://img.shields.io/docker/image-size/sonroyaalmerol/steamcmd-arm64)](https://img.shields.io/docker/image-size/sonroyaalmerol/steamcmd-arm64) [![Discord](https://img.shields.io/discord/747067734029893653)](https://discord.gg/7ntmAwM)
# Supported tags and respective `Dockerfile` links
  -	[`latest`  (*bullseye/Dockerfile*)](https://github.com/sonroyaalmerol/steamcmd-arm64/blob/master/Dockerfile)

# What is SteamCMD?
The Steam Console Client or SteamCMD is a command-line version of the Steam client. Its primary use is to install and update various dedicated servers available on Steam using a command-line interface. It works with games that use the SteamPipe content system. All games have been migrated from the deprecated HLDSUpdateTool to SteamCMD. This image can be used as a base image for Steam-based dedicated servers (Source: [developer.valvesoftware.com](https://developer.valvesoftware.com/wiki/SteamCMD)).

# How to use this image
Whilst it's recommended to use this image as a base image of other game servers, you can also run it in an interactive shell using the following command:
```console
$ docker run -it --name=steamcmd sonroyaalmerol/steamcmd-arm64 bash
$ ./steamcmd.sh +force_install_dir /home/steam/squad-dedicated +login anonymous +app_update 403240 +quit
```
This can prove useful if you are just looking to test a certain game server installation.

Running with named volumes:
```console
$ docker volume create steamcmd_login_volume # Optional: Location of login session
$ docker volume create steamcmd_volume # Optional: Location of SteamCMD installation

$ docker run -it \
    -v "steamcmd_login_volume:/home/steam/Steam" \
    -v "steamcmd_volume:/home/steam/steamcmd" \
    sonroyaalmerol/steamcmd-arm64 bash
```
This setup is necessary if you have to download a non-anonymous appID or upload a steampipe build. For an example check out:
https://hub.docker.com/r/cm2network/steampipe/

## Configuration
This image includes the `nano` text editor for convenience. 

The `steamcmd.sh` can be found in the following directory: `/home/steam/steamcmd`

_Note: Running the `steamcmd.sh` as `root` will fail because the owner is the user `steam`, either swap the active user using `su steam` or use chown to change the ownership of the directory._