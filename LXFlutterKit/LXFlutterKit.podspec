#
# Be sure to run `pod lib lint LXFlutterKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXFlutterKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LXFlutterKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/LXFlutterKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/LXFlutterKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.static_framework = true

  # s.resource_bundles = {
  #   'LXFlutterKit' => ['LXFlutterKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.default_subspec = 'Core'
  s.subspec 'Core' do |sub|
    sub.source_files = 'LXFlutterKit/Classes/**/*'

    s.dependency 'LXToolKit'
  end
  s.subspec 'Source' do |sub|
    sub.dependency 'LXFlutterKit/Core'
    sub.dependency 'Flutter'
    sub.dependency 'FlutterPluginRegistrant'
  end
  s.subspec 'Debug' do |sub|
    sub.dependency 'LXFlutterKit/Core'
    sub.dependency 'Flutter'
    sub.dependency 'FlutterSDK/Debug'
  end
  s.subspec 'Profile' do |sub|
    sub.dependency 'LXFlutterKit/Core'
    sub.dependency 'Flutter'
    sub.dependency 'FlutterSDK/Profile'
  end
  s.subspec 'Release' do |sub|
    sub.dependency 'LXFlutterKit/Core'
    sub.dependency 'Flutter'
    # sub.dependency 'FlutterSDK/Release'
    # sub.dependency 'GSYSDK/Release'
  end
end
