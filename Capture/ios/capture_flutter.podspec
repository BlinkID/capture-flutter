#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint capture_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'capture_flutter'
  s.version          = '1.4.3'
  s.summary          = 'Flutter wrapper for the Capture SDK'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://microblink.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Milan Paradina' => 'milan.paradina@microblink.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.dependency 'MBCaptureCore', '~> 1.4.3'
  s.dependency 'MBCaptureUX', '~> 1.4.3'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'capture_flutter_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
