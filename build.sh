#!/bin/bash
#shellcheck disable=SC2016

# be transparent
set -x

ANDROID_DIR="android-dev-tools"
mkdir -p "$HOME/$ANDROID_DIR/" && mkdir -p "$HOME/$ANDROID_DIR/cmdline-tools/"

# install ANDROID SDK
wget -nv "https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip" -O commandlinetools.zip
unzip commandlinetools.zip -d "$HOME/$ANDROID_DIR/cmdline-tools" && mv "$HOME"/$ANDROID_DIR/cmdline-tools/{cmdline-,}tools && rm -f commandlinetools.zip

# JDK version (can be changed)
JDK_VERSION="11.0.14"

# install JDK
wget -nv "https://files02.tchspt.com/temp/jdk-${JDK_VERSION}_linux-x64_bin.tar.gz" -O jdk-11.tar.gz
mkdir -p "$HOME/$ANDROID_DIR/jdk" && tar -zxvf jdk-11.tar.gz -C "$HOME/$ANDROID_DIR/jdk/" && rm -rf jdk-11.tar.gz

# install ANDROID NDK
wget -nv "https://dl.google.com/android/repository/android-ndk-r23b-linux.zip" -O android-ndk.zip && unzip android-ndk.zip && rm -rf android-ndk.zip

# export necessary variables
{
	printf 'export ANDROID_SDK_ROOT=$HOME/%s\n' "$ANDROID_DIR"
	printf 'export ANDROID_NDK_HOME=$HOME/android-ndk\n'
 	printf 'export JAVA_HOME=$HOME/%s/jdk/jdk-%s\n' "$ANDROID_DIR" "${JDK_VERSION}" 
	printf 'export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$JAVA_HOME/bin\n'	
} >> "$HOME/.bashrc"
