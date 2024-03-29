#
#  Be sure to run `pod spec lint BLAPIManagers.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "BLOrder"
  s.version      = "633"
  s.summary      = "BLOrder."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                    this is BLOrder
                   DESC

  s.homepage     = "https://gitlab.bl.com/iOS_Business/BLOrder"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  # s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "CasaTaloyum" => "casatwy@msn.com" }
  # Or just: s.author    = "CasaTaloyum"
  # s.authors            = { "CasaTaloyum" => "casatwy@msn.com" }
  # s.social_media_url   = "http://twitter.com/CasaTaloyum"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  s.platform     = :ios, "11.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://gitlab.bl.com/iOS_Business/BLOrder.git", :tag => s.version.to_s }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "BLOrder/BLOrder/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

#   s.pod_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => '' }
   #  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64 armv7 armv7s ' }
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.
  s.requires_arc = true
  
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 arm64' }

  s.dependency 'BLCategories'
  s.dependency 'HandyFrame'
  s.dependency 'MJRefresh'
  s.dependency 'BLiOSAppImages'
  s.dependency 'CTAppContext'
  s.dependency 'BLAPIManagers'
  s.dependency 'SensorsAnalyticsSDK'
  s.dependency "BLNetworkingCategory"
  s.dependency "IBLNavigationBar"
  s.dependency 'BLImage'
  s.dependency 'BLCountDownTool'
  s.dependency 'IBLToastView'
  s.dependency 'IBLProgressHud'
  s.dependency 'BLCancelOrderView'
  s.dependency 'IBLOrderConfirmAlertView'
  s.dependency 'BLAutoScrollBannerHeaderView'
  s.dependency 'BLOrderConfirmRuleAlertView'
  s.dependency 'BLMapModule'

  s.dependency 'BLBusinessCategoryCloudStore'
  s.dependency 'BLBusinessCategoryRouterCenter'
  s.dependency 'DJBusinessCategoryRouterCenter'
  s.dependency 'BLSearchBarContext'
  s.dependency 'BLPopDownMenu'
  s.dependency 'Toast'
  s.dependency 'BLRawAPIManager'
  s.dependency 'YYModel'
  s.dependency 'HWPanModal'
  # Private s.dependencys
  s.dependency 'BLViewDownloadsInvoice'
  s.dependency 'BLWebViewControllers'
  s.dependency 'IGListKit'
  s.dependency 'DJBusinessTools'
end        

