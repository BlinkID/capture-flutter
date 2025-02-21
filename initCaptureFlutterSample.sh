#!/bin/bash

appName=sample

# remove any existing code
rm -rf $appName

# create a Flutter sample application to test out the Capture SDK
flutter create -a kotlin -i swift --org com.microblink $appName

# enter into demo project folder
pushd $appName

IS_LOCAL_BUILD=true || exit 1
if [ "$IS_LOCAL_BUILD" = true ]; then
  # add capture_flutter dependency with local path to pubspec.yaml
  perl -i~ -pe "BEGIN{$/ = undef;} s/dependencies:\n  flutter:\n    sdk: flutter/dependencies:\n  flutter:\n    sdk: flutter\n  capture_flutter:\n    path: ..\/Capture/" pubspec.yaml
  echo "Using capture_flutter from this repo instead from flutter pub"
else
  # add capture_flutter dependency to pubspec.yaml
  perl -i~ -pe "BEGIN{$/ = undef;} s/dependencies:\n  flutter:\n    sdk: flutter/dependencies:\n  flutter:\n    sdk: flutter\n  capture_flutter/" pubspec.yaml
  echo "Using capture_flutter from flutter pub"
fi

flutter pub get

# enter into android project folder
pushd android

popd

# enter into ios project folder
pushd ios

#Force minimal iOS version
sed -i '' "s/# platform :ios, '12.0'/platform :ios, '13.0'/" Podfile

# install pod
pod install

# go to flutter root project
popd

cp ../sample_files/main.dart lib/

echo ""
echo "Go to Flutter project folder: cd $appName"
echo "To run on Android type: flutter run"
echo "To run on iOS:
1. Open $appName/ios/Runner.xcworkspace
2. Set your development team
3. Press run"
