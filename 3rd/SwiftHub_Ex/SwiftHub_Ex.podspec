#
# Be sure to run `pod lib lint SwiftHub_Ex.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftHub_Ex'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SwiftHub_Ex.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/SwiftHub_Ex'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/SwiftHub_Ex.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = [
    'SwiftHub_Ex/**/*'
  ]

  # s.resource_bundles = {
  #   'SwiftHub_Ex' => [
  #     'SwiftHub_Ex/Color.xcassets',
  #   ]
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # Pods for SwiftHub

  # Networking
  s.dependency 'Moya/RxSwift', '~> 15.0'  # https://github.com/Moya/Moya
  s.dependency 'Apollo', '0.53.0'  # https://github.com/apollographql/apollo-ios

  # Rx Extensions
  s.dependency 'RxDataSources', '~> 5.0'  # https://github.com/RxSwiftCommunity/RxDataSources
  s.dependency 'RxSwiftExt', '~> 6.0'  # https://github.com/RxSwiftCommunity/RxSwiftExt
  s.dependency 'NSObject+Rx', '~> 5.0'  # https://github.com/RxSwiftCommunity/NSObject-Rx
  s.dependency 'RxViewController', '~> 2.0'  # https://github.com/devxoul/RxViewController
  s.dependency 'RxGesture', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxGesture
  s.dependency 'RxOptional', '~> 5.0'  # https://github.com/RxSwiftCommunity/RxOptional
  s.dependency 'RxTheme', '~> 6.0'  # https://github.com/RxSwiftCommunity/RxTheme

  # JSON Mapping
  s.dependency 'Moya-ObjectMapper/RxSwift'#, :git => 'https://github.com/p-rob/Moya-ObjectMapper.git', :branch => 'master'  # https://github.com/ivanbruel/Moya-ObjectMapper

  # Image
  s.dependency 'Kingfisher', '~> 7.0'  # https://github.com/onevcat/Kingfisher

  # Date
  s.dependency 'DateToolsSwift', '~> 5.0'  # https://github.com/MatthewYork/DateTools
  s.dependency 'SwiftDate', '~> 7.0'  # https://github.com/malcommac/SwiftDate

  # Tools
  s.dependency 'R.swift', '~> 7.0'  # https://github.com/mac-cain13/R.swift
  s.dependency 'SwiftLint', '0.51.0'  # https://github.com/realm/SwiftLint

  # Keychain
  s.dependency 'KeychainAccess', '~> 4.0'  # https://github.com/kishikawakatsumi/KeychainAccess

  # UI
  s.dependency 'SVProgressHUD', '~> 2.0'  # https://github.com/SVProgressHUD/SVProgressHUD
  s.dependency 'ImageSlideshow/Kingfisher'#, :git => 'https://github.com/khoren93/ImageSlideshow.git', :branch => 'master'   # https://github.com/zvonicek/ImageSlideshow
  s.dependency 'DZNEmptyDataSet', '~> 1.0'  # https://github.com/dzenbot/DZNEmptyDataSet
  s.dependency 'Hero', '~> 1.6'  # https://github.com/lkzhao/Hero
  s.dependency 'Localize-Swift', '~> 3.0'  # https://github.com/marmelroy/Localize-Swift
  s.dependency 'RAMAnimatedTabBarController', '~> 5.0'  # https://github.com/Ramotion/animated-tab-bar
  s.dependency 'AcknowList', '~> 3.0'  # https://github.com/vtourraine/AcknowList
  s.dependency 'KafkaRefresh', '~> 1.0'  # https://github.com/OpenFeyn/KafkaRefresh
  s.dependency 'WhatsNewKit', '~> 1.0'  # https://github.com/SvenTiigi/WhatsNewKit
  s.dependency 'Highlightr', '~> 2.0'  # https://github.com/raspu/Highlightr
  s.dependency 'DropDown', '~> 2.0'  # https://github.com/AssistoLab/DropDown
  s.dependency 'Toast-Swift', '~> 5.0'  # https://github.com/scalessec/Toast-Swift
  s.dependency 'HMSegmentedControl', '~> 1.0'  # https://github.com/HeshamMegid/HMSegmentedControl
  s.dependency 'FloatingPanel', '~> 2.0'  # https://github.com/SCENEE/FloatingPanel
  s.dependency 'MessageKit', '~> 3.0'  # https://github.com/MessageKit/MessageKit
  s.dependency 'MultiProgressView', '~> 1.0'  # https://github.com/mac-gallagher/MultiProgressView
  s.dependency 'Charts', '~> 4.0'  # https://github.com/danielgindi/Charts

  # Keyboard
  s.dependency 'IQKeyboardManagerSwift', '~> 6.0'  # https://github.com/hackiftekhar/IQKeyboardManager

  # Auto Layout
  s.dependency 'SnapKit', '~> 5.0'  # https://github.com/SnapKit/SnapKit

  # Code Quality
  s.dependency 'FLEX', '~> 5.0', :configurations => ['Debug']  # https://github.com/Flipboard/FLEX
  s.dependency 'SwifterSwift'#, '~> 5.0'  # https://github.com/SwifterSwift/SwifterSwift
  s.dependency 'BonMot', '~> 6.0'  # https://github.com/Rightpoint/BonMot

  # Logging
  s.dependency 'CocoaLumberjack/Swift', '~> 3.0'  # https://github.com/CocoaLumberjack/CocoaLumberjack

  # Analytics
  s.dependency 'Mixpanel-swift', '~> 4.0'  # https://github.com/mixpanel/mixpanel-iphone

  # Firebase https://github.com/firebase/firebase-ios-sdk
  s.dependency 'FirebaseAnalytics', '~> 10.0'
  s.dependency 'FirebaseCrashlytics', '~> 10.0'

  # Ads
  s.dependency 'Google-Mobile-Ads-SDK', '~> 10.0'
end
