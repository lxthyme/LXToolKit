#
# Be sure to run `pod lib lint LXToolKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXToolKit'
  s.version          = '0.8.1'
  s.summary          = 'Give some useful category and extensions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library contains some useful category and extension kits
                       DESC

  s.homepage         = 'https://github.com/lxthyme/LXToolKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => '1094426094@qq.com' }
  s.source           = { :git => 'https://github.com/lxthyme/LXToolKit.git', :tag => "v#{s.version.to_s}" }
  # s.social_media_url = 'https://twitter.com/lxthyme'
  # s.default_subspec = "Core"
  s.ios.deployment_target = '12.0'
  s.swift_versions = '5.1'
  s.cocoapods_version = '>= 1.4.0'

  s.source_files = "LXToolKit/**/*.{swift,h,m,json}"

  # s.resource_bundles = {
  #   'LXToolKit' => ['LXToolKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  # https://github.com/Alamofire/Alamofire
  s.dependency "Alamofire"
  # https://github.com/Moya/Moya
  s.dependency 'Moya'#, '~> 13'
  # https://github.com/ReactiveX/RxSwift
  s.dependency 'RxSwift'#, '~> 5'
  s.dependency 'RxCocoa'
  # https://github.com/alibaba/HandyJSON
  s.dependency 'HandyJSON'
  # https://github.com/SnapKit/SnapKit
  s.dependency 'SnapKit'
  # https://github.com/krzyzanowskim/CryptoSwift
  s.dependency 'CryptoSwift'
  # https://github.com/SDWebImage/SDWebImage
  s.dependency 'SDWebImage'
  # s.source_files  = "LXToolKit/**/*.swift"
  # s.dependency 'Apollo'
  # s.dependency 'KeychainAccess'
  # s.dependency 'Mixpanel'
  # s.dependency 'ObjectMapper'
  # s.dependency 'Moya-ObjectMapper/RxSwift'
  # s.dependency 'Firebase/Analytics'
  # s.dependency 'Firebase/Crashlytics'
  # s.dependency 'MessageKit'
  # s.dependency 'KafkaRefresh'
  # s.dependency 'Kingfisher'
  # s.dependency 'IQKeyboardManagerSwift'

  # Logging
  # https://github.com/CocoaLumberjack/CocoaLumberjack
  s.dependency 'CocoaLumberjack/Swift'
  # s.dependency 'FLEX'
  # s.dependency 'RxViewController'
  # s.dependency 'RxOptional'
  # s.dependency 'RxGesture'
  # s.dependency 'SwifterSwift'
  # s.dependency 'SwiftDate'
  s.dependency 'Hero'
  # s.dependency 'DropDown'
  # s.dependency 'Toast-Swift'
  # s.dependency 'NSObject+Rx'
  # s.dependency 'DZNEmptyDataSet'
  s.dependency 'R.swift'
  s.dependency 'Localize-Swift'
  s.dependency 'SVProgressHUD'
  # s.dependency 'RxTheme'
  # s.dependency 'RxDataSources'
  # s.dependency 'RAMAnimatedTabBarController'
  # s.dependency 'WhatsNewKit'
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''


  # s.subspec "Core" do |ss|
  ##    ss.source_files  = "LXToolKit/Core/**/*.swift", "LXToolKit/Core/Bwase/**/*.swift", "LXToolKit/Core/ExtensionKit/**/*.swift", "LXToolKit/Error/**/*.swift", "LXToolKit/Kit/**/*.swift"
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
