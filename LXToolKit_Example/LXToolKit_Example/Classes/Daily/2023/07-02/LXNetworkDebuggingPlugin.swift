//
//  LXNetworkDebuggingPlugin.swift
//  RxNetworks
//
//  Created by Condy on 2021/12/12.
//  https://github.com/yangKJ/RxNetworks

import Foundation
import Moya
import RxNetworks

/// 网络打印，DEBUG模式内置插件
/// Network printing, DEBUG mode built in plugin.
public struct LXNetworkDebuggingPlugin {//}: PluginPropertiesable {

    // public var plugins: APIPlugins = []
    // 
    // public let options: Options
    // 
    // public init(options: Options = .default) {
    //     self.options = options
    // }
}

// extension LXNetworkDebuggingPlugin {
//     public struct Options {
//         
//         public static let `default`: Options = .init(logOptions: .default)
//         
//         let logOptions: LogOptions
//         
//         public init(logOptions: LogOptions) {
//             self.logOptions = logOptions
//         }
//     }
//     
//     /// Enable print request information.
//     var openDebugRequest: Bool {
//         switch options.logOptions {
//         case .request, .`default`:
//             return true
//         default:
//             return false
//         }
//     }
//     /// Turn on printing the response result.
//     var openDebugResponse: Bool {
//         switch options.logOptions {
//         case .response, .`default`:
//             return true
//         default:
//             return false
//         }
//     }
// }

// extension LXNetworkDebuggingPlugin.Options {
//     public struct LogOptions: OptionSet {
//         public let rawValue: Int
//         public init(rawValue: Int) { self.rawValue = rawValue }
//         
//         /// Enable print request information.
//         public static let request: LogOptions = LogOptions(rawValue: 1 << 0)
//         /// Turn on printing the response result.
//         public static let response: LogOptions = LogOptions(rawValue: 1 << 1)
//         /// Open the request log and response log at the same time.
//         public static let `default`: LogOptions = [request, response]
//     }
// }

// extension LXNetworkDebuggingPlugin: PluginSubType {
//     
//     public var pluginName: String {
//         return "Debugging"
//     }
//     
//     public func configuration(_ request: HeadstreamRequest, target: TargetType) -> HeadstreamRequest {
//         #if DEBUG
//         printRequest(target, plugins: plugins)
//         if let result = request.result {
//             ansysisResult(target, result, local: true)
//         }
//         #endif
//         return request
//     }
//     
//     public func lastNever(_ result: LastNeverResult, target: TargetType, onNext: @escaping LastNeverCallback) {
//         #if DEBUG
//         if let map = result.mapResult {
//             switch map {
//             case .success(let json):
//                 printResponse(target, json, false, true)
//             case .failure(let error):
//                 printResponse(target, error.localizedDescription, false, false)
//             }
//         } else {
//             ansysisResult(target, result.result, local: false)
//         }
//         #endif
//         onNext(result)
//     }
// }

extension LXNetworkDebuggingPlugin: Moya.PluginType {
    // public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    // }
    public func willSend(_ request: RequestType, target: TargetType) {
        // if let result = request.request.re
        printRequest(target, plugins: [])
    }
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        ansysisResult(target, result, local: false)
    }
    // public func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
    // }
}

extension LXNetworkDebuggingPlugin {
    
    private func printRequest(_ target: TargetType, plugins: APIPlugins) {
        guard AppConfig.Network.loggingEnabled else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
        formatter.locale = Locale.current
        let date = formatter.string(from: Date())
        var parameters: APIParameters? = nil
        if case .requestParameters(let parame, _) = target.task {
            parameters = parame
        }
        if let param = parameters, param.isEmpty == false {
            Swift.print("""
                  ╔═══════════ 🎈 Request 🎈 ═══════════
                  ║ Time: \(date)
                  ║ URL: {{\(requestFullLink(with: target))}}
                  ║-------------------------------------
                  ║ Plugins: \(pluginString(plugins))
                  ╚═══════════════════════════════════════
                  """)
        } else {
            Swift.print("""
                  ╔═══════════ 🎈 Request 🎈 ═══════════
                  ║ Time: \(date) \(requestFullLink(with: target))
                  ║ URL: {{\(requestFullLink(with: target))}}
                  ║-------------------------------------
                  ║ Plugins: \(pluginString(plugins))
                  ╚═══════════════════════════════════════
                  """)
        }
    }
    
    private func pluginString(_ plugins: APIPlugins) -> String {
        return plugins.reduce("") { $0 + $1.pluginName + " " }
    }
    
    private func requestFullLink(with target: TargetType) -> String {
        var parameters: APIParameters? = nil
        if case .requestParameters(let parame, _) = target.task {
            parameters = parame
        }
        guard let parameters = parameters, !parameters.isEmpty else {
            return target.baseURL.absoluteString + target.path
        }
        // let sortedParameters = parameters.sorted(by: { $0.key > $1.key })
        // var paramString = "?"
        // for index in sortedParameters.indices {
        //     paramString.append("\(sortedParameters[index].key)=\(sortedParameters[index].value)")
        //     if index != sortedParameters.count - 1 { paramString.append("&") }
        // }
        return target.baseURL.absoluteString + target.path// + "\(paramString)"
    }
}

extension LXNetworkDebuggingPlugin {
    
    private func ansysisResult(_ target: TargetType, _ result: Result<Moya.Response, MoyaError>, local: Bool) {
        switch result {
        case let .success(response):
            do {
                let response = try response.filterSuccessfulStatusCodes()
                let json = try response.mapJSON()
                printResponse(target, json, local, true)
            } catch MoyaError.jsonMapping(let response) {
                let error = MoyaError.jsonMapping(response)
                printResponse(target, error.localizedDescription, local, false)
            } catch MoyaError.statusCode(let response) {
                let error = MoyaError.statusCode(response)
                printResponse(target, error.localizedDescription, local, false)
            } catch {
                printResponse(target, error.localizedDescription, local, false)
            }
        case let .failure(error):
            printResponse(target, error.localizedDescription, local, false)
        }
    }
    
    private func printResponse(_ target: TargetType, _ json: Any, _ local: Bool, _ success: Bool) {
        guard AppConfig.Network.loggingEnabled else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
        formatter.locale = Locale.current
        let date = formatter.string(from: Date())
        var parameters: APIParameters? = nil
        if case .requestParameters(let parame, _) = target.task {
            parameters = parame
        }
        if let param = parameters, param.isEmpty == false {
            Swift.print("""
                  ╔═══════════ 🎈 Request 🎈 ═══════════
                  ║ Time: \(date)
                  ║ URL: {{\(requestFullLink(with: target))}}
                  ║-------------------------------------
                  ║ Method: \(target.method.rawValue)
                  ║ Host: \(target.baseURL.absoluteString)
                  ║ Path: \(target.path)
                  ║ Parameters: \(param)
                  ║ BaseParameters: \(NetworkConfig.baseParameters)
                  ║---------- 🎈 Response 🎈 ----------
                  ║ Result: \(success ? "Successed." : "Failed.")
                  ║ DataType: \(local ? "Local data." : "Remote data.")
                  ║ Response: \(json)
                  ╚═══════════════════════════════════════
                  """)
        } else {
            Swift.print("""
                  ╔═══════════ 🎈 Request 🎈 ═══════════
                  ║ Time: \(date)
                  ║ URL: {{\(requestFullLink(with: target))}}
                  ║-------------------------------------
                  ║ Method: \(target.method.rawValue)
                  ║ Host: \(target.baseURL.absoluteString)
                  ║ Path: \(target.path)
                  ║ BaseParameters: \(NetworkConfig.baseParameters)
                  ║---------- 🎈 Response 🎈 ----------
                  ║ Result: \(success ? "Successed." : "Failed.")
                  ║ DataType: \(local ? "Local data." : "Remote data.")
                  ║ Response: \(json)
                  ╚═══════════════════════════════════════
                  """)
        }
    }
}
