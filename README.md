[![](https://img.shields.io/codacy/grade/6a8e207cf98246169e633d6f22da9d9c)](https://hub.docker.com/r/sonroyaalmerol/steamcmd-arm64/) [![Docker Pulls](https://img.shields.io/docker/pulls/sonroyaalmerol/steamcmd-arm64.svg)](https://hub.docker.com/r/sonroyaalmerol/steamcmd-arm64/) [![](https://img.shields.io/docker/image-size/sonroyaalmerol/steamcmd-arm64)](https://img.shields.io/docker/image-size/sonroyaalmerol/steamcmd-arm64) [![Bookworm Images](https://github.com/sonroyaalmerol/steamcmd-arm64/actions/workflows/release.yml/badge.svg)](https://github.com/sonroyaalmerol/steamcmd-arm64/actions/workflows/release.yml) [![Bullseye Images](https://github.com/sonroyaalmerol/steamcmd-arm64/actions/workflows/release-bullseye.yml/badge.svg)](https://github.com/sonroyaalmerol/steamcmd-arm64/actions/workflows/release-bullseye.yml)

# Supported tags and respective `Dockerfile` links
  -	[`steam`, `steam-bookworm`, `latest` (*bookworm/Dockerfile*)](https://github.com/sonroyaalmerol/steamcmd-arm64/blob/master/bookworm/Dockerfile)
  -	[`root`, `root-bookworm` (*bookworm/Dockerfile*)](https://github.com/sonroyaalmerol/steamcmd-arm64/blob/master/bookworm/Dockerfile)
  -	[`steam-bullseye`, `bullseye` (*bullseye/Dockerfile*)](https://github.com/sonroyaalmerol/steamcmd-arm64/blob/master/bullseye/Dockerfile)
  -	[`root-bullseye` (*bullseye/Dockerfile*)](https://github.com/sonroyaalmerol/steamcmd-arm64/blob/master/bullseye/Dockerfile)

> [!IMPORTANT]
> New versions of the Docker image are built every 24 hours to keep up with Box86 and Box64 updates. The rest of the installed packages are version pinned to ensure stability.

# What is SteamCMD?
The Steam Console Client or SteamCMD is a command-line version of the Steam client. Its primary use is to install and update various dedicated servers available on Steam using a command-line interface. It works with games that use the SteamPipe content system. All games have been migrated from the deprecated HLDSUpdateTool to SteamCMD. This image can be used as a base image for Steam-based dedicated servers (Source: [developer.valvesoftware.com](https://developer.valvesoftware.com/wiki/SteamCMD)).

# What makes this compatible with ARM64?
This image has [Box64](https://github.com/ptitSeb/box64) and [Box86](https://github.com/ptitSeb/box86) integrated. By default, SteamCMD will be using Box86 when running via the steamcmd.sh shell script. Box86 is needed as SteamCMD itself a 32-bit binary application. For 64-bit server binaries, please use Box64 `/usr/local/bin/box64`. For tweaking, environment variables could be used for both [Box64](https://github.com/ptitSeb/box64/blob/main/docs/USAGE.md) and [Box86](https://github.com/ptitSeb/box86/blob/master/docs/USAGE.md).

You may also opt to use qemu-i386-static instead of Box86 for better compatibility (but slower performance) by using `/usr/bin/qemu-i386-static` as value for the `DEBUGGER` env variable.

# How to use this image
> [!IMPORTANT]
> Images are hosted in ghcr.io (ghcr.io/sonroyaalmerol/steamcmd-arm64) and Docker Hub (sonroyaalmerol/steamcmd-arm64).

Whilst it's recommended to use this image as a base image of other game servers, you can also run it in an interactive shell using the following command:
```console
$ docker run -it --name=steamcmd ghcr.io/sonroyaalmerol/steamcmd-arm64 bash
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
    ghcr.io/sonroyaalmerol/steamcmd-arm64 bash
```
This setup is necessary if you have to download a non-anonymous appID or upload a steampipe build. For an example check out:
https://hub.docker.com/r/cm2network/steampipe/

## Configuration
This image includes the `nano` text editor for convenience. 

The `steamcmd.sh` can be found in the following directory: `/home/steam/steamcmd`

## Examples
Images utilizing this base image:

| Image  | Pulls |
| ------------- | ------------- |
| [thijsvanloef/palworld-server-docker](https://hub.docker.com/r/thijsvanloef/palworld-server-docker) | [![Docker Pulls](https://img.shields.io/docker/pulls/thijsvanloef/palworld-server-docker.svg)](https://hub.docker.com/r/thijsvanloef/palworld-server-docker/) |

# Image Variants
The `steamcmd` images come in two flavors, each designed for a specific use case.

## `steamcmd-arm64:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is designed to be used as the base to build other images off of. This image's default user is `steam`, any command executed in a higher layer `Dockerfile` will therefor be executed as that user.<br/>

## `steamcmd-arm64:root`
This is a specialized image. This image's default user is `root`. If you need to install additional packages for you game server and do not want to create excess layers, then this is the right choice.

_Note: Running the `steamcmd.sh` as `root` will fail because the owner is the user `steam`, either swap the active user using `su steam` or use chown to change the ownership of the directory._
