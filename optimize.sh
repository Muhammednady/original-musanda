#!/usr/bin/env bash

flutter clean
rm -rf ios/Flutter
rm -rf android/.gradle
./android/gradlew clean