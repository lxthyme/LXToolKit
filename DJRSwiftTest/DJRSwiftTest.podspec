#
# Be sure to run `pod lib lint DJRSwiftTest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DJRSwiftTest'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DJRSwiftTest.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/DJRSwiftTest'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/DJRSwiftTest.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'DJRSwiftTest/Classes/**/**/*'

  s.resource_bundles = {
    'DJRSwiftTest' => ['DJRSwiftTest/Assets/*.png']
  }
  # s.resources = [ 'DJRSwiftTest/Assets/*.png' ]
  s.resources = [
    'DJRSwiftTest/Assets/*.png'
  ]

  # s.prepare_command = <<-CMD
  # # # rm -rf $SRCROOT/../../DJRSwiftTest/Classes/R.generated.swift
  # # # echo '-->DDD: ' $SRCROOT/../../DJRSwiftTest/Classes/R.generated.swift
  # # echo '-->PWD: ' $PWD
  # CMD

  script_Rswift = <<-CMD
  rswift_path="$PODS_ROOT/R.swift/rswift"
  generated_path="#{Dir.pwd}/#{s.module_name}/Classes"
  "${rswift_path}" generate "${generated_path}/R.generated.swift" > "${generated_path}/rswift.log"
  CMD
  # p=$(pwd)
  # echo "-->p: "$p
  # echo "-->rswift_path: "$rswift_path
  # echo "-->generated_path: "$generated_path
  # echo "-->Dir.pwd: " #{Dir.pwd}
  # echo "-->PODS_TARGET_SRCROOT: " ${PODS_TARGET_SRCROOT}
  # echo "-->PROJECT_DIR: " ${PROJECT_DIR}
  # echo "-->SOURCE_ROOT: " ${SOURCE_ROOT}
  # echo "-->SRCROOT: " ${SRCROOT}
  # echo "-->PROJECT_FILE_PATH: " ${PROJECT_FILE_PATH}
  s.script_phase = {
    :name => "#{s.module_name}.R.swift",
    :execution_position => :before_compile,
    :script => script_Rswift,
    # :script => '"$PODS_ROOT/R.swift/rswift" generate --access-level public "$SRCROOT/R.generated.swift"',
    # :script => '"$PODS_ROOT/R.swift/rswift" generate "$SRCROOT/R.generated.swift"',
    # :script => '"$PODS_ROOT/R.swift/rswift" generate "$SRCROOT/../../DJRSwiftTest/Classes/R.generated.swift"',
    :output_files => ['$SRCROOT/R.generated.swift'],
    # :based_on_dependency_analysis => 0
    # :always_out_of_date => 1
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'R.swift'
end
