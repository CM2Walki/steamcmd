[![](https://img.shields.io/codacy/grade/c9aa793af739452bb9a9fc45a4758328.svg)](https://hub.docker.com/r/cm2network/steamcmd/) [![Docker Build Status](https://img.shields.io/docker/cloud/build/cm2network/steamcmd.svg)](https://hub.docker.com/r/cm2network/steamcmd/) [![Docker Stars](https://img.shields.io/docker/stars/cm2network/steamcmd.svg)](https://hub.docker.com/r/cm2network/steamcmd/) [![Docker Pulls](https://img.shields.io/docker/pulls/cm2network/steamcmd.svg)](https://hub.docker.com/r/cm2network/steamcmd/) [![](https://images.microbadger.com/badges/image/cm2network/steamcmd.svg)](https://microbadger.com/images/cm2network/steamcmd)
# Supported tags and respective `Dockerfile` links
  -	[`steam`, `latest` (*buster/Dockerfile*)](https://github.com/CM2Walki/steamcmd/blob/master/buster/Dockerfile)
  -	[`root` (*buster-root/Dockerfile*)](https://github.com/CM2Walki/steamcmd/blob/master/buster-root/Dockerfile)

# What is SteamCMD?
The Steam Console Client or SteamCMD is a command-line version of the Steam client. Its primary use is to install and update various dedicated servers available on Steam using a command-line interface. It works with games that use the SteamPipe content system. All games have been migrated from the deprecated HLDSUpdateTool to SteamCMD. This image can be used as a base image for Steam-based dedicated servers (Source: [developer.valvesoftware.com](https://developer.valvesoftware.com/wiki/SteamCMD)).

# How to use this image
Whilst it's recommended to use this image as a base image of other game servers, you can also run it in an interactive shell using the following command:
```console
$ docker run -it --name=steamcmd cm2network/steamcmd bash
$ ./home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/squad-dedicated \
    +app_update 403240 +quit
```
This can prove useful if you are just looking to test a certain game server installation.
## Configuration:
The steamcmd.sh can be found at the following path: */home/steam/steamcmd*

## Examples:
Consult the following repositories for examples on how to base an image off of this one:<br/>
https://hub.docker.com/r/cm2network/squad/<br/>
https://hub.docker.com/r/cm2network/csgo/<br>
https://hub.docker.com/r/cm2network/mordhau/

# Image Variants:
The `steamcmd` images come in two flavors, each designed for a specific use case.

## `steamcmd:latest`
This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is designed to be used as the base to build other images off of. This image's default user is `steam`, any command executed in a higher layer `Dockerfile` will therefor be executed as that user.<br/>

## `steamcmd:root`
This is a specialized image. This image's default user is `root`. If you need to install additional packages for you game server and do not want to create excess layers, then this is the right choice.

_Note: Running the `steamcmd.sh` as `root` will fail because the owner is the user `steam`, either swap the active user using `su steam` or use chown to change the ownership of the directory._
