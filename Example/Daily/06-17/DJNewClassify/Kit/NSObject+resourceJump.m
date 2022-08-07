//
//  NSObject+resourceJump.m
//  DJBusinessModule
//
//  Created by lxthyme on 2022/8/7.
//

#import "NSObject+resourceJump.h"
#import <DJGlobalStoreManager/DJStoreManager.h>
#import <BLBusinessCategoryRouterCenter/BLBusinessCategoryRouterCenter.h>
#import <DJBusinessCategoryRouterCenter/BLMediator+DJBusinessModule.h>
#import <IBLToastView/IBLToastView.h>
#import <DJBusinessTools/UIViewController+ex.h>
#import <CTAppContext_BaiLian/CTAppContext+BaiLian.h>
#import <CTAppContext_BaiLian/CTAppContext+BaiLian_H5Channel.h>

#import "DJActivityGoodsListViewController.h"
#import "DJMenuDetailWebViewController.h"

@implementation NSObject (resourceJump)

#pragma mark -- 资源位跳转公用
- (void)xl_resourceImageJump:(NSDictionary *)parm {
    if ([DJStoreManager sharedInstance].isChangeNet) {
        [IBLToastView toastInView:[UIApplication sharedApplication].keyWindow
                         withText:@"无网络连接"];
        return;
    }
    //修改整站传递
    [[BLMediator sharedInstance] saveResourceWithResourceId:[NSString stringWithFormat:@"%@",parm[@"resourceId"]] resourceType:@"1" deployId:parm[@"deployId"]];
    /*end*/
    UINavigationController *nav = [UIViewController topViewController].navigationController;
    NSInteger jumpType = [parm[@"jumpType"] integerValue];
    if (jumpType == 52) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parm];
        [params setObject:parm[@"resourceId"] forKey:@"resourceId"];
        [params setObject:parm[@"deployId"] forKey:@"depoyId"]; // 1.埋点使用 2.判断两个资源位是否相同
        [params setObject:parm[@"jumpUrl"] forKey:@"jumpURL"];
        UIViewController *cmsVc = [[BLMediator sharedInstance] DJBusinessModule_CMSWebViewWithParams:params];

        [nav pushViewController:cmsVc animated:YES];

        return;
    }
    else if (jumpType == 30) {

        DJActivityGoodsListViewController *vc = [[DJActivityGoodsListViewController alloc] initWith:parm];
        [nav pushViewController:vc animated:YES];


    }
    else if (jumpType == 90) {   // 商品详情页
        NSDictionary *resultDic = @{
            @"goodsId" : stringFromObject(parm, @"jumpUrl"),
            @"kHomeGoodCollectionViewCellDataKeygoodId" : stringFromObject(parm, @"jumpUrl")
        };

        UIViewController *vc = [[BLMediator sharedInstance] DJBusinessModule_DJProductDetailViewControllerWithParams:resultDic];
        [nav pushViewController:vc animated:YES];


    }
    else if (jumpType == 10001) {   // 大转盘
        NSMutableDictionary *parmDic = [NSMutableDictionary dictionaryWithDictionary:parm];
        NSString *jumpIdStr = stringFromObject(parmDic, @"jumpUrl");
        parmDic[@"jumpId"] = jumpIdStr;
        [[BLMediator sharedInstance] BLAdvertResource_viewControllerWithAdvertResource:parmDic];
    }
    else if (jumpType == 300008) {
        // 跳转小程序
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"userName"] = @"gh_0e742bc1f57c";
        NSDictionary *dic = [[BLMediator sharedInstance] resourceRecordDictonary];
        NSString *deployId = stringFromObject(dic, @"deployId");
        NSString *resourceId = stringFromObject(dic, @"resourceId");
        NSString *resourceType = stringFromObject(dic, @"resourceType");

        NSDictionary *jsonDic = @{
            @"deployId" : deployId,
            @"resourceId" : resourceId,
            @"resourceType" : resourceType,
            @"cm_mmc" : [CTAppContext sharedInstance].cm_mmc
        };
        NSString *jsonStr = [self convertToJsonData:jsonDic];
        NSString *utf8JosnStr = [jsonStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *tempStr = [NSString stringWithFormat:@"&custom_params=%@", utf8JosnStr];
        NSString *firstStr = stringFromObject(parm, @"jumpUrl");
        params[@"path"] = [NSString stringWithFormat:@"%@%@", firstStr, tempStr];
        [[BLMediator sharedInstance] launchMinProgramWithData:[params copy]];
    }
    else if (jumpType == 300010) {
        //跳转菜谱详情：

        NSMutableDictionary * paramsDict = [[NSMutableDictionary alloc] initWithCapacity:0];

        paramsDict[@"isFromDaoJiaApp"] = @"1"; //从到家内部跳转的而不是主站扫码预览的！

        paramsDict[@"menuId"] = stringFromObject(parm, @"jumpUrl");; //菜谱ID
        paramsDict[@"shopId"] = [DJStoreManager sharedInstance].shopId; //门店编码
        paramsDict[@"shopType"] = [DJStoreManager sharedInstance].shopType; //门店小业态
        paramsDict[@"comSid"] = [DJStoreManager sharedInstance].comSid; //门店大业态

        NSString * menuIdStr = paramsDict[@"menuId"]; //菜谱ID
    NSString * storeCode = paramsDict[@"shopId"]; //门店编码
    NSString * storeType = paramsDict[@"shopType"]; //门店小业态
    NSString * comSidStr = paramsDict[@"comSid"]; //门店大业态

    NSMutableDictionary * temp = [[NSMutableDictionary alloc] initWithDictionary:paramsDict copyItems:YES];

    NSString * urlString = @"";

//    跳转H5 菜谱页面url
//    菜谱详情Web页链接修改为：
//    http://dj.st.bl.com/recipe?recipe/Id=3291&shopId=007780&bizId=2020&comSid2000

    if ([CTAppContext sharedInstance].apiEnviroment == CTServiceAPIEnviromentDevelop) {
        urlString = [NSString stringWithFormat:@"https://dj.st.bl.com/recipe?id=%@&shopId=%@&bizId=%@&comSid=%@&memberToken=%@", menuIdStr,storeCode,storeType,comSidStr,[CTAppContext sharedInstance].memberToken];
    }else if ([CTAppContext sharedInstance].apiEnviroment == CTServiceAPIEnviromentRelease)
    {
        urlString = [NSString stringWithFormat:@"https://dj.bl.com/recipe?id=%@&shopId=%@&bizId=%@&comSid=%@&memberToken=%@", menuIdStr,storeCode,storeType,comSidStr,[CTAppContext sharedInstance].memberToken];
    }else {
        urlString = [NSString stringWithFormat:@"https://dj.bl.com/recipe?id=%@&shopId=%@&bizId=%@&comSid=%@&memberToken=%@", menuIdStr,storeCode,storeType,comSidStr,[CTAppContext sharedInstance].memberToken];
    }

    temp[@"urlString"] = urlString;

    DJMenuDetailWebViewController *viewController = [[DJMenuDetailWebViewController alloc] initWithParamData:temp];
        [nav pushViewController:viewController animated: YES];
    }
    else if(jumpType == 2001) {
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        param[@"resourceId"] = stringFromObject(parm, @"kDJQuerySiteResourceReformerDataKeyResourceId");
        param[@"depoyId"] = stringFromObject(parm, @"kDJQuerySiteResourceReformerDataKeyDepoyId");
        param[@"jumpURL"] = stringFromObject(parm, @"kDJQuerySiteResourceReformerDataKeyJumpURL");
        UIViewController *vc = [[BLMediator sharedInstance] DJBusinessModule_CMSWebViewWithParams:param];
        [nav pushViewController:vc animated:YES];
    }
    else {
        [[BLMediator sharedInstance] BLAdvertResource_viewControllerWithAdvertResource:parm];
        return;
    }

}

#pragma mark -
#pragma mark - 🔐Private Actions
-(NSString *)convertToJsonData:(NSDictionary *)dict {
    if (![dict isKindOfClass:[NSDictionary class]] || ![NSJSONSerialization isValidJSONObject:dict]) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];

    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return strJson;
}

@end
