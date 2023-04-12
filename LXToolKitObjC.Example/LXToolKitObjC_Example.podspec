#
# Be sure to run `pod lib lint LXToolKitObjC.Example.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LXToolKitObjC_Example'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LXToolKitObjC.Example.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/LXToolKitObjC.Example'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/LXToolKitObjC.Example.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.prefix_header_file = 'LXToolKitObjC.Example/Classes/LXToolKitObjC.Example.h'

  s.source_files = 'LXToolKitObjC.Example/Classes/**/*'

  # s.resource_bundles = {
  #   'LXToolKitObjC.Example' => ['LXToolKitObjC.Example/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  script_Rswift = <<-CMD
  rswift_path="$PODS_ROOT/R.swift/rswift"
  generated_path="#{Dir.pwd}/LXToolKitObjC.Example/Classes"
  "${rswift_path}" generate "${generated_path}/R.generated.swift" > "${generated_path}/rswift.log"
  CMD
  s.script_phase = {
    :name => "#{s.module_name}.R.swift",
    :execution_position => :before_compile,
    :script => script_Rswift,
    :output_files => [
      # '$SRCROOT/R.generated.swift',
      "#{Dir.pwd}/LXToolKitObjC.Example/Classes/R.generated.swift"
    ],
  }

  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Masonry'
  s.dependency 'ReactiveCocoa'
  s.dependency 'LXToolKitObjC'
  s.dependency 'SDWebImage'
  s.dependency 'MBProgressHUD'
  s.dependency 'MJRefresh'
  s.dependency 'YYModel'
  s.dependency 'YYText'
  s.dependency 'JXCategoryView'
  s.dependency 'JXPagingView'
  s.dependency 'pop'
  s.dependency 'SDCycleScrollView'
  s.dependency 'CocoaLumberjack'
  # s.dependency ''
  # s.dependency ''
end
