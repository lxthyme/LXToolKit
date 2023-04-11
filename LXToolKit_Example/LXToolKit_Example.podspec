#
# Be sure to run `pod lib lint LXToolKit_Example.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXToolKit_Example'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LXToolKit_Example.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/LXToolKit_Example'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/LXToolKit_Example.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'LXToolKit_Example/Classes/**/*'

  # s.resource_bundles = {
  #   'LXToolKit_Example' => ['LXToolKit_Example/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'LXToolKit'
  s.dependency 'R.swift'
  s.dependency 'SnapKit'
  s.dependency 'Hero'
  s.dependency 'Localize-Swift'
  s.dependency 'SVProgressHUD'
  s.dependency 'Mantle'
  s.dependency 'HandyJSON'
  s.dependency 'RxCocoa'
  s.dependency 'RxSwift'
  s.dependency 'MJExtension'
  s.dependency 'YYText'
  s.dependency 'Masonry'
  s.dependency 'RxSwiftExt'
  s.dependency 'SwifterSwift'
  s.dependency 'Action'
  s.dependency 'YPImagePicker'
  s.dependency 'Toast-Swift'
  s.dependency 'KafkaRefresh'
  s.dependency 'Kingfisher'
  s.dependency 'MJRefresh'
  s.dependency 'NSObject+Rx'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'ObjectMapper'
  s.dependency 'Moya-ObjectMapper/RxSwift'
  s.dependency 'Moya/RxSwift'
  s.dependency 'RxTheme'
  s.dependency 'HMSegmentedControl'
  s.dependency 'ImageSlideshow/Kingfisher'
  s.dependency "ImageSlideshow/SDWebImage"
  s.dependency 'Mixpanel-swift'
  s.dependency 'Firebase/Analytics'
  s.dependency 'Firebase/Crashlytics'
  s.dependency 'Apollo', '0.50.0'
  s.dependency 'KeychainAccess'
  s.dependency 'MessageKit'
  # s.dependency 'Google-Mobile-Ads-SDK'
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'CocoaLumberjack'
  s.dependency 'FLEX'
  s.dependency 'RxViewController'
  s.dependency 'RxGesture'
  s.dependency 'RxOptional'
  s.dependency 'RxDataSources'
  s.dependency 'SwifterSwift'
  s.dependency 'SwiftDate'
  s.dependency 'DateToolsSwift'
  s.dependency 'DropDown'
  s.dependency 'WhatsNewKit'
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
  # s.dependency ''
end
