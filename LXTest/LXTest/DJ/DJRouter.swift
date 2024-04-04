//
//  DJRouter.swift
//  LXTest
//
//  Created by lxthyme on 2024/3/11.
//
import UIKit
import LXToolKit
import KeychainAccess

private let keychain = Keychain(service: "com.lx.bl", accessGroup: "group.com.lx.ble")
private let userData: DJSavedData = .userInfo
private let plusData: DJSavedData = .plusInfo
private let storeData: DJSavedData = .storeInfo
private let getSaveType: (_ fromDefaults: Bool) -> String = { fromDefaults in fromDefaults ? "UserDefaults" : "KeyChain" }

enum DaoJiaConfig: String {
    case test
    enum LocalKey: String {
        case autoPinnedDaoJiaSection
    }
}

// MARK: - 👀
extension DaoJiaConfig.LocalKey {
    func getValue() -> String? {
        return try? keychain.get(rawValue)
    }
    func setValue(_ value: String?) {
        try? keychain.set(value ?? "", key: rawValue)
    }
}

struct DJLocalInfo {
    var userInfo: [String: Any]?
    var plusInfo: [String: Any]?
    var storeInfo: [String: Any]?
    init(localInfo: [String : Any]? = nil) {
        self.userInfo = localInfo?[userData.dictKey] as? [String: Any]
        self.plusInfo = localInfo?[plusData.dictKey] as? [String: Any]
        self.storeInfo = localInfo?[storeData.dictKey] as? [String: Any]
    }
    init(userInfo: [String : Any]? = nil,
         plusInfo: [String : Any]? = nil,
         storeInfo: [String : Any]? = nil) {
        self.userInfo = userInfo
        self.plusInfo = plusInfo
        self.storeInfo = storeInfo
    }
    func xl_jsonObject() -> [String: Any?] {
        let info = [
            userData.dictKey: self.userInfo,
            plusData.dictKey: self.plusInfo,
            storeData.dictKey: self.storeInfo,
        ]
        return info
    }
}

open class DJRouter: NSObject {
    // MARK: 🔗Vaiables
    // MARK: 🛠Life Cycle
    public static func getCurrentEnv() -> CTServiceAPIEnviroment {
        let ctx = CTAppContext.sharedInstance()!
        return ctx.apiEnviroment
    }
}

public extension DJRouter {
    static func getMain(storeCode: String? = nil, storeType: String? = nil) -> UIViewController? {
        var params = [
            "url": "blmodule://quickHome/home"
        ]
        if let storeCode, storeCode.isNotEmpty,
            let storeType, storeType.isNotEmpty {
            params["url"] = "blmodule://quickHome/home?storeCode=\(storeCode)&storeType=\(storeType)"
        }
        let vc = BLMediator.sharedInstance().djBusinessModule_NewMain(params)
        return vc
    }
    static func getQuickHome() -> UIViewController {
        return DJRouterObjc.getQuickHome()
    }
    static func getGoodsDetail(storeCode: String, storeType: String, merchantId: String, goodsId: String, tdType: String) -> UIViewController {
        guard let vc = BLMediator.sharedInstance().djBusinessModule_DJProductDetailViewController(withParams: [
            "storeCode": storeCode,
            "storeType": storeType,
            "merchantId": merchantId,
            "tdType": tdType,
            "goodsId": goodsId,
        ]) else {
            let vc = LXSampleTextViewVC()
            vc.dataFillUnSupport(content: "goGoodsDetail failed!")
            return vc
        }
        return vc
    }
}

/// Api 环境
public extension DJRouter {
    static func toggleEnv() {
        let ctx = CTAppContext.sharedInstance()!
        if(ctx.apiEnviroment == .release) {
            UIViewController.getTopVC()?.view.makeToast("已切换到 sit")
            toggleEnvTo(env: .develop)
        } else {
            UIViewController.getTopVC()?.view.makeToast("已切换到 release")
            toggleEnvTo(env: .release)
        }
    }
    static func toggleEnvTo(env: CTServiceAPIEnviroment) {
        let ctx = CTAppContext.sharedInstance()!
        if(ctx.apiEnviroment == env) {
            return
        }
        ctx.apiEnviroment = env
        DJSavedData.backupLogInfo(false)
        DJSavedData.backupGStore(false)
    }
    // static func getMain(storeCode: String, storeType: String) -> UIViewController {}
    // static func getQuickHome() -> UIViewController {}
}
// MARK: 👀全局门店 & 用户信息备份
extension DJSavedData {
    /// [当前环境]将全局门店缓存到 keychain & UserDefaults
    static func saveGStore() {
        let ctx = CTAppContext.sharedInstance()!
        let gStore = DJStoreManager.sharedInstance()
        let currentEnv = ctx.apiEnviroment

        if let storeInfoJson = gStore.yy_modelToJSONString() {
            storeData.updateValue(currentEnv, value: storeInfoJson)
        }
    }
    /// [当前环境]将登录信息缓存到 keychain & UserDefaults
    static func saveLoginInfo() {
        let ctx = CTAppContext.sharedInstance()!
        let currentEnv = ctx.apiEnviroment

        if let userInfoJson = ctx.userInfo.jsonString() {
            userInfo.updateValue(currentEnv, value: userInfoJson)

            let plusInfoJson = ctx.plusInfo?.jsonString() ?? ""
            plusInfo.updateValue(currentEnv, value: plusInfoJson)
        }
    }

}
extension DJSavedData {
    @discardableResult
    /// [all env]显示当前缓存的登录信息 & 全局门店信息
    /// - Parameter fromDefaults: true: 从 UserDefaults 中恢复数据
    static func showCurrentLocalInfo(_ fromDefaults: Bool) -> [CTServiceAPIEnviroment: DJLocalInfo] {
        var sit = DJLocalInfo()
        sit.userInfo = userData.getDictionary(.develop, fromDefaults: fromDefaults)
        sit.plusInfo = plusData.getDictionary(.develop, fromDefaults: fromDefaults)
        sit.storeInfo = storeData.getDictionary(.develop, fromDefaults: fromDefaults)
        var prd = DJLocalInfo()
        prd.userInfo = userData.getDictionary(.develop, fromDefaults: fromDefaults)
        prd.plusInfo = plusData.getDictionary(.develop, fromDefaults: fromDefaults)
        prd.storeInfo = storeData.getDictionary(.develop, fromDefaults: fromDefaults)
        let info = ["sit": sit.xl_jsonObject(), "prd": prd.xl_jsonObject()]
        dlog("-->Current Local Info[\(getSaveType(fromDefaults))]: \(info.jsonString(prettify:true) ?? "--")")
        return [
            .develop: sit,
            .release: prd
        ]
    }
    /// [当前环境]显示当前登录信息
    @discardableResult
    static func showCurrentContextInfo() -> (sit: [String: Any], prd: [String: Any]) {
        let ctx = CTAppContext.sharedInstance()!
        let gStore = DJStoreManager.sharedInstance()
        var sit: [String: Any] = [:]
        if ctx.apiEnviroment == .develop {
            if let tel = ctx.memberMobilePhoneNumber {
                sit["memberMobilePhoneNumber"] = tel
            }
            if let token = ctx.memberToken {
                sit["memberToken"] = token
            }
            sit["shopName"] = gStore.storeModel.shopName
            sit["shopId"] = gStore.storeModel.shopId
            dlog("-->Current Info[SIT]: \(sit.jsonString(prettify:true) ?? "--")")
        }
        var prd: [String: Any] = [:]
        if ctx.apiEnviroment == .release {
            if let tel = ctx.memberMobilePhoneNumber {
                prd["memberMobilePhoneNumber"] = tel
            }
            if let token = ctx.memberToken {
                prd["memberToken"] = token
            }
            prd["shopName"] = gStore.storeModel.shopName
            prd["shopId"] = gStore.storeModel.shopId
            dlog("-->Current Info[PRD]: \(prd.jsonString(prettify:true) ?? "--")")
        }
        return (sit, prd)
    }
}
// MARK: 👀全局门店 & 用户信息恢复
extension DJSavedData {
    /// [all env]从本地存储中恢复登录 & 全局门店信息
    /// - Parameter fromDefaults: true: 从 UserDefaults 中恢复数据
    static func transferLoginInfo(_ fromDefaults: Bool) {
        let tmp = DJSavedData.showCurrentLocalInfo(fromDefaults)
        backupToLocalStorage(localInfo: tmp)
    }
    /// [all env]从给定的字符串中迁移登录信息 & 全局门店信息
    static func backupToLocalStorage(localInfo: [CTServiceAPIEnviroment: DJLocalInfo]) {
        // guard let localObj = try? localInfo.data(using: .utf8)?.jsonObject() as? [String: Any] else { return }

        let sitTest = {
            // let sitObj = localObj["sit"] as? [String: Any]
            let sitObj = localInfo[.develop]
            if let userInfoObj = sitObj?.userInfo,
               userInfoObj.isNotEmpty {
                userData.updateDictionary(.develop, value: userInfoObj)
                let plusInfoObj = sitObj?.plusInfo
                plusData.updateDictionary(.develop, value: plusInfoObj)
            } else {
                dlog("-->[SIT]登录信息为空, skipping...")
            }
            if let gStoreObj = sitObj?.storeInfo,
               gStoreObj.isNotEmpty {
                storeData.updateDictionary(.develop, value: gStoreObj)
            } else {
                dlog("-->[SIT]全局门店信息为空, skipping...")
            }
        }
        let prdTest = {
            let prdObj = localInfo[.release]
            if let userInfoObj = prdObj?.userInfo,
               userInfoObj.isNotEmpty {
                userData.updateDictionary(.release, value: userInfoObj)
                let plusInfoObj = prdObj?.plusInfo
                plusData.updateDictionary(.release, value: plusInfoObj)
            } else {
                dlog("-->[SIT]登录信息为空, skipping...")
            }
            if let gStoreObj = prdObj?.storeInfo,
               gStoreObj.isNotEmpty {
                storeData.updateDictionary(.develop, value: gStoreObj)
            } else {
                dlog("-->[SIT]全局门店信息为空, skipping...")
            }
        }
        sitTest()
        prdTest()
    }
    /// [当前环境]从 keychain 中恢复登录信息
    /// - Parameter fromDefaults: true: 从 UserDefaults 中恢复数据
    static func backupLogInfo(_ fromDefaults: Bool) {
        let ctx = CTAppContext.sharedInstance()!
        let currentEnv = ctx.apiEnviroment

        if let userInfoJson = userData.getDictionary(currentEnv, fromDefaults: fromDefaults) {
            ctx.xl_updateUserInfo(userInfoJson)
            ctx.xl_updatePlusInfo(plusInfo.getDictionary(currentEnv, fromDefaults: fromDefaults))
        }
    }
    /// [当前环境]从 keychain 中恢复全局门店
    /// - Parameter fromDefaults: true: 从 UserDefaults 中恢复数据
    static func backupGStore(_ fromDefaults: Bool) {
        let ctx = CTAppContext.sharedInstance()!
        let gStore = DJStoreManager.sharedInstance()
        let currentEnv = ctx.apiEnviroment

        guard let jsonString = storeInfo.getDictionary(currentEnv, fromDefaults: fromDefaults),
              let model = DJStoreManager.yy_model(withJSON: jsonString) else { return }
        if gStore.storeModel.isValid() {
            checkEqual(gStore: gStore, model: model)
        }

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
        if !eq_sendType { result.append("eq_sendType: \(eq_sendType)\n") }
        if !eq_sceneId { result.append("eq_sceneId: \(eq_sceneId)\n") }
        if !eq_longtitude { result.append("eq_longtitude: \(eq_longtitude)\n") }
        if !eq_latitude { result.append("eq_latitude: \(eq_latitude)\n") }
        if !eq_currentAddress { result.append("eq_currentAddress: \(eq_currentAddress)\n") }
        // if !eq_addressRawDic { result.append("eq_addressRawDic: \(eq_addressRawDic)\n") }
        if !eq_orderSourceCode { result.append("eq_orderSourceCode: \(eq_orderSourceCode)\n") }
        if !eq_nearShopListArr { result.append("eq_nearShopListArr: \(eq_nearShopListArr)\n") }
        if !eq_locationAdress { result.append("eq_locationAdress: \(eq_locationAdress)\n") }
        if !eq_locationCity { result.append("eq_locationCity: \(eq_locationCity)\n") }
        if !eq_bl_ad { result.append("eq_bl_ad: \(eq_bl_ad)\n") }
        if !eq_djHomeStyle { result.append("eq_djHomeStyle: \(eq_djHomeStyle)\n") }
        if !eq_isChangeNet { result.append("eq_isChangeNet: \(eq_isChangeNet)\n") }
        if !eq_isDaoJiaApp { result.append("eq_isDaoJiaApp: \(eq_isDaoJiaApp)\n") }
        if !eq_djHomeSearchStr { result.append("eq_djHomeSearchStr: \(eq_djHomeSearchStr)\n") }
        if !eq_djModuleType { result.append("eq_djModuleType: \(eq_djModuleType)\n") }
        if !eq_sourceValue { result.append("eq_sourceValue: \(eq_sourceValue)\n") }
        if !eq_packageArray { result.append("eq_packageArray: \(eq_packageArray)\n") }
        if !eq_isDeveloper { result.append("eq_isDeveloper: \(eq_isDeveloper)\n") }
        if !eq_developerLatitude { result.append("eq_developerLatitude: \(eq_developerLatitude)\n") }
        if !eq_developerLongtitude { result.append("eq_developerLongtitude: \(eq_developerLongtitude)\n") }
        if !eq_djClassifyHeaderType { result.append("eq_djClassifyHeaderType: \(eq_djClassifyHeaderType)\n") }
        if !eq_headerBgColorStr { result.append("eq_headerBgColorStr: \(eq_headerBgColorStr)\n") }
        if !eq_head4FCDefColor { result.append("eq_head4FCDefColor: \(eq_head4FCDefColor)\n") }
        if !eq_head4FCActiveColor { result.append("eq_head4FCActiveColor: \(eq_head4FCActiveColor)\n") }
        if !eq_labelColor { result.append("eq_labelColor: \(eq_labelColor)\n") }
        if !eq_classifyShowIndex { result.append("eq_classifyShowIndex: \(eq_classifyShowIndex)\n") }
        if !eq_isFirstShowClassify { result.append("eq_isFirstShowClassify: \(eq_isFirstShowClassify)\n") }
        if !eq_leaveDJTimeStr { result.append("eq_leaveDJTimeStr: \(eq_leaveDJTimeStr)\n") }
        if !eq_storeModel { result.append("eq_storeModel: \(eq_storeModel)\n") }
        if !eq_sceneQueryModel { result.append("eq_sceneQueryModel: \(eq_sceneQueryModel)\n") }
        // if !eq_storeDictionary { result.append("eq_storeDictionary: \(eq_storeDictionary)\n") }
        if !eq_inStoreStyle { result.append("eq_inStoreStyle: \(eq_inStoreStyle)\n") }
        if !eq_tdStoreModel { result.append("eq_tdStoreModel: \(eq_tdStoreModel)\n") }
        if !eq_shopCart_storeModel { result.append("eq_shopCart_storeModel: \(eq_shopCart_storeModel)\n") }
        if !eq_shopCart_tdStoreModel { result.append("eq_shopCart_tdStoreModel: \(eq_shopCart_tdStoreModel)\n") }
        if !eq_headType { result.append("eq_headType: \(eq_headType)\n") }
        if !eq_homeSelectTabType { result.append("eq_homeSelectTabType: \(eq_homeSelectTabType)\n") }
        dlog("result: \(result)")
    }
    // static func () {}
}
// MARK: - 👀
extension CTServiceAPIEnviroment {
    var title: String {
        switch self {
        case .develop:
            return "sit"
        case .preRelease:
            return "beta"
        default:
            return "prd"
        }
    }
}
// MARK: 🔐keychain action
// private extension DJRouter {
    enum DJSavedData {
        case userInfo
        case plusInfo
        case storeInfo
    }
// }
private extension DJSavedData {
    var dictKey: String {
        switch self {
        case .userInfo:
            return "userInfo"
        case .plusInfo:
            return "plusInfo"
        case .storeInfo:
            return "storeInfo"
        }
    }
    func getKey(_ env: CTServiceAPIEnviroment?) -> String {
        let env_t = if let env {
            env
        } else {
            CTAppContext.sharedInstance().apiEnviroment
        }
        switch self {
        case .userInfo:
            return "DJTest.\(env_t.title).userInfo"
        case .plusInfo:
            return "DJTest.\(env_t.title).plusInfo"
        case .storeInfo:
            return "DJTest.\(env_t.title).storeInfo"
        }
    }
    func getValue(_ env: CTServiceAPIEnviroment? = nil, fromDefaults: Bool) -> String {
        return DJSavedData.getValue(key: getKey(env), fromDefaults: fromDefaults) ?? ""
    }
    func getDictionary(_ env: CTServiceAPIEnviroment? = nil, fromDefaults: Bool) -> [String: Any]? {
        return DJSavedData.getDictionary(key: getKey(env), fromDefaults: fromDefaults)
    }
    func updateValue(_ env: CTServiceAPIEnviroment? = nil, value: String?) {
        DJSavedData.saveAt(key: getKey(env), value: value)
    }
    func updateDictionary(_ env: CTServiceAPIEnviroment? = nil, value: [String: Any]?) {
        let json = value?.jsonString()
        updateValue(env, value: json)
    }
}
private extension DJSavedData {
    static func saveAt(key: String, value: String?) {
        do {
            let defaults = UserDefaults.standard
            if let value {
                try keychain.set(value, key: key)
                defaults.set(value, forKey: key)
                dlog("-->保存 \(key) 成功")
            } else {
                try keychain.remove(key)
                defaults.removeObject(forKey: key)
                dlog("-->保存 \(key) (清空)成功")
            }
            // defaults.synchronize()
        } catch {
            dlog("-->保存 \(key) 失败: \(error)")
        }
    }
    static func getValue(key: String, fromDefaults: Bool) -> String? {
        var result: String?
        do {
            if fromDefaults {
                result = UserDefaults.standard.string(forKey: key)
            } else {
                result = try keychain.getString(key)
            }
            // dlog("-->读取[\(getSaveType(fromDefaults))]\(key): \(result ?? "--")")
        } catch {
            dlog("-->读取[\(getSaveType(fromDefaults))]\(key) 失败: \(error)")
        }
        return result
    }
    static func getDictionary(key: String, fromDefaults: Bool) -> [String: Any]? {
        var result: [String: Any]?
        guard let string = getValue(key: key, fromDefaults: fromDefaults), string.isNotEmpty else { return nil }
        do {
            if let data = string.data(using: .utf8) {
                result = try JSONSerialization.jsonObject(with: data) as? [String : Any]
                // dlog("-->读取[\(getSaveType(fromDefaults))]\(key): \(result ?? [:])")
            }
        } catch {
            dlog("""
                 -->读取[\(getSaveType(fromDefaults))]\(key) 失败[序列化]:
                 value: \(string)
                 error: \(error)
                 """)
        }
        return result
    }
}


// MARK: - 👀
extension CTAppContext {
    func xl_updatePlusInfo(_ plusInfo: [String: Any]?) {
        self.plusInfo = plusInfo
        dlog("-->[CTAppContext]更新 plus 信息")
        plusData.updateDictionary(value: plusInfo)
    }
    func xl_cleanPlusInfo() {
        self.plusInfo = nil
        dlog("-->[CTAppContext]清空 plus 信息")
        plusData.updateDictionary(value: nil)
    }
    func xl_updateUserInfo(_ userInfo: [String: Any]?) {
        self.userInfo = userInfo
        dlog("-->[CTAppContext]更新用户信息")
        userData.updateDictionary(value: userInfo)
    }
    func xl_cleanUserInfo() {
        self.userInfo = nil
        dlog("-->[CTAppContext]清空用户信息")
        userData.updateDictionary(value: nil)
    }
}
