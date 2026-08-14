#!/bin/sh

# get version numbers
versionSrc="src/base/version.h.in"
versionMajor="$(grep -Po '(?<=ROT_VERSION_MAJOR )\d+' "$versionSrc")"
versionMinor="$(grep -Po '(?<=ROT_VERSION_MINOR )\d+' "$versionSrc")"
versionBugfix="$(grep -Po '(?<=ROT_VERSION_BUGFIX )\d+' "$versionSrc")"
versionBuild="$(grep -Po '(?<=ROT_VERSION_BUILD )\d+' "$versionSrc")"
versionStatus="$(grep -Po '(?<=ROT_VERSION_STATUS ")\w+' "$versionSrc")"

if [ "$versionBuild" != "0" ]; then
    projectVersion="$versionMajor.$versionMinor.$versionBugfix.$versionBuild$versionStatus"
else
    projectVersion="$versionMajor.$versionMinor.$versionBugfix$versionStatus"
fi

# pack archives
git archive --format=tar --prefix="rotorrent-$projectVersion/" HEAD | gzip -9 > "rotorrent-$projectVersion.tar.gz"
git archive --format=tar --prefix="rotorrent-$projectVersion/" HEAD | xz -9 > "rotorrent-$projectVersion.tar.xz"
