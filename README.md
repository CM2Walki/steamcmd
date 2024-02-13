[![](https://img.shields.io/codacy/grade/6a8e207cf98246169e633d6f22da9d9c)](https://hub.docker.com/r/cm2network/steamcmd/) [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/steamcmd.svg)](https://hub.docker.com/r/cm2network/steamcmd/) [![Docker Stars](https://img.shields.io/docker/stars/cm2network/steamcmd.svg)](https://hub.docker.com/r/cm2network/steamcmd/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/steamcmd.svg)](https://hub.docker.com/r/cm2network/steamcmd/) [![](https://img.shields.io/docker/image-size/cm2network/steamcmd)](https://img.shields.io/docker/image-size/cm2network/steamcmd) [![Discord](https://img.shields.io/discord/747067734029893653)](https://discord.gg/7ntmAwM)
# Supported tags and respective `Dockerfile` links
  -	[`steam`, `steam-bookworm`, `latest` (*bookworm/Dockerfile*)](https://github.com/CM2Walki/steamcmd/blob/master/bookworm/Dockerfile)
  -	[`root`, `root-bookworm` (*bookworm/Dockerfile*)](https://github.com/CM2Walki/steamcmd/blob/master/bookworm/Dockerfile)
  -	[`steam-bullseye`, `bullseye` (*bullseye/Dockerfile*)](https://github.com/CM2Walki/steamcmd/blob/master/bullseye/Dockerfile)
  -	[`root-bullseye` (*bullseye/Dockerfile*)](https://github.com/CM2Walki/steamcmd/blob/master/bullseye/Dockerfile)

# What is SteamCMD?
The Steam Console Client or SteamCMD is a command-line version of the Steam client. Its primary use is to install and update various dedicated servers available on Steam using a command-line interface. It works with games that use the SteamPipe content system. All games have been migrated from the deprecated HLDSUpdateTool to SteamCMD. This image can be used as a base image for Steam-based dedicated servers (Source: [developer.valvesoftware.com](https://developer.valvesoftware.com/wiki/SteamCMD)).

# How to use this image
Whilst it's recommended to use this image as a base image of other game servers, you can also run it in an interactive shell using the following command:
```console
$ docker run -it --name=steamcmd cm2network/steamcmd bash
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
    cm2network/steamcmd bash
```
This setup is necessary if you have to download a non-anonymous appID or upload a steampipe build. For an example check out:
https://hub.docker.com/r/cm2network/steampipe/

## Configuration
This image includes the `nano` text editor for convenience. 

The `steamcmd.sh` can be found in the following directory: `/home/steam/steamcmd`

## Examples
Images utilizing this base image:

| Image  | Pulls | Build Status |
| ------------- | ------------- | ------------- |
| [cm2network/cs2](https://hub.docker.com/r/cm2network/cs2/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/cs2.svg)](https://hub.docker.com/r/cm2network/cs2/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/cs2)](https://hub.docker.com/r/cm2network/cs2/) |
| [cm2network/csgo](https://hub.docker.com/r/cm2network/csgo/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/csgo.svg)](https://hub.docker.com/r/cm2network/csgo/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/csgo)](https://hub.docker.com/r/cm2network/csgo/) |
| [cm2network/tf2](https://hub.docker.com/r/cm2network/tf2/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/tf2.svg)](https://hub.docker.com/r/cm2network/tf2/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/tf2.svg)](https://hub.docker.com/r/cm2network/tf2/) |
| [cm2network/squad](https://hub.docker.com/r/cm2network/squad/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/squad.svg)](https://hub.docker.com/r/cm2network/squad/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/squad.svg)](https://hub.docker.com/r/cm2network/squad/) |
| [cm2network/mordhau](https://hub.docker.com/r/cm2network/mordhau/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/mordhau.svg)](https://hub.docker.com/r/cm2network/mordhau/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/mordhau.svg)](https://hub.docker.com/r/cm2network/mordhau/) |
| [cm2network/holdfastnaw](https://hub.docker.com/r/cm2network/holdfastnaw/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/holdfastnaw.svg)](https://hub.docker.com/r/cm2network/holdfastnaw/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/holdfastnaw.svg)](https://hub.docker.com/r/cm2network/holdfastnaw/) |
| [cm2network/valheim](https://hub.docker.com/r/cm2network/valheim/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/valheim.svg)](https://hub.docker.com/r/cm2network/valheim/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/valheim.svg)](https://hub.docker.com/r/cm2network/valheim/) |
| [cm2network/steampipe](https://hub.docker.com/r/cm2network/steampipe/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/steampipe.svg)](https://hub.docker.com/r/cm2network/steampipe/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/steampipe.svg)](https://hub.docker.com/r/cm2network/steampipe/) |

# Image Variants
The `steamcmd` images come in two flavors, each designed for a specific use case.

## `steamcmd:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is designed to be used as the base to build other images off of. This image's default user is `steam`, any command executed in a higher layer `Dockerfile` will therefor be executed as that user.<br/>

## `steamcmd:root`
This is a specialized image. This image's default user is `root`. If you need to install additional packages for you game server and do not want to create excess layers, then this is the right choice.

_Note: Running the `steamcmd.sh` as `root` will fail because the owner is the user `steam`, either swap the active user using `su steam` or use chown to change the ownership of the directory._

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/CM2Walki/steamcmd?size=50&padding=5&bots=false)](https://github.com/CM2Walki/steamcmd/graphs/contributors)
