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
  # s.static_framework = true
  s.ios.deployment_target = '14.0'
  s.swift_versions = '5'
  s.cocoapods_version = '>= 1.4.0'

  s.resource_bundles = {
    'LXToolKit' => [
      'LXToolKit/Assets/*.png',
      'LXToolKit/**/*.json'
    ]
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  script_Rswift = <<-CMD
  rswift_path="$PODS_ROOT/R.swift/rswift"
  generated_path="#{Dir.pwd}/#{s.module_name}"
  "${rswift_path}" generate "${generated_path}/R.generated.swift" > "${generated_path}/rswift.log"
  CMD
  s.script_phase = {
    :name => "#{s.module_name}.R.swift",
    :execution_position => :before_compile,
    :script => script_Rswift,
    :output_files => [
      # '$SRCROOT/R.generated.swift',
      "#{Dir.pwd}/#{s.module_name}/R.generated.swift"
    ],
  }

  s.default_subspec = 'Core'
  s.subspec 'Core' do |sub|
    sub.source_files = "LXToolKit/**/*.{swift,h,m,json}"
    # sub.frameworks = 'UIKit', 'MapKit'

    # https://github.com/SnapKit/SnapKit
    sub.dependency 'SnapKit'
    # https://github.com/krzyzanowskim/CryptoSwift
    sub.dependency 'CryptoSwift'
    # https://github.com/SDWebImage/SDWebImage
    sub.dependency 'SDWebImage'
    # s.source_files  = "LXToolKit/**/*.swift"
    # sub.dependency 'Apollo'
    # sub.dependency 'KeychainAccess'
    # sub.dependency 'Mixpanel'
    # sub.dependency 'MessageKit'
    # sub.dependency 'IQKeyboardManagerSwift'

    # Logging
    # https://github.com/CocoaLumberjack/CocoaLumberjack
    sub.dependency 'CocoaLumberjack/Swift'
    # sub.dependency 'FLEX'
    sub.dependency 'SwifterSwift'
    # sub.dependency 'SwiftDate'
    sub.dependency 'Hero'
    # sub.dependency 'DropDown'
    sub.dependency 'Toast-Swift'
    sub.dependency 'DZNEmptyDataSet'
    sub.dependency 'R.swift'
    sub.dependency 'Localize-Swift'
    sub.dependency 'SVProgressHUD'

    # sub.dependency 'RAMAnimatedTabBarController'
    # sub.dependency 'WhatsNewKit'
    # sub.dependency ''
    # sub.dependency ''
    # sub.dependency ''
    # sub.dependency ''
    # sub.dependency ''
    # sub.dependency ''
  end
  s.subspec '3rd' do |sub|
    sub.dependency 'LXToolKit/RxSwift'
    sub.dependency 'LXToolKit/Contacts'
    sub.dependency 'LXToolKit/Firebase'
    sub.dependency 'LXToolKit/Moya_HandyJSON'
    sub.dependency 'LXToolKit/HMSegmentedControl'
    sub.dependency 'LXToolKit/Kingfisher'
    sub.dependency 'LXToolKit/KafkaRefresh'
    sub.dependency 'LXToolKit/ImageSlideshow'
    # sub.dependency 'LXToolKit/'
  end
  s.subspec 'RxSwift' do |sub|
    sub.source_files = "LXToolKit/3rd/RxSwift/*"


    # sub.dependency 'AFNetworking', '~> 2.3'
    # https://github.com/Alamofire/Alamofire
    sub.dependency "Alamofire"
    # https://github.com/ReactiveX/RxSwift
    sub.dependency 'RxSwift'#, '~> 5'
    sub.dependency 'RxCocoa'
    sub.dependency 'RxGesture'
    # sub.dependency 'RxViewController'
    sub.dependency 'RxOptional'
    sub.dependency 'NSObject+Rx'
    sub.dependency 'RxTheme'
    sub.dependency 'RxDataSources'
  end
  s.subspec 'Contacts' do |sub|
    sub.source_files = "LXToolKit/3rd/Contacts/*"

    sub.frameworks = 'Contacts'
  end
  s.subspec 'Firebase' do |sub|
    sub.source_files = "LXToolKit/3rd/Crashlytics/*"

    sub.dependency 'Firebase/Analytics'
    sub.dependency 'Firebase/Crashlytics'
  end
  s.subspec 'Moya_HandyJSON' do |sub|
    sub.source_files = "LXToolKit/3rd/Moya-HandyJSON/**/*"

    # https://github.com/Moya/Moya
    sub.dependency 'Moya'#, '~> 13'

    # https://github.com/alibaba/HandyJSON
    sub.dependency 'HandyJSON'
    sub.dependency 'ObjectMapper'
    # sub.dependency 'Moya-ObjectMapper/RxSwift'
  end
  s.subspec 'HMSegmentedControl' do |sub|
    sub.source_files = "LXToolKit/3rd/HMSegmentedControl/*"

    sub.dependency 'HMSegmentedControl'
  end
  s.subspec 'Kingfisher' do |sub|
    sub.source_files = "LXToolKit/3rd/Kingfisher/*"

    sub.dependency 'Kingfisher'
  end
  s.subspec 'KafkaRefresh' do |sub|
    sub.source_files = "LXToolKit/3rd/KafkaRefresh/*"

    sub.dependency 'KafkaRefresh'
  end
  s.subspec 'ImageSlideshow' do |sub|
    sub.source_files = "LXToolKit/3rd/ImageSlideshow/*"

    sub.dependency 'ImageSlideshow'
  end

end


#s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
