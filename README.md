# The Amnesiac's Best Friend (TABF)

The release channel of this project may be seen at [https://tabf.herokuapp.com](https://tabf.herokuapp.com/). For the staging build, see [https://tabf-main-staging.herokuapp.com](https://tabf-main-staging.herokuapp.com/).

There is also an Android release. You can grab the APK file from the assets of the [latest release](https://github.com/IncPlusPlus/tabf/releases/latest) or get the app [via Google Play](https://play.google.com/store/apps/details?id=io.github.incplusplus.tabf).

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

## System Architecture
![architecture](https://user-images.githubusercontent.com/6992149/129398251-1bb0c4be-bf9b-47de-9bce-9a124be6b0ac.png)

## Deployment
Deploying _changes_ to this app is as simple as changing some code, pulling it into `main` and then making a release. However, the initial setup for a deployment is more complex. Here's a condensed guide on how one could host this project for themselves (setup of your dev environment won't be covered):
1. Fork this repo
2. Configure a Heroku app or pipeline depending on your preference 
   - This repo has a branch called `heroku-deploy` which the [release workflow](.github/workflows/upload-assets-when-release-published.yml) merges the `main` branch into when a new release is created and tagged. You can choose to do something similar with a pipeline
   - Use the [ee/heroku-buildpack-flutter-light](https://github.com/ee/heroku-buildpack-flutter-light) buildpack for your app (or all apps in your pipeline) by opening your app
     - Follow the [instructions for how to use it](https://github.com/ee/heroku-buildpack-flutter-light#user-content-with-heroku-buildpack-static-recommended) in the README.md
   - If you choose to enable [Review Apps](https://devcenter.heroku.com/articles/github-integration-review-apps), you'll need to add an `app.json` file like [mine](./app.json) because there is no fine-grained configuration of review apps before they actually exist in the pipeline.
3. Create a new Firebase project + create & configure the web and Android apps
   1. Open your [Firebase console](https://console.firebase.google.com/)
   2. Create a new Firebase project. This will be used for your forked project including all the platform variants
   3. Create the web app
       1. In the project settings, under "Your apps", click the blue "Add app button" and click the web icon
       2. Give it whatever name you want
       3. Stop when presented with the HTML snippet
          1. Copy _**ONLY**_ the content inside the `firebaseConfig` variable
          2. Replace the content of the `firebaseConfig` variable inside of [the Flutter web app HTML](./web/index.html) with the content you copied
   4. Create the Android app (you'll be following a similar set of instructions as [the Android setup guide](https://firebase.google.com/docs/android/setup?authuser=0#console) but extremely trimmed down because this is an existing Firebase app)
      1. In the project settings, under "Your apps", click the blue "Add app button" and click the Android icon
      2. Use the package name you use for your other projects
      3. Give the app whatever name you want
      4. Leave the debug signing certificate SHA-1 blank for now unless you already have it on hand
      5. Download the `google-services.json` file you're presented with and use it to replace the existing one at [android/app/google-services.json](android/app/google-services.json)
      6. Configure app signing and add the SHA-1 hash of your debug signing certificate to the app in your Firebase console
         1. This won't be covered here. The Gradle build file is already configured to enable signing. However, it expects the presence of [./android/key.properties](./android/key.properties). See [IncPlusPlus/chemistry-catalyst#2](https://github.com/IncPlusPlus/chemistry-catalyst/pull/2) for how to configure your GH actions environment to create this file for you.
4. Configure Firebase Authentication
   1. In your Firebase console, go to Authentication and then go to the "Sign-in method" section
   2. Click on Google and enable it. Save your changes
   3. Do the same for email/password
5. Configure Firestore Database (A.K.A. Cloud Firestore)
   1. In your Firebase console, go to Firestore Database
   2. Click on "Rules"
   3. Use the following snippet for your rules
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{collection}/{documents=**} {
      allow read, create, update, delete: if 'notes-' + request.auth.uid == collection;
    }
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```
6. You should be up and running. I may have forgotten a thing or two but that's most of the hard part over with

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
