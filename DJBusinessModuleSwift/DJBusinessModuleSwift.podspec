#
# Be sure to run `pod lib lint DJBusinessModuleSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DJBusinessModuleSwift'
  s.version          = '63'
  s.summary          = 'A short description of DJBusinessModuleSwift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/DJBusinessModuleSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'git@github.com:lxthyme/DJBusinessModuleSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.static_framework = true
  s.swift_version = '5.3'
  #, 'DJBusinessModuleSwift/Classes/RxNetworks/**/*.{h,m,swift}'
  # s.source_files = 'DJBusinessModuleSwift/Classes/**/*.{h,m,swift}'
  #s.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64 arm64e x86_64' }
  # s.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64' }
  s.source_files = 'DJBusinessModuleSwift/Classes/**/*'

  # s.resource_bundles = {
  #   'DJBusinessModuleSwift' => ['DJBusinessModuleSwift/Assets/*.png']
  # }
  # s.static_framework = true
  s.module_name      = 'DJBusinessModuleSwift'
# s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'RxNetworks'
  # s.dependency 'Toast-Swift'
  # s.dependency 'HandyJSON'
  # s.dependency 'Moya'
  # s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'YYCache'
  # s.dependency 'Alamofire'
  s.dependency 'SnapKit'
  s.dependency 'MBProgressHUD'

end
