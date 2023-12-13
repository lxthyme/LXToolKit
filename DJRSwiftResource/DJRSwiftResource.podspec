#
# Be sure to run `pod lib lint DJRSwiftResource.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DJRSwiftResource'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DJRSwiftResource.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/DJRSwiftResource'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/DJRSwiftResource.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DJRSwiftResource/Classes/**/*.{h,m,swift}'

  # s.resource_bundles = {
  #   'DJRSwiftResource' => ['DJRSwiftResource/Assets/*.png']
  # }
  s.resources = [
    "#{s.module_name}/Assets/*.xcassets",
    "#{s.module_name}/Assets/**/*.png",
    "#{s.module_name}/Assets/*.strings",
    "#{s.module_name}/Assets/*.ttf",
  ]

  # s.public_header_files = 'Pod/Classes/**/*.h'

  script_Rswift = <<-CMD
  rswift_path="$PODS_ROOT/R.swift/rswift"
  generated_path="#{Dir.pwd}/#{s.module_name}/Classes"
  "${rswift_path}" generate --access-level public "${generated_path}/R.generated.swift" > "${generated_path}/rswift.log"
  CMD
  s.script_phase = {
    :name => "#{s.module_name}.R.swift",
    :execution_position => :before_compile,
    :script => script_Rswift,
    :output_files => [
      # '$SRCROOT/R.generated.swift',
      "#{Dir.pwd}/#{s.module_name}/Classes/R.generated.swift"
    ],
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'R.swift'
end
