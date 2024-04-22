#
# Be sure to run `pod lib lint BaiLianMobileAppEx.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BaiLianMobileAppEx'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BaiLianMobileAppEx.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lxthyme/BaiLianMobileAppEx'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lxthyme' => 'lx314333@gmail.com' }
  s.source           = { :git => 'https://github.com/lxthyme/BaiLianMobileAppEx.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.prefix_header_contents = '#import "IBLImportMacro.h"',
  '#import <Masonry/Masonry.h>',
  # '#import <BLSafeFetchDataFunctions/BLSafeFetchDataFunctions.h>',
  '#import <BLCategories/UIColor+Hex.h>',
  '#import <BLImage/iBLImage.h>',
  # '#import <DJBusinessTools/DJBusinessTools.h>',
  '#import <ReactiveCocoa/ReactiveCocoa.h>',
  '#import <tingyunApp/NBSAppAgent.h>',
  '#import "BaiLianMobileApp-Prefix.pch"'

  s.source_files = [
    'BaiLian/BaiLianMobileApp/Classes/**/*',
    'BaiLian/BaiLianMobileApp/Kernel/**/*',
    'BaiLian/BaiLianMobileApp/Plugins/**/*',
    'BaiLian/BaiLianMobileApp/IBLImportMacro.h',
    'BaiLian/BaiLianMobileApp/BaiLianMobileApp-Prefix.pch'
    # 'BaiLian/BaiLianMobileApp/'
  ]
  s.exclude_files = [
    'BaiLian/BaiLianMobileApp/**/Target_BLExplosionCategory.{h,m}',
    'BaiLian/BaiLianMobileApp/Classes/Common/GlobalShare/IBLShareManager.{h,m}',
    'BaiLian/BaiLianMobileApp/**/IBLCommodityCouponCell.{h,m}',
    'BaiLian/BaiLianMobileApp/**/IBLGlobalBuyCateViewController.{h,m}',
    'BaiLian/BaiLianMobileApp/**/TagListView.{h,m}',
    'BaiLian/BaiLianMobileApp/**/IBLAddressSelectCell.{h,m}',
    'BaiLian/BaiLianMobileApp/**/IBLNewAddressCell.{h,m}',
    'BaiLian/BaiLianMobileApp/**/OrderConfirmNomalCell.{h,m}',
    'BaiLian/BaiLianMobileApp/**/NSData+Crypto.m',
    'BaiLian/BaiLianMobileApp/**/NSDateUtilities.{h,m}',
    'BaiLian/BaiLianMobileApp/**/CollectionViewHeaderView.xib',
  ]

  # s.resource_bundles = {
  #   'BaiLianMobileAppEx' => ['BaiLianMobileAppEx/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'BLUITools'
  s.dependency 'CTAppContext_BaiLian'
  s.dependency 'BLCartViewControllerContainer'
  s.dependency 'BLActionSheetView'
  s.dependency 'BLGuideModule'
  s.dependency 'BL3DTouchModule'
  s.dependency 'BLOrderConfirmCountDownView'
  s.dependency 'BLSayToHimTableViewCell'
  s.dependency 'BLGoodsDetail'
  s.dependency 'BLOrderDatePickerView'
  s.dependency 'BLNoticeView'
  s.dependency 'BLWebSocketModule'
  s.dependency 'tingyunApp', '2.17.1'
  s.dependency 'TZImagePickerController'
  s.dependency 'TMCache', '2.1.0'
  s.dependency 'JSONModel', '1.1.2'
  s.dependency 'JPush', '5.3.0'
  s.dependency 'JCore', '4.6.2'
  s.dependency 'PromiseKit', '1.7.7'
  s.dependency 'ReactiveCocoa'
  s.dependency 'AMap3DMap-NO-IDFA'
  s.dependency 'AMapSearch-NO-IDFA'
  s.dependency 'AMapLocation-NO-IDFA'
  s.dependency 'BLWeChatSDK'
  s.dependency 'CocoaLumberjack'
  s.dependency 'MJRefresh'
  s.dependency 'BLShuMeiRisk'
  s.dependency 'BLCashier'
end
