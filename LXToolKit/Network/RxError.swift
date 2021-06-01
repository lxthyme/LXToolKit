//
//  RxError.swift
//  LXToolKit
//
//  Created by LXThyme Jason on 2021/1/9.
//

import Foundation
import UIKit
import HandyJSON
import Moya

public enum ApiError: Error {
    case offline
    case serverError(response: Moya.Response?, error: Error?)
    case serializeError(response: Moya.Response?, error: Error?)
    case nocontent
    case invalidStatusCode(statusCode: Int?, tips: String?)

    public var identifier: String {
        switch self {
        case .offline: return "offline"
        case .serverError: return "serverError"
        case .serializeError: return "serializeError"
        case .nocontent: return "nocontent"
        case .invalidStatusCode(let statusCode, let tips):
            return "\(statusCode ?? 999): \(tips ?? "")"
        }
    }
    public var title: String {
        switch self {
        case .offline: return "无网络连接"
        case .serverError: return "serverError"
        case .serializeError: return "serverError"
        case .nocontent: return ""
        case .invalidStatusCode(_, let tips): return tips ?? "--"
        }
    }

    public var description: String {
        switch self {
        case .offline: return "您的网络开小差了, 请检查网络后重试~"
        case .serverError(let response, let error):
            return """
            response:  \(response?.debugDescription ?? "NaN")
            error: \(error?.localizedDescription ?? "NaN")
            """
        case .serializeError(let response, let error):
            return """
            response:  \(response?.debugDescription ?? "NaN")
            error: \(error?.localizedDescription ?? "NaN")
            """
        case .nocontent: return ""
        case .invalidStatusCode: return ""
        }
    }
}

// MARK: - 👀
extension Error {
    func toApiError() -> ApiError {
        let nsError = self as NSError
        switch nsError.code {
        case NSURLErrorUnknown: return .serverError(response: nil, error: NSError(domain: "无效的URL地址", code: NSURLErrorUnknown, userInfo: nil))
        case NSURLErrorCancelled: return .serverError(response: nil, error: NSError(domain: "无效的网络地址", code: NSURLErrorCancelled, userInfo: nil))
        case NSURLErrorBadURL: return .serverError(response: nil, error: NSError(domain: "无效的网络地址", code: NSURLErrorBadURL, userInfo: nil))
        case NSURLErrorTimedOut: return .serverError(response: nil, error: NSError(domain: "网络不给力，请稍后再试", code: NSURLErrorTimedOut, userInfo: nil))
        case NSURLErrorUnsupportedURL: return .serverError(response: nil, error: NSError(domain: "不支持的网络地址", code: NSURLErrorUnsupportedURL, userInfo: nil))
        case NSURLErrorCannotFindHost: return .serverError(response: nil, error: NSError(domain: "找不到服务器", code: NSURLErrorCannotFindHost, userInfo: nil))
        case NSURLErrorCannotConnectToHost: return .serverError(response: nil, error: NSError(domain: "连接不上服务器", code: NSURLErrorCannotConnectToHost, userInfo: nil))
        case NSURLErrorNetworkConnectionLost: return .serverError(response: nil, error: NSError(domain: "网络连接异常", code: NSURLErrorNetworkConnectionLost, userInfo: nil))
        case NSURLErrorDNSLookupFailed: return .serverError(response: nil, error: NSError(domain: "DNS查询失败", code: NSURLErrorDNSLookupFailed, userInfo: nil))
        case NSURLErrorHTTPTooManyRedirects: return .serverError(response: nil, error: NSError(domain: "HTTP请求重定向", code: NSURLErrorHTTPTooManyRedirects, userInfo: nil))
        case NSURLErrorResourceUnavailable: return .serverError(response: nil, error: NSError(domain: "资源不可用", code: NSURLErrorResourceUnavailable, userInfo: nil))
            /// 无网络，请检查网络连接
        case NSURLErrorNotConnectedToInternet: return .offline
        case NSURLErrorRedirectToNonExistentLocation: return .serverError(response: nil, error: NSError(domain: "重定向到不存在的位置", code: NSURLErrorRedirectToNonExistentLocation, userInfo: nil))
        case NSURLErrorBadServerResponse: return .serverError(response: nil, error: NSError(domain: "服务器响应异常", code: NSURLErrorBadServerResponse, userInfo: nil))
        case NSURLErrorUserCancelledAuthentication: return .serverError(response: nil, error: NSError(domain: "用户取消授权", code: NSURLErrorUserCancelledAuthentication, userInfo: nil))
        case NSURLErrorUserAuthenticationRequired: return .serverError(response: nil, error: NSError(domain: "需要用户授权", code: NSURLErrorUserAuthenticationRequired, userInfo: nil))
        case NSURLErrorZeroByteResource: return .serverError(response: nil, error: NSError(domain: "零字节资源", code: NSURLErrorZeroByteResource, userInfo: nil))
        case NSURLErrorCannotDecodeRawData: return .serializeError(response: nil, error: NSError(domain: "无法解码原始数据", code: NSURLErrorCannotDecodeRawData, userInfo: nil))
        case NSURLErrorCannotDecodeContentData: return .serializeError(response: nil, error: NSError(domain: "无法解码内容数据", code: NSURLErrorCannotDecodeContentData, userInfo: nil))
        case NSURLErrorCannotParseResponse: return .serializeError(response: nil, error: NSError(domain: "无法解析响应", code: NSURLErrorCannotParseResponse, userInfo: nil))
        /// API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0))
        case NSURLErrorAppTransportSecurityRequiresSecureConnection: return .serverError(response: nil, error: NSError(domain: "", code: NSURLErrorAppTransportSecurityRequiresSecureConnection, userInfo: nil))
        case NSURLErrorFileDoesNotExist: return .serverError(response: nil, error: NSError(domain: "文件不存在", code: NSURLErrorFileDoesNotExist, userInfo: nil))
        case NSURLErrorFileIsDirectory: return .serverError(response: nil, error: NSError(domain: "文件是个目录", code: NSURLErrorFileIsDirectory, userInfo: nil))
        case NSURLErrorNoPermissionsToReadFile: return .serverError(response: nil, error: NSError(domain: "无读取文件权限", code: NSURLErrorNoPermissionsToReadFile, userInfo: nil))
        /// API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
        case NSURLErrorDataLengthExceedsMaximum: return .serverError(response: nil, error: NSError(domain: "请求数据长度超出最大限度", code: NSURLErrorDataLengthExceedsMaximum, userInfo: nil))
        /// API_AVAILABLE(macos(10.12.4), ios(10.3), watchos(3.2), tvos(10.2))
        //            RxErrorModel(with: NSURLErrorFileOutsideSafeArea, msg: "", rxError: return .unReachable, emptyType: return .server),

        // SSL errors
        case NSURLErrorSecureConnectionFailed: return .serverError(response: nil, error: NSError(domain: "安全连接失败", code: NSURLErrorSecureConnectionFailed, userInfo: nil))
        case NSURLErrorServerCertificateHasBadDate: return .serverError(response: nil, error: NSError(domain: "服务器证书失效", code: NSURLErrorServerCertificateHasBadDate, userInfo: nil))
        case NSURLErrorServerCertificateUntrusted: return .serverError(response: nil, error: NSError(domain: "不被信任的服务器证书", code: NSURLErrorServerCertificateUntrusted, userInfo: nil))
        case NSURLErrorServerCertificateHasUnknownRoot: return .serverError(response: nil, error: NSError(domain: "未知Root的服务器证书", code: NSURLErrorServerCertificateHasUnknownRoot, userInfo: nil))
        case NSURLErrorServerCertificateNotYetValid: return .serverError(response: nil, error: NSError(domain: "服务器证书未生效", code: NSURLErrorServerCertificateNotYetValid, userInfo: nil))
        case NSURLErrorClientCertificateRejected: return .serverError(response: nil, error: NSError(domain: "客户端证书被拒", code: NSURLErrorClientCertificateRejected, userInfo: nil))
        case NSURLErrorClientCertificateRequired: return .serverError(response: nil, error: NSError(domain: "需要客户端证书", code: NSURLErrorClientCertificateRequired, userInfo: nil))
        case NSURLErrorCannotLoadFromNetwork: return .serverError(response: nil, error: NSError(domain: "无法从网络获取", code: NSURLErrorCannotLoadFromNetwork, userInfo: nil))

        // Download and file I/O errors
        case NSURLErrorCannotCreateFile: return .serverError(response: nil, error: NSError(domain: "无法创建文件", code: NSURLErrorCannotCreateFile, userInfo: nil))
        case NSURLErrorCannotOpenFile: return .serverError(response: nil, error: NSError(domain: "无法打开文件", code: NSURLErrorCannotOpenFile, userInfo: nil))
        case NSURLErrorCannotCloseFile: return .serializeError(response: nil, error: NSError(domain: "无法关闭文件", code: NSURLErrorCannotCloseFile, userInfo: nil))
        case NSURLErrorCannotWriteToFile: return .serializeError(response: nil, error: NSError(domain: "无法写入文件", code: NSURLErrorCannotWriteToFile, userInfo: nil))
        case NSURLErrorCannotRemoveFile: return .serverError(response: nil, error: NSError(domain: "无法删除文件", code: NSURLErrorCannotRemoveFile, userInfo: nil))
        case NSURLErrorCannotMoveFile: return .serverError(response: nil, error: NSError(domain: "无法移动文件", code: NSURLErrorCannotMoveFile, userInfo: nil))
        case NSURLErrorDownloadDecodingFailedMidStream: return .serverError(response: nil, error: NSError(domain: "下载解码数据失败", code: NSURLErrorDownloadDecodingFailedMidStream, userInfo: nil))
        case NSURLErrorDownloadDecodingFailedToComplete: return .serverError(response: nil, error: NSError(domain: "下载解码数据失败", code: NSURLErrorDownloadDecodingFailedToComplete, userInfo: nil))

        /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
        case NSURLErrorInternationalRoamingOff: return .serverError(response: nil, error: NSError(domain: "国际漫游关闭", code: NSURLErrorInternationalRoamingOff, userInfo: nil))
        /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
        case NSURLErrorCallIsActive: return .serverError(response: nil, error: NSError(domain: "被叫激活", code: NSURLErrorCallIsActive, userInfo: nil))
        /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
        case NSURLErrorDataNotAllowed: return .serverError(response: nil, error: NSError(domain: "数据不被允许", code: NSURLErrorDataNotAllowed, userInfo: nil))
        /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
        case NSURLErrorRequestBodyStreamExhausted: return .serverError(response: nil, error: NSError(domain: "请求体", code: NSURLErrorRequestBodyStreamExhausted, userInfo: nil))

        /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
        case NSURLErrorBackgroundSessionRequiresSharedContainer: return .serverError(response: nil, error: NSError(domain: "", code: NSURLErrorBackgroundSessionRequiresSharedContainer, userInfo: nil))
        /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
        case NSURLErrorBackgroundSessionInUseByAnotherProcess: return .serverError(response: nil, error: NSError(domain: "", code: NSURLErrorBackgroundSessionInUseByAnotherProcess, userInfo: nil))
        /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
        case NSURLErrorBackgroundSessionWasDisconnected: return .serverError(response: nil, error: NSError(domain: "", code: NSURLErrorBackgroundSessionWasDisconnected, userInfo: nil))
        default:
            return .serverError(response: nil, error: self)
        }
    }
}

// MARK: - 👀
extension Moya.MoyaError {
    func toApiError() -> ApiError {
        switch self {
        case .imageMapping(let response),
             .jsonMapping(let response),
             .stringMapping(let response):
            return .serializeError(response: response, error: nil)
        case .objectMapping(_, let response):
            return .serializeError(response: response, error: nil)
        case .encodableMapping(let error):
            return .serializeError(response: nil, error: error)
        case .statusCode(let response):
            return .serverError(response: response, error: nil)
        case .underlying(let error, _):
            return error.toApiError()
        case .requestMapping(let string):
            return .serializeError(response: nil, error: NSError(domain: string, code: 999, userInfo: nil))
        case .parameterEncoding(let error):
            return .serializeError(response: nil, error: error)
        }
    }
}

public enum RxMoyaError: Error {
    case unknown
    case error(error: Error)
    case invalidHTTPCode(code: Int)
    case unReachable
//    case codeInvalid(code: Int?, data: HandyJSON?, tips: String?, msg: String?)
    case codeInvalid(code: Int?, base: BaseModel)
    case invalidJSON
    case noData
    case success
    case timeout
    case cancelled
}

public enum LXEmptyType: Int {
    case success
    case timeout
    case server
    case notLogin
    case noData
    case unReachability
}

// MARK: - 👀
extension Error {
//    var toRxMoyaError: RxMoyaError {
//        let model = RxErrorModel.getList.first { $0.type == (self as NSError).code }
//        return model?.rxError ?? .unknown
//    }
//    var toErrorMsg: String {
//        let model = RxErrorModel.getList.first { $0.type == (self as NSError).code }
//        return model?.msg ?? ""
//    }
}

class RxErrorModel: NSObject, HandyJSON {
    var type: Int
    var msg: String
    var rxError: RxMoyaError
    var apiError: ApiError
    var emptyType: LXEmptyType
    required override init() {
        self.type = 123321
        self.msg = ""
        self.rxError = .success
        self.emptyType = .success
        self.apiError = .nocontent
    }
    convenience init(with type: Int, msg: String, rxError: RxMoyaError, apiError: ApiError, emptyType: LXEmptyType) {
        self.init()
        self.type = type
        self.msg = msg
        self.rxError = rxError
        self.apiError = apiError
        self.emptyType = emptyType
    }

    override var debugDescription: String { return toJSONString() ?? "" }
}
// MARK: - 👀Public Actions
extension RxErrorModel {
//    static var getList: [RxErrorModel] = {
//        return [
//            RxErrorModel(with: NSURLErrorUnknown, msg: "无效的URL地址", rxError: .unknown, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCancelled, msg: "无效的网络地址", rxError: .cancelled, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorBadURL, msg: "无效的网络地址", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorTimedOut, msg: "网络不给力，请稍后再试", rxError: .timeout, apiError: .serverError(response: nil), emptyType: .timeout),
//            RxErrorModel(with: NSURLErrorUnsupportedURL, msg: "不支持的网络地址", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotFindHost, msg: "找不到服务器", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotConnectToHost, msg: "连接不上服务器", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorNetworkConnectionLost, msg: "网络连接异常", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorDNSLookupFailed, msg: "DNS查询失败", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorHTTPTooManyRedirects, msg: "HTTP请求重定向", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorResourceUnavailable, msg: "资源不可用", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorNotConnectedToInternet, msg: "无网络，请检查网络连接", rxError: .unReachable, apiError: .offline, emptyType: .server),
//            RxErrorModel(with: NSURLErrorRedirectToNonExistentLocation, msg: "重定向到不存在的位置", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorBadServerResponse, msg: "服务器响应异常", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorUserCancelledAuthentication, msg: "用户取消授权", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorUserAuthenticationRequired, msg: "需要用户授权", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorZeroByteResource, msg: "零字节资源", rxError: .noData, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotDecodeRawData, msg: "无法解码原始数据", rxError: .noData, apiError: .serializeError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotDecodeContentData, msg: "无法解码内容数据", rxError: .noData, apiError: .serializeError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotParseResponse, msg: "无法解析响应", rxError: .invalidJSON, apiError: .serializeError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorAppTransportSecurityRequiresSecureConnection, msg: "", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorFileDoesNotExist, msg: "文件不存在", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorFileIsDirectory, msg: "文件是个目录", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorNoPermissionsToReadFile, msg: "无读取文件权限", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorDataLengthExceedsMaximum, msg: "请求数据长度超出最大限度", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.12.4), ios(10.3), watchos(3.2), tvos(10.2))
////            RxErrorModel(with: NSURLErrorFileOutsideSafeArea, msg: "", rxError: .unReachable, emptyType: .server),
//
//            // SSL errors
//            RxErrorModel(with: NSURLErrorSecureConnectionFailed, msg: "安全连接失败", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorServerCertificateHasBadDate, msg: "服务器证书失效", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorServerCertificateUntrusted, msg: "不被信任的服务器证书", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorServerCertificateHasUnknownRoot, msg: "未知Root的服务器证书", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorServerCertificateNotYetValid, msg: "服务器证书未生效", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorClientCertificateRejected, msg: "客户端证书被拒", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorClientCertificateRequired, msg: "需要客户端证书", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotLoadFromNetwork, msg: "无法从网络获取", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//
//            // Download and file I/O errors
//            RxErrorModel(with: NSURLErrorCannotCreateFile, msg: "无法创建文件", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotOpenFile, msg: "无法打开文件", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotCloseFile, msg: "无法关闭文件", rxError: .unReachable, apiError: .serializeError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotWriteToFile, msg: "无法写入文件", rxError: .unReachable, apiError: .serializeError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotRemoveFile, msg: "无法删除文件", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorCannotMoveFile, msg: "无法移动文件", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorDownloadDecodingFailedMidStream, msg: "下载解码数据失败", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            RxErrorModel(with: NSURLErrorDownloadDecodingFailedToComplete, msg: "下载解码数据失败", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorInternationalRoamingOff, msg: "国际漫游关闭", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorCallIsActive, msg: "被叫激活", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorDataNotAllowed, msg: "数据不被允许", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorRequestBodyStreamExhausted, msg: "请求体", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//
//            /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorBackgroundSessionRequiresSharedContainer, msg: "", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorBackgroundSessionInUseByAnotherProcess, msg: "", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//            /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
//            RxErrorModel(with: NSURLErrorBackgroundSessionWasDisconnected, msg: "", rxError: .unReachable, apiError: .serverError(response: nil), emptyType: .server),
//        ]
//    }()
}

// MARK: - 👀
//public extension Error {
//    var toRxMoyaError: RxMoyaError {
//        switch (self as NSError).code {
//            case NSURLErrorTimedOut: return .timeout
//            case NSURLErrorUnknown: return .unknown
//            case NSURLErrorCancelled: return .cancelled
//            case NSURLErrorZeroByteResource,
//                 NSURLErrorCannotDecodeRawData,
//                 NSURLErrorCannotDecodeContentData: return .noData
//            case NSURLErrorCannotParseResponse: return .invalidJSON
//            case NSURLErrorBadURL,
//                 NSURLErrorCannotFindHost,
//                 NSURLErrorCannotConnectToHost,
//                 NSURLErrorNotConnectedToInternet,
//                 NSURLErrorUnsupportedURL,
//                 NSURLErrorNetworkConnectionLost,
//                 NSURLErrorDNSLookupFailed,
//                 NSURLErrorHTTPTooManyRedirects,
//                 NSURLErrorResourceUnavailable,
//                 NSURLErrorRedirectToNonExistentLocation,
//                 NSURLErrorBadServerResponse,
//                 NSURLErrorUserCancelledAuthentication,
//                 NSURLErrorUserAuthenticationRequired,
//                 NSURLErrorAppTransportSecurityRequiresSecureConnection,
//                 NSURLErrorFileDoesNotExist,
//                 NSURLErrorFileIsDirectory,
//                 NSURLErrorNoPermissionsToReadFile,
//                 NSURLErrorDataLengthExceedsMaximum,
////                 NSURLErrorFileOutsideSafeArea,
//                 /// SSL errors
//                 NSURLErrorSecureConnectionFailed,
//                 NSURLErrorServerCertificateHasBadDate,
//                 NSURLErrorServerCertificateUntrusted,
//                 NSURLErrorServerCertificateHasUnknownRoot,
//                 NSURLErrorServerCertificateNotYetValid,
//                 NSURLErrorClientCertificateRejected,
//                 NSURLErrorClientCertificateRequired,
//                 NSURLErrorCannotLoadFromNetwork: return .unReachable
//            // Download and file I/O errors
//            case NSURLErrorCannotCreateFile,
//            NSURLErrorCannotOpenFile,
//            NSURLErrorCannotCloseFile,
//            NSURLErrorCannotWriteToFile,
//            NSURLErrorCannotRemoveFile,
//            NSURLErrorCannotMoveFile,
//            NSURLErrorDownloadDecodingFailedMidStream,
//            NSURLErrorDownloadDecodingFailedToComplete: return .unReachable
//
////            @available(iOS 3.0, *)
//            case NSURLErrorInternationalRoamingOff: return .unReachable
////            @available(iOS 3.0, *)
//            case NSURLErrorCallIsActive: return .unReachable
////            @available(iOS 3.0, *)
//            case NSURLErrorDataNotAllowed: return .unReachable
////            @available(iOS 3.0, *)
//            case NSURLErrorRequestBodyStreamExhausted:return .unReachable
//
////            @available(iOS 8.0, *)
//            case NSURLErrorBackgroundSessionRequiresSharedContainer: return .unReachable
////            @available(iOS 8.0, *)
//            case NSURLErrorBackgroundSessionInUseByAnotherProcess: return .unReachable
////            @available(iOS 8.0, *)
//            case NSURLErrorBackgroundSessionWasDisconnected: return .unReachable
//            default: return .unknown
//        }
//    }
//    var toErrorMsg: String {
//        var errorMesg: String = ""
//        switch (self as NSError).code {
//            case NSURLErrorUnknown:
//                errorMesg = "无效的URL地址"
//            case NSURLErrorCancelled:
//                errorMesg = "无效的网络地址"
//            case NSURLErrorBadURL:
//                errorMesg = "无效的网络地址"
//            case NSURLErrorTimedOut:
//                errorMesg = "网络不给力，请稍后再试"
//            case NSURLErrorUnsupportedURL:
//                errorMesg = "不支持的网络地址"
//            case NSURLErrorCannotFindHost:
//                errorMesg = "找不到服务器"
//            case NSURLErrorCannotConnectToHost:
//                errorMesg = "连接不上服务器"
//            case NSURLErrorNetworkConnectionLost:
//                errorMesg = "网络连接异常"
//            case NSURLErrorDNSLookupFailed:
//                errorMesg = "DNS查询失败"
//            case NSURLErrorHTTPTooManyRedirects:
//                errorMesg = "HTTP请求重定向"
//            case NSURLErrorResourceUnavailable:
//                errorMesg = "资源不可用"
//            case NSURLErrorNotConnectedToInternet:
//                errorMesg = "无网络，请检查网络连接"
//            case NSURLErrorRedirectToNonExistentLocation:
//                errorMesg = "重定向到不存在的位置"
//            case NSURLErrorBadServerResponse:
//                errorMesg = "服务器响应异常"
//            case NSURLErrorUserCancelledAuthentication:
//                errorMesg = "用户取消授权"
//            case NSURLErrorUserAuthenticationRequired:
//                errorMesg = "需要用户授权"
//            case NSURLErrorZeroByteResource:
//                errorMesg = "零字节资源"
//            case NSURLErrorCannotDecodeRawData:
//                errorMesg = "无法解码原始数据"
//            case NSURLErrorCannotDecodeContentData:
//                errorMesg = "无法解码内容数据"
//            case NSURLErrorCannotParseResponse:
//                errorMesg = "无法解析响应"
//            /// API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorAppTransportSecurityRequiresSecureConnection:
//                break
//            case NSURLErrorFileDoesNotExist:
//                errorMesg = "文件不存在"
//            case NSURLErrorFileIsDirectory:
//                errorMesg = "文件是个目录"
//            case NSURLErrorNoPermissionsToReadFile:
//                errorMesg = "无读取文件权限"
//            /// API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorDataLengthExceedsMaximum:
//                errorMesg = "请求数据长度超出最大限度"
//            /// API_AVAILABLE(macos(10.12.4), ios(10.3), watchos(3.2), tvos(10.2))
////            case NSURLErrorFileOutsideSafeArea:
////                break
//
//            // SSL errors
//            case NSURLErrorSecureConnectionFailed:
//                errorMesg = "安全连接失败"
//            case NSURLErrorServerCertificateHasBadDate:
//                errorMesg = "服务器证书失效"
//            case NSURLErrorServerCertificateUntrusted:
//                errorMesg = "不被信任的服务器证书"
//            case NSURLErrorServerCertificateHasUnknownRoot:
//                errorMesg = "未知Root的服务器证书"
//            case NSURLErrorServerCertificateNotYetValid:
//                errorMesg = "服务器证书未生效"
//            case NSURLErrorClientCertificateRejected:
//                errorMesg = "客户端证书被拒"
//            case NSURLErrorClientCertificateRequired:
//                errorMesg = "需要客户端证书"
//            case NSURLErrorCannotLoadFromNetwork:
//                errorMesg = "无法从网络获取"
//
//            // Download and file I/O errors
//            case NSURLErrorCannotCreateFile:
//                errorMesg = "无法创建文件"
//            case NSURLErrorCannotOpenFile:
//                errorMesg = "无法打开文件"
//            case NSURLErrorCannotCloseFile:
//                errorMesg = "无法关闭文件"
//            case NSURLErrorCannotWriteToFile:
//                errorMesg = "无法写入文件"
//            case NSURLErrorCannotRemoveFile:
//                errorMesg = "无法删除文件"
//            case NSURLErrorCannotMoveFile:
//                errorMesg = "无法移动文件"
//            case NSURLErrorDownloadDecodingFailedMidStream:
//                errorMesg = "下载解码数据失败"
//            case NSURLErrorDownloadDecodingFailedToComplete:
//                errorMesg = "下载解码数据失败"
//
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorInternationalRoamingOff:
//                errorMesg = "国际漫游关闭"
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorCallIsActive:
//                errorMesg = "被叫激活"
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorDataNotAllowed:
//                errorMesg = "数据不被允许"
//            /// API_AVAILABLE(macos(10.7), ios(3.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorRequestBodyStreamExhausted:
//                errorMesg = "请求体"
//
//            /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorBackgroundSessionRequiresSharedContainer:
//                break
//            /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorBackgroundSessionInUseByAnotherProcess:
//                break
//            /// API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0))
//            case NSURLErrorBackgroundSessionWasDisconnected:
//                break
//            default: break
//        }
//        return errorMesg
//    }
//}
