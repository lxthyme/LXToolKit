#
# Be sure to run `pod lib lint LXToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXToolKit'
  s.version          = '0.0.7'
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
  s.author           = { 'lxthyme' => '1094426094@qq.com' }
  s.source           = { :git => 'https://github.com/lxthyme/LXToolKit.git', :tag => "v#{s.version.to_s}" }
   s.social_media_url = 'https://twitter.com/lxthyme'
#  s.default_subspec = "Core"
  s.ios.deployment_target = '10.0'
  s.swift_versions = '5.1'
  s.cocoapods_version = '>= 1.4.0'

  s.source_files = "LXToolKit/LXToolKit/**/*.{swift,h,m}"

  # s.resource_bundles = {
  #   'LXToolKit' => ['LXToolKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
#   s.dependency 'Alamofire', '~> 5.0.0-rc.3'
    s.dependency "Alamofire", "~> 5.0"
    s.dependency 'Moya'#, '~> 13'
    s.dependency 'RxSwift'#, '~> 5'
    s.dependency 'HandyJSON', '~> 5'
    s.dependency 'SnapKit', '~> 5.0'
    s.dependency 'CryptoSwift'
#  s.dependency 'CryptoSwift', '~>1.2.0'
    s.source_files  = "LXToolKit/**/*.swift"

# s.subspec "Core" do |ss|
##    ss.source_files  = "LXToolKit/Core/**/*.swift", "LXToolKit/Core/Base/**/*.swift", "LXToolKit/Core/ExtensionKit/**/*.swift", "LXToolKit/Error/**/*.swift", "LXToolKit/Kit/**/*.swift"
#    ss.source_files  = "LXToolKit/**/*.swift"
#    ss.framework  = "Foundation"
# end

# s.subspec "RxSwift" do |ss|
#    ss.source_files  = "LXToolKit/RxSwift"
#    ss.dependency "LXToolKit/**/*.swift"
#    ss.framework  = "Foundation"
#    ss.dependency "RxSwift", "~> 5.0"
# end

# s.subspec "HandyJSON" do |ss|
#    ss.source_files  = "LXToolKit/HandyJSON"
#    ss.dependency "LXToolKit/**/*.swift"
#    ss.framework  = "Foundation"
#    ss.dependency "HandyJSON", "~> 5.0"
# end

# s.subspec "Network" do |ss|
#    ss.source_files  = "LXToolKit/Network"
#    ss.dependency "LXToolKit/**/*.swift"
#    ss.framework  = "Foundation"
#    ss.dependency "Alamofire", "~> 4.0"
#    ss.dependency "Moya", '~>13.0'
#    ss.dependency "RxSwift", '~>5.0'
#    ss.dependency "HandyJSON", '~>5.0'
# end

end


#s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
