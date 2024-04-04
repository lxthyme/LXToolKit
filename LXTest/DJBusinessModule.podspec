#
# Be sure to run `pod lib lint DJBusinessModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DJBusinessModule'
  s.version          = '361'
  s.summary          = 'DJBusinessModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://gitlab.bl.com/iOS_Business/DJBusinessModule.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bl_osd' => 'yingfeng.du@bl.com' }
  s.source           = { :git => 'https://gitlab.bl.com/iOS_Business/DJBusinessModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.prefix_header_contents = '#import <Masonry/Masonry.h>',
  '#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>',
  '#import <BLCategories/UIColor+Hex.h>',
  '#import <BLImage/iBLImage.h>',
  '#import <DJBusinessTools/DJBusinessTools.h>',
  '#import <ReactiveCocoa/ReactiveCocoa.h>'

  s.ios.deployment_target = '11.0'
  s.source_files = 'DJBusinessModule/Classes/**/*.{h,m}'
  s.resources = 'DJBusinessModule/Classes/DJNewModuleHome/Resources/*.gif'

  # s.resource_bundles = {
  #   'DJBusinessModule' => ['DJBusinessModule/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'





    s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

    s.dependency 'SDCycleScrollView'
    s.dependency 'IQKeyboardManager'
    s.dependency 'pop'
    s.dependency 'BLCountDownTool'
    s.dependency 'BLRangeSlider'
    s.dependency 'IBLProgressHud'
    s.dependency 'MWPhotoBrowser'
    s.dependency 'AMapLocation-NO-IDFA'
    s.dependency 'VerticalAlignmentLabel'
    s.dependency 'ReactiveCocoa', '~> 2.5'
    s.dependency "MJRefresh", '3.1.12'
    s.dependency "Masonry"
    s.dependency "BLSafeFetchDataFunctions"
    s.dependency "IBLToastView"
    s.dependency 'SDWebImage'
    s.dependency "HandyFrame"
    s.dependency "CTAppContext_BaiLian"
    s.dependency "IBLAddressSelectPickerView"
    s.dependency "IBLOrderConfirmAlertView"
    s.dependency "AmapAPIManager"
    s.dependency "AMap3DMap-NO-IDFA"
    s.dependency "AMapSearch-NO-IDFA"
    s.dependency 'CTAppContext'
    s.dependency "YYModel"
    s.dependency 'HTHorizontalSelectionList'
    s.dependency 'SensorsAnalyticsSDK'
    s.dependency "CTPersistance"
    s.dependency 'IBLPopDownMenu'
    s.dependency 'iCarousel'
    s.dependency 'AFNetworking'
    s.dependency 'IBLNavigationBar'
    s.dependency 'JhtMarquee'
    s.dependency 'JXCategoryView'
    s.dependency 'MBProgressHUD'
    s.dependency 'DACircularProgress'
    s.dependency 'CTVideoPlayerView'
    s.dependency 'CRRouter'
    s.dependency 'BLPopDownMenu'

    # BL
    s.dependency 'BLiOSAppImages'
    s.dependency 'BLDaoJiaAlertView'
    s.dependency 'BLCancelOrderView'
    s.dependency 'BLTwoBallRotationView'
    s.dependency 'BLCartService'
    s.dependency 'BLAddressCRUD'
    s.dependency 'BLOrderConfirmRuleAlertView'
    s.dependency 'BLPaySuccessful'
    s.dependency 'BLOrderConfirmTableViewHeaderFooterViews'
    s.dependency 'BLOrderConfirmTableViewCells'
    s.dependency 'BLPanicBuyEveryDay'
    s.dependency 'BLPayCode'
    s.dependency 'BLNetworkingCategory'
    s.dependency 'BLBusinessCategoryRouterCenter'
    s.dependency 'DJBusinessCategoryRouterCenter'
    s.dependency 'BLOrderConfirmBottomView'
    s.dependency 'BLOrder'
    s.dependency 'BLMapModule'
    s.dependency 'BLShare'
    s.dependency 'BLRawAPIManager'
    s.dependency 'BLHomeDataSource'
    s.dependency 'BLAPIManagers'
    s.dependency "BLCategories"
    s.dependency "BLImage"
    s.dependency "BLMediator"
    s.dependency "BLLoginRegister"
    s.dependency "BLSelectAddressViewController"
    s.dependency 'BLRefresh'
    s.dependency 'BLPagerView'
    s.dependency 'BLHomePageViewComponents'
    s.dependency 'BLOrderConfirmNormalActionSheet'
    s.dependency 'BLOrderConfirmCouponActionSheet'
    s.dependency 'BLSensorTrack'
    s.dependency "BLWebViewControllers"
    s.dependency 'BLAdvertResourceJumpManager'
    s.dependency 'BLOrderUnavailableGoodsPopView'
    s.dependency 'BLProtocolManager'
    s.dependency 'BLBusinessCategoryAddress'
    s.dependency "BLCouponCenterModule"
    s.dependency "BLShuMeiRisk"




    # 到家组件
    s.dependency 'DJBusinessTools'
    s.dependency 'DJiOSAppImages'
    s.dependency 'DJGlobalStoreManager'






end
