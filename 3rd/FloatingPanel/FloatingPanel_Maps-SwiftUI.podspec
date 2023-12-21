#
# Be sure to run `pod lib lint FloatingPanel_Maps-SwiftUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FloatingPanel_Maps-SwiftUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of FloatingPanel_Maps-SwiftUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/FloatingPanel_Maps-SwiftUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/FloatingPanel_Maps-SwiftUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = [
    'MapsSwiftUIEntry.swift',
    'Examples/Maps-SwiftUI/Maps/FloatingPanel/*.swift',
    'Examples/Maps-SwiftUI/Maps/Representable/*.swift',
    'Examples/Maps-SwiftUI/Maps/ContentView.swift',
    'Examples/Maps-SwiftUI/Maps/FloatingPanelContentView.swift',
    'Examples/Maps-SwiftUI/Maps/HostingCell.swift',
    'Examples/Maps-SwiftUI/Maps/MapsApp.swift',
    'Examples/Maps-SwiftUI/Maps/ResultsList.swift',
    'Examples/Maps-SwiftUI/Maps/SearchPanelPhoneDelegate.swift',
    'Examples/Maps-SwiftUI/Maps/SurfaceAppearance+phone.swift',
  ]

  # s.resource_bundles = {
  #   'FloatingPanel_Maps-SwiftUI' => []
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'FloatingPanel'
end
