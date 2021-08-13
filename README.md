# The Amnesiac's Best Friend (TABF)

The release channel of this project may be seen at [https://tabf.herokuapp.com](https://tabf.herokuapp.com/).

This project uses [Effective Dart](https://dart.dev/guides/language/effective-dart) enforced by [![Pub Version](https://img.shields.io/pub/v/flutter_lints?label=flutter_lints)](https://pub.dev/packages/flutter_lints)

## Introduction

TABF is a fork of [xinthink/flutter-keep](https://github.com/xinthink/flutter-keep) with some key changes:
- It's been refactored for [Dart 2.12.0](https://dart.dev/guides/whats-new#march-3-2021-212-release) to support [null safety](https://dart.dev/null-safety)
- Several dependencies have been upgraded
  - Minor refactoring was required after this point for additional null safety changes
- An additional feature has been added (ability to empty the trash)
- The project has been adapted to use [Heroku](https://heroku.com/) instead of [Firebase Hosting](https://firebase.google.com/products/hosting) (what the original repo used)

## Features

1. Create/edit/view notes
2. Pin/archive/delete notes
3. Ability to empty trash
4. Sign-in via Google
5. Offline usage

## System Architecture (10 pts)
Draw architecture diagrams of all services of your app and their relationships.

## Deployment (20 pts)
List the steps on how to deploy your app on the cloud.

## Demo video (30 pts)

Upload your demo video to youtube and put a link here. Basically, the video content is very much like the quick live demo of your app with the followings:
1. Introduction
3. Quick walkthrough of all the features of your app one by one

Make it short and interesting (1-3 minutes)

Sample: https://www.youtube.com/watch?v=Pr-JMqTkdEM

How to record your screen: https://www.techradar.com/how-to/record-your-screen

## References

- [The original repo](https://github.com/xinthink/flutter-keep) for the base project
- StackOverflow [for occasional syntax support](lib/service/notes_service.dart#L132) (not for code blocks)

## Team members

- Ryan Cloherty ([clohertyr@wit.edu](mailto:clohertyr@wit.edu)), the whole shebang
