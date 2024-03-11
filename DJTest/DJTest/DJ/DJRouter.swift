//
//  DJRouter.swift
//  DJTest
//
//  Created by lxthyme on 2024/3/11.
//
import UIKit
import LXToolKit

public enum DJEnv: String {
    case sit = "sit"
    case prd = "prd"
    case gray = "gray"
}
open class DJRouter: NSObject {
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    public static func getCurrentEnv() -> CTServiceAPIEnviroment {
        let ctx = CTAppContext.sharedInstance()!
        return ctx.apiEnviroment
    }
    public static func getCurrentEnvEnum() -> DJEnv {
        let env = getCurrentEnv()
        switch env {
        case .develop: return .sit
        case .preRelease: return .gray
        case .release, .notSetted: return .prd
        @unknown default:
            return .prd
        }
    }
}

/// Api 环境
public extension DJRouter {
    static func toggleEnv() {
        let ctx = CTAppContext.sharedInstance()!
        if(ctx.apiEnviroment == .release) {
            toggleEnvTo(env: .develop)
        } else {
            toggleEnvTo(env: .release)
        }
    }
    static func toggleEnvTo(env: CTServiceAPIEnviroment) {
        let ctx = CTAppContext.sharedInstance()!
        if(ctx.apiEnviroment == env) {
            return
        }
        ctx.apiEnviroment = env
        backupLogInfo()
        // backgs
    }
    // public static func getCurrentEnv() -> CTServiceAPIEnviroment {
    //     let ctx = CTAppContext.sharedInstance()!
    //     return ctx.apiEnviroment
    // }
    // static func getMain(storeCode: String, storeType: String) -> UIViewController {}
    // static func getQuickHome() -> UIViewController {}
}

// MARK: 👀信息迁移
public extension DJRouter {
    static func backupAllInfo() {
        backupLogInfo()
        backupGStore()
    }
    /// 手动迁移登录 & 全局门店
    static func transferLoginInfo() {
        let tmp = showCurrentLocalStorageInfo()
        guard let json = tmp.jsonString() else { return }
        let info = [
            "json": json
        ]
        backupToLocalStorage(localInfo: json)
        dlog("--->END")
    }
}
// MARK: 👀登录信息备份 & 恢复
public extension DJRouter {
    /// 从 localStorage 中恢复登录信息
    static func backupLogInfo() {
        let ctx = CTAppContext.sharedInstance()!
        let defaults = UserDefaults.standard

        let userInfoKey = ctx.getUserInfoLocalStorageKey()
        let plusKey = ctx.getPlusLocalStorageKey()
        if let userInfo = defaults.dictionary(forKey: userInfoKey) {
            let plusInfo = defaults.dictionary(forKey: plusKey) ?? [:]

            ctx.xl_updateUserInfo(userInfo)
            ctx.xl_updatePlusInfo(plusInfo)
        }
    }
    /// 迁移登录信息 & 全局门店信息到另一台设备
    static func backupToLocalStorage(localInfo: String) {
        guard let localObj = try? localInfo.data(using: .utf8)?.jsonObject() as? [String: Any] else { return }
        let ctx = CTAppContext.sharedInstance()!
        let gStore = DJStoreManager.sharedInstance()
        let defaults = UserDefaults.standard
        let sitTest = {
            ctx.apiEnviroment = .develop

            let sitObj = localObj["sit"] as? [String: Any]
            if let userInfoObj = sitObj?["userInfo"] as? [String: Any],
               userInfoObj.isNotEmpty {
                let userInfoKey = ctx.getUserInfoLocalStorageKey()
                let plusKey = ctx.getPlusLocalStorageKey()

                defaults.set(userInfoObj, forKey: userInfoKey)

                let plusInfoObj = sitObj?["plusInfo"] as? [String: Any]
                defaults.set(plusInfoObj, forKey: plusKey)

            } else {
                dlog("-->[SIT]登录信息为空, skipping...")
            }
            if let gStoreObj = sitObj?["gStore"] as? [String: Any],
               gStoreObj.isNotEmpty {
                let gStoreKey = getEnvLocalStorageKey()
                defaults.set(gStoreObj, forKey: gStoreKey)
            } else {
                dlog("-->[SIT]全局门店信息为空, skipping...")
            }
        }
        let prdTest = {
            ctx.apiEnviroment = .release

            let prdObj = localObj["prd"] as? [String: Any]
            if let userInfoObj = prdObj?["userInfo"] as? [String: Any],
               userInfoObj.isNotEmpty {
                let userInfoKey = ctx.getUserInfoLocalStorageKey()
                let plusKey = ctx.getPlusLocalStorageKey()

                defaults.set(userInfoObj, forKey: userInfoKey)

                let plusInfoObj = prdObj?["plusInfo"] as? [String: Any]
                defaults.set(plusInfoObj, forKey: plusKey)

            } else {
                dlog("-->[SIT]登录信息为空, skipping...")
            }
            if let gStoreObj = prdObj?["gStore"] as? [String: Any],
               gStoreObj.isNotEmpty {
                let gStoreKey = getEnvLocalStorageKey()
                defaults.set(gStoreObj, forKey: gStoreKey)
            } else {
                dlog("-->[SIT]全局门店信息为空, skipping...")
            }
        }

        let previousEnv = ctx.apiEnviroment
        sitTest()
        prdTest()
        ctx.apiEnviroment = previousEnv
    }
    /// [全环境]显示当前缓存的登录信息 & 全局门店信息
    static func showCurrentLocalStorageInfo() -> [String: Any] {
        let ctx = CTAppContext.sharedInstance()!
        let defaults = UserDefaults.standard

        var sitInfo: [String: Any] = [:]
        var prdInfo: [String: Any] = [:]

        let sitTest = {
            ctx.apiEnviroment = .develop
            let userInfoKey = ctx.getUserInfoLocalStorageKey()
            let plusKey = ctx.getPlusLocalStorageKey()
            let gStoreKey = getEnvLocalStorageKey()

            let userInfo = defaults.dictionary(forKey: userInfoKey)
            let plusInfo = defaults.dictionary(forKey: plusKey)
            let gStoreInfo = defaults.dictionary(forKey: gStoreKey)
            sitInfo["userInfo"] = userInfo
            sitInfo["plusInfo"] = plusInfo
            sitInfo["gStore"] = gStoreInfo
        }

        let prdTest = {
            ctx.apiEnviroment = .release
            let userInfoKey = ctx.getUserInfoLocalStorageKey()
            let plusKey = ctx.getPlusLocalStorageKey()
            let gStoreKey = getEnvLocalStorageKey()

            let userInfo = defaults.dictionary(forKey: userInfoKey)
            let plusInfo = defaults.dictionary(forKey: plusKey)
            let gStoreInfo = defaults.dictionary(forKey: gStoreKey)
            prdInfo["userInfo"] = userInfo
            prdInfo["plusInfo"] = plusKey
            prdInfo["gStore"] = gStoreInfo
        }

        let previousEnv = ctx.apiEnviroment
        sitTest()
        prdTest()
        ctx.apiEnviroment = previousEnv
        return [
            "sit": sitInfo,
            "prd": prdInfo
        ]
    }
    /// 根据当前环境显示当前登录信息
    static func showCurrentCtxInfo() {
        let ctx = CTAppContext.sharedInstance()!
        let gStore = DJStoreManager.sharedInstance()
        if ctx.apiEnviroment == .develop {
            let sit = [
                "memberMobilePhoneNumber": ctx.memberMobilePhoneNumber,
                "memberToken": ctx.memberToken,
                "shopName": gStore.storeModel.shopName,
                "shopId": gStore.storeModel.shopId,
            ]
            dlog("-->Current Info[SIT]: \(sit)")
        }
        if ctx.apiEnviroment == .release {
            let prd = [
                "memberMobilePhoneNumber": ctx.memberMobilePhoneNumber,
                "memberToken": ctx.memberToken,
                "shopName": gStore.storeModel.shopName,
                "shopId": gStore.storeModel.shopId,
            ]
            dlog("-->Current Info[PRD]: \(prd)")
        }
    }
    // static func () {}
}
// MARK: 👀全局门店信息备份 & 恢复
public extension DJRouter {
    static func getEnvLocalStorageKey() -> String {
        let env = getCurrentEnv()
        var key = "DJTest.gStore."
        switch env {
        case .develop:
            key.append("develop")
        case .preRelease:
            key.append("beta")
        default:
            key.append("release")
        }
        return key
    }
    /// 将全局门店缓存到 NSUserDefaults
    static func saveGStore() {
        let gStore = DJStoreManager.sharedInstance()
        let defaults = UserDefaults.standard
        
        let json = gStore.yy_modelToJSONObject()
        let key = getEnvLocalStorageKey()
        defaults.set(json, forKey: key)
    }
    ///从 NSUserDefaults 中恢复全局门店
    static func backupGStore() {
        let defaults = UserDefaults.standard
        let gStore = DJStoreManager.sharedInstance()

        let key = getEnvLocalStorageKey()
        guard let jsonString = defaults.value(forKey: key),
              let model = DJStoreManager.yy_model(withJSON: jsonString) else { return }
        checkEqual(gStore: gStore, model: model)

        gStore.sendType = model.sendType
        gStore.sceneId = model.sceneId
        gStore.longtitude = model.longtitude
        gStore.latitude = model.latitude
        gStore.currentAddress = model.currentAddress
        gStore.addressRawDic = model.addressRawDic
        gStore.orderSourceCode = model.orderSourceCode
        gStore.nearShopListArr = model.nearShopListArr
        gStore.locationAdress = model.locationAdress
        gStore.locationCity = model.locationCity
        gStore.bl_ad = model.bl_ad
        gStore.djHomeStyle = model.djHomeStyle
        gStore.isChangeNet = model.isChangeNet
        gStore.isDaoJiaApp = model.isDaoJiaApp
        gStore.djHomeSearchStr = model.djHomeSearchStr
        gStore.djModuleType = model.djModuleType
        gStore.sourceValue = model.sourceValue
        gStore.packageArray = model.packageArray
        gStore.isDeveloper = model.isDeveloper
        gStore.developerLatitude = model.developerLatitude
        gStore.developerLongtitude = model.developerLongtitude
        gStore.djClassifyHeaderType = model.djClassifyHeaderType
        gStore.headerBgColorStr = model.headerBgColorStr
        gStore.head4FCDefColor = model.head4FCDefColor
        gStore.head4FCActiveColor = model.head4FCActiveColor
        gStore.labelColor = model.labelColor
        gStore.classifyShowIndex = model.classifyShowIndex
        gStore.isFirstShowClassify = model.isFirstShowClassify
        gStore.leaveDJTimeStr = model.leaveDJTimeStr
        // gStore.storeModel = model.storeModel
        gStore.sceneQueryModel = model.sceneQueryModel
        // gStore.storeDictionary = model.storeDictionary
        gStore.inStoreStyle = model.inStoreStyle
        gStore.tdStoreModel = model.tdStoreModel
        gStore.shopCart_storeModel = model.shopCart_storeModel
        gStore.shopCart_tdStoreModel = model.shopCart_tdStoreModel
        gStore.headType = model.headType
        gStore.homeSelectTabType = model.homeSelectTabType
        // [gStore storeMessageTransform:[model.storeModel yy_modelToJSONObject]]
        if let obj = model.storeModel.yy_modelToJSONObject() as? [String: Any] {
            gStore.storeMessageTransform(obj)
        }
    }
    static func checkEqual(gStore: DJStoreManager, model: DJStoreManager) {
        let eq_sendType = gStore.sendType == model.sendType
        let eq_sceneId = gStore.sceneId == model.sceneId
        let eq_longtitude = gStore.longtitude == model.longtitude
        let eq_latitude = gStore.latitude == model.latitude
        let eq_currentAddress = gStore.currentAddress == model.currentAddress
        // let eq_addressRawDic = NSDictionary(dictionary: gStore.addressRawDic).isEqual(to: NSDictionary(dictionary: model.addressRawDic))
        let eq_orderSourceCode = gStore.orderSourceCode == model.orderSourceCode
        let eq_nearShopListArr = gStore.nearShopListArr == model.nearShopListArr
        let eq_locationAdress = gStore.locationAdress == model.locationAdress
        let eq_locationCity = gStore.locationCity == model.locationCity
        let eq_bl_ad = gStore.bl_ad == model.bl_ad
        let eq_djHomeStyle = gStore.djHomeStyle == model.djHomeStyle
        let eq_isChangeNet = gStore.isChangeNet == model.isChangeNet
        let eq_isDaoJiaApp = gStore.isDaoJiaApp == model.isDaoJiaApp
        let eq_djHomeSearchStr = gStore.djHomeSearchStr == model.djHomeSearchStr
        let eq_djModuleType = gStore.djModuleType == model.djModuleType
        let eq_sourceValue = gStore.sourceValue == model.sourceValue
        let eq_packageArray = gStore.packageArray.count == model.packageArray.count
        let eq_isDeveloper = gStore.isDeveloper == model.isDeveloper
        let eq_developerLatitude = gStore.developerLatitude == model.developerLatitude
        let eq_developerLongtitude = gStore.developerLongtitude == model.developerLongtitude
        let eq_djClassifyHeaderType = gStore.djClassifyHeaderType == model.djClassifyHeaderType
        let eq_headerBgColorStr = gStore.headerBgColorStr == model.headerBgColorStr
        let eq_head4FCDefColor = gStore.head4FCDefColor == model.head4FCDefColor
        let eq_head4FCActiveColor = gStore.head4FCActiveColor == model.head4FCActiveColor
        let eq_labelColor = gStore.labelColor == model.labelColor
        let eq_classifyShowIndex = gStore.classifyShowIndex == model.classifyShowIndex
        let eq_isFirstShowClassify = gStore.isFirstShowClassify == model.isFirstShowClassify
        let eq_leaveDJTimeStr = gStore.leaveDJTimeStr == model.leaveDJTimeStr
        let eq_storeModel = gStore.storeModel.isSameStore(with: model.storeModel)
        let eq_sceneQueryModel = gStore.sceneQueryModel.isEqual(model.sceneQueryModel)
        // let eq_storeDictionary = NSDictionary(dictionary: gStore.storeDictionary).isEqual(to: NSDictionary(dictionary: model.storeDictionary))
        let eq_inStoreStyle = gStore.inStoreStyle == model.inStoreStyle
        let eq_tdStoreModel = gStore.tdStoreModel.isEqual(model.tdStoreModel)
        let eq_shopCart_storeModel = gStore.shopCart_storeModel.isEqual(model.shopCart_storeModel)
        let eq_shopCart_tdStoreModel = gStore.shopCart_tdStoreModel.isEqual(model.shopCart_tdStoreModel)
        let eq_headType = gStore.headType == model.headType
        let eq_homeSelectTabType = gStore.homeSelectTabType == model.homeSelectTabType
        let success = eq_sendType
        && eq_sceneId
        && eq_longtitude
        && eq_latitude
        && eq_currentAddress
        // && eq_addressRawDic
        && eq_orderSourceCode
        && eq_nearShopListArr
        && eq_locationAdress
        && eq_locationCity
        && eq_bl_ad
        && eq_djHomeStyle
        && eq_isChangeNet
        && eq_isDaoJiaApp
        && eq_djHomeSearchStr
        && eq_djModuleType
        && eq_sourceValue
        && eq_packageArray
        && eq_isDeveloper
        && eq_developerLatitude
        && eq_developerLongtitude
        && eq_djClassifyHeaderType
        && eq_headerBgColorStr
        && eq_head4FCDefColor
        && eq_head4FCActiveColor
        && eq_labelColor
        && eq_classifyShowIndex
        && eq_isFirstShowClassify
        // && eq_leaveDJTimeStr
        && eq_storeModel
        // && eq_sceneQueryModel
        // && eq_storeDictionary
        && eq_inStoreStyle
        // && eq_tdStoreModel
        // && eq_shopCart_storeModel
        // && eq_shopCart_tdStoreModel
        && eq_headType
        && eq_homeSelectTabType
        if success {
            return
        }
        var result = ""
        // if !eq_sendType { result.append("eq_sendType: \(LXMacro.boolString(eq_sendType))\n") }
        // if !eq_sceneId { result.append("eq_sceneId: \(LXMacro.boolString(eq_sceneId))\n") }
        // if !eq_longtitude { result.append("eq_longtitude: \(LXMacro.boolString(eq_longtitude))\n") }
        // if !eq_latitude { result.append("eq_latitude: \(LXMacro.boolString(eq_latitude))\n") }
        // if !eq_currentAddress { result.append("eq_currentAddress: \(LXMacro.boolString(eq_currentAddress))\n") }
        // // if !eq_addressRawDic { result.append("eq_addressRawDic: \(LXMacro.boolString(eq_addressRawDic))\n") }
        // if !eq_orderSourceCode { result.append("eq_orderSourceCode: \(LXMacro.boolString(eq_orderSourceCode))\n") }
        // if !eq_nearShopListArr { result.append("eq_nearShopListArr: \(LXMacro.boolString(eq_nearShopListArr))\n") }
        // if !eq_locationAdress { result.append("eq_locationAdress: \(LXMacro.boolString(eq_locationAdress))\n") }
        // if !eq_locationCity { result.append("eq_locationCity: \(LXMacro.boolString(eq_locationCity))\n") }
        // if !eq_bl_ad { result.append("eq_bl_ad: \(LXMacro.boolString(eq_bl_ad))\n") }
        // if !eq_djHomeStyle { result.append("eq_djHomeStyle: \(LXMacro.boolString(eq_djHomeStyle))\n") }
        // if !eq_isChangeNet { result.append("eq_isChangeNet: \(LXMacro.boolString(eq_isChangeNet))\n") }
        // if !eq_isDaoJiaApp { result.append("eq_isDaoJiaApp: \(LXMacro.boolString(eq_isDaoJiaApp))\n") }
        // if !eq_djHomeSearchStr { result.append("eq_djHomeSearchStr: \(LXMacro.boolString(eq_djHomeSearchStr))\n") }
        // if !eq_djModuleType { result.append("eq_djModuleType: \(LXMacro.boolString(eq_djModuleType))\n") }
        // if !eq_sourceValue { result.append("eq_sourceValue: \(LXMacro.boolString(eq_sourceValue))\n") }
        // if !eq_packageArray { result.append("eq_packageArray: \(LXMacro.boolString(eq_packageArray))\n") }
        // if !eq_isDeveloper { result.append("eq_isDeveloper: \(LXMacro.boolString(eq_isDeveloper))\n") }
        // if !eq_developerLatitude { result.append("eq_developerLatitude: \(LXMacro.boolString(eq_developerLatitude))\n") }
        // if !eq_developerLongtitude { result.append("eq_developerLongtitude: \(LXMacro.boolString(eq_developerLongtitude))\n") }
        // if !eq_djClassifyHeaderType { result.append("eq_djClassifyHeaderType: \(LXMacro.boolString(eq_djClassifyHeaderType))\n") }
        // if !eq_headerBgColorStr { result.append("eq_headerBgColorStr: \(LXMacro.boolString(eq_headerBgColorStr))\n") }
        // if !eq_head4FCDefColor { result.append("eq_head4FCDefColor: \(LXMacro.boolString(eq_head4FCDefColor))\n") }
        // if !eq_head4FCActiveColor { result.append("eq_head4FCActiveColor: \(LXMacro.boolString(eq_head4FCActiveColor))\n") }
        // if !eq_labelColor { result.append("eq_labelColor: \(LXMacro.boolString(eq_labelColor))\n") }
        // if !eq_classifyShowIndex { result.append("eq_classifyShowIndex: \(LXMacro.boolString(eq_classifyShowIndex))\n") }
        // if !eq_isFirstShowClassify { result.append("eq_isFirstShowClassify: \(LXMacro.boolString(eq_isFirstShowClassify))\n") }
        // if !eq_leaveDJTimeStr { result.append("eq_leaveDJTimeStr: \(LXMacro.boolString(eq_leaveDJTimeStr))\n") }
        // if !eq_storeModel { result.append("eq_storeModel: \(LXMacro.boolString(eq_storeModel))\n") }
        // if !eq_sceneQueryModel { result.append("eq_sceneQueryModel: \(LXMacro.boolString(eq_sceneQueryModel))\n") }
        // // if !eq_storeDictionary { result.append("eq_storeDictionary: \(LXMacro.boolString(eq_storeDictionary))\n") }
        // if !eq_inStoreStyle { result.append("eq_inStoreStyle: \(LXMacro.boolString(eq_inStoreStyle))\n") }
        // if !eq_tdStoreModel { result.append("eq_tdStoreModel: \(LXMacro.boolString(eq_tdStoreModel))\n") }
        // if !eq_shopCart_storeModel { result.append("eq_shopCart_storeModel: \(LXMacro.boolString(eq_shopCart_storeModel))\n") }
        // if !eq_shopCart_tdStoreModel { result.append("eq_shopCart_tdStoreModel: \(LXMacro.boolString(eq_shopCart_tdStoreModel))\n") }
        // if !eq_headType { result.append("eq_headType: \(LXMacro.boolString(eq_headType))\n") }
        // if !eq_homeSelectTabType { result.append("eq_homeSelectTabType: \(LXMacro.boolString(eq_homeSelectTabType))\n") }
        dlog("result: \(result)")
    }
    // static func () {}
}

// MARK: 🔐Private Actions
private extension DJRouter {}
