#
# Be sure to run `pod lib lint LXToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXToolKit'
  s.version          = '0.0.4'
  s.summary          = 'Give some useful category and extensions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library contains some useful category and extension kits
                       DESC

  s.homepage         = 'https://github.com/LX314/LXToolKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LX314' => '1094426094@qq.com' }
  s.source           = { :git => 'https://github.com/LX314/LXToolKit.git', :tag => "v#{s.version.to_s}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_versions = '4.2'

  s.source_files = "LXToolKit/LXToolKit/**/*.{swift,h,m}"

  # s.resource_bundles = {
  #   'LXToolKit' => ['LXToolKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Alamofire', '~>4.9.1'
  s.dependency 'Moya', '~>12.0.1'
  s.dependency 'RxSwift', '~>4.5'
  s.dependency 'HandyJSON', '~>4.2'
  s.dependency 'SnapKit', '~>4.2'
  s.dependency 'CryptoSwift', '~>0.15.0'

end
