//
//  URLSessionSample.swift
//  Vaffle_demo
//
//  Created by DamonJow on 2018/10/30.
//  Copyright © 2018 DamonJow. All rights reserved.
//

import UIKit

class URLSessionSample: NSObject {
    lazy var session: URLSession = {

        /**
         一般模式（default）: 工作模式类似于原来的NSURLConnection，可以使用缓存的Cache，Cookie，鉴权。
         及时模式（ephemeral）: 不使用缓存的Cache，Cookie，鉴权。
         后台模式（background）: 在后台完成上传下载，创建Configuration对象的时候需要给一个NSString的ID用于追踪完成工作的Session是哪一个。
         */
        let config = URLSessionConfiguration.default
//        let config2 = URLSessionConfiguration.background(withIdentifier: "Identifier")
        let session_t = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        return session_t
    }()
    lazy var data = {
        return Data()
    }()
    lazy var locationURL: URL = {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let url = URL(string: documentPath)
        return url!
    }()
    let fileManager = FileManager.default
}

// MARK: - URLSessionDelegate[3] - 会话总代理
extension URLSessionSample: URLSessionDelegate {
    /// session.invalidateAndCancel或者session.finishTasksAndInvalidate
    /// session被关闭时调用、持有的delegate将被清空
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) { }
    /*
     参考：
     https://www.jianshu.com/p/2642e31919e7
     https://www.2cto.com/kf/201604/504149.html
     https://blog.csdn.net/jingcheng345413/article/details/65437649
     NSURLAuthenticationChallenge 类中最重要的一个属性是protectionSpace。
     该属性是一个 NSURLProtectionSpace 的实例，一个NSURLProtectionSpace对象通过属性host、isProxy、port、protocol、proxyType和realm代表了请求验证的服务器端的范围。
     而NSURLProtectionSpace类的authenticationMethod属性则指明了服务端的验证方式，可能的值包括:

     challenge.protectionSpace {
     // 默认
     NSURLAuthenticationMethodDefault
     // 基本的 HTTP 验证，通过 NSURLCredential 对象提供用户名和密码。
     NSURLAuthenticationMethodHTTPBasic
     // 类似于基本的 HTTP 验证，摘要会自动生成，同样通过 NSURLCredential 对象提供用户名和密码。
     NSURLAuthenticationMethodHTTPDigest
     // 不会用于 URL Loading System，在通过 web 表单验证时可能用到。
     NSURLAuthenticationMethodHTMLForm

     <<<<<***************>>>>>
     //Negotiate(协商，Kerberos or NTLM)
     NSURLAuthenticationMethodNegotiate
     //NTLM(WindowsNT使用的认证方式)
     NSURLAuthenticationMethodNTLM
     // 验证客户端的证书
     NSURLAuthenticationMethodClientCertificate
     // 指明客户端要验证服务端提供的证书
     NSURLAuthenticationMethodServerTrust
     }

     其中后四个为会话级别验证
     将会优先调用会话级别验证、如果未实现再调用任务界别验证。

     URLSession.AuthChallengeDisposition {
         // 指明通过另一个参数 credential 提供证书
         NSURLSessionAuthChallengeUseCredential
         // 相当于未执行代理方法，使用默认的处理方式，不使用参数 credential
         NSURLSessionAuthChallengePerformDefaultHandling
         // 拒绝该 protectionSpace 的验证，不使用参数 credential
         NSURLSessionAuthChallengeRejectProtectionSpace
         // 取消验证，不使用参数 credential
         NSURLSessionAuthChallengeCancelAuthenticationChallenge
     }


     当 disposition 的值为 NSURLSessionAuthChallengeUseCredential时，需要提供一个 NSURLCredential 对象。可以创建3种类型的 Credential：

     ```objc
     // 当 protectionSpace 的 authenticationMethod 的值为 NSURLAuthenticationMethodHTTPBasic 或 NSURLAuthenticationMethodHTTPDigest 时
     + credentialWithUser:password:persistence:
     - initWithUser:password:persistence:
     // 当 protectionSpace 的 authenticationMethod 的值为 NSURLAuthenticationMethodClientCertificate 时
     + credentialWithIdentity:certificates:persistence:
     - initWithIdentity:certificates:persistence:
     // 当 protectionSpace 的 authenticationMethod 的值为 NSURLAuthenticationMethodServerTrust 时
     + credentialForTrust:
     - initWithTrust:
     ```
     */
    /// 在访问资源的时候，如果服务器返回需要授权(提供一个URLCredential对象), 那么该方法就会被调用
    /// 询问>>服务器客户端配合验证--会话级别
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            /// 服务端证书认证
            let serverTrust: SecTrust = challenge.protectionSpace.serverTrust!
            let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0)!
            let remoteCertificateData = CFBridgingRetain(SecCertificateCopyData(certificate))!
            let cerPath = Bundle.main.path(forResource: "tomact", ofType: "cer")!
            let cerUrl = URL(fileURLWithPath: cerPath)
            let localCertificateData = try! Data(contentsOf: cerUrl)

            if remoteCertificateData.isEqual(localCertificateData) {
                let credential = URLCredential(trust: serverTrust)
                challenge.sender?.use(credential, for: challenge)
                completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            } else {
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        } else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodClientCertificate {
            /// 客户端认证
            let identityAndTrust: IdentityAndTrust = extractIdentity()

            let urlCredential = URLCredential(identity: identityAndTrust.identityRef, certificates: identityAndTrust.certArray as? [Any], persistence: URLCredential.Persistence.forSession)

            completionHandler(.useCredential, urlCredential)
        } else {
            // 其它情况（不接受认证）
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    /// 必须在backgroundSessionConfiguration 并且在后台完成时才会调用
    /// 通知>>所有后台下载任务全部完成
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) { }
}


// MARK: - URLSessionTaskDelegate[8] - 任务总代理
extension URLSessionSample: URLSessionTaskDelegate {
    /*
     当设置了earliestBeginDate属性
     (需要注意这个属性对于非后台任务并不有效、而且不能保证定时执行、只能保证不会在指定日期之前执行)
     的NSURLSessionTask被延迟调用的、会走这里
     */
    /// 通知>>延时任务被调用
    @available(iOS 11.0, *)
    func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest request: URLRequest, completionHandler: @escaping (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {
        completionHandler(.continueLoading, request)
    }
    /*
     如果NSURLSessionConfiguration的waitsForConnectivity属性为true
     并且由于网络不通(并不是并发受限)没有被立即发出时
     此方法最多只能在每个任务中调用一次、并且仅在连接最初不可用时调用。
     它永远不会被调用后台会话，因为这些会话会忽略waitsForConnectivity。

     */
    /// 通知>>网络受限导致任务进入等待
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) { }

    /// 准备开始请求、询问是否重定向
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(request)
    }

    /// 询问>>服务器需要客户端配合验证--任务级别
    /// 会话级别除非未实现对应代理、否则不会调用任务级别验证方法
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //        let credential = URLCredential(user: "user", password: "password", persistence: .none)
        //        completionHandler(.useCredential, credential)
    }

    /// 询问>>流任务的方式上传--需要客户端提供数据源
    /* 当任务需要新的请求主体流发送到远程服务器时，告诉委托。
     这种委托方法在两种情况下被调用：
     1、如果使用uploadTaskWithStreamedRequest创建任务，则提供初始请求正文流：
     2、如果任务因身份验证质询或其他可恢复的服务器错误需要重新发送包含正文流的请求，则提供替换请求正文流。
     注：如果代码使用文件URL或NSData对象提供请求主体，则不需要实现此功能。
     */
    func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) { }

    /// 通知>>上传进度
    /// 定期通知代理向服务器发送主体内容的进度
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) { }

    /*
     对发送请求/DNS查询/TLS握手/请求响应等各种环节时间上的统计. 更易于我们检测, 分析我们App的请求缓慢到底是发生在哪个环节, 并对此进行优化提升我们APP的性能.

     NSURLSessionTaskMetrics对象与NSURLSessionTask对象一一对应. 每个NSURLSessionTaskMetrics对象内有3个属性 :

     taskInterval : task从开始到结束总共用的时间
     redirectCount : task重定向的次数
     transactionMetrics : 一个task从发出请求到收到数据过程中派生出的每个子请求, 它是一个装着许多NSURLSessionTaskTransactionMetrics对象的数组. 每个对象都代表下图的一个子过程
     */
    /// 通知>>任务信息收集完成
    @available(iOS 10.0, *)
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        dlog("""
            ::::::::::::相关讯息::::::::::::
            总时间         : \(metrics.taskInterval)
            重定向次数   : \(metrics.redirectCount)
            派生的子请求: \(metrics.transactionMetrics.count)
            """)
    }

    /// 通知>>任务完成
    /// 请求成功、失败或者取消
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) { }
}

// MARK: - URLSessionDataDelegate[5] - 数据任务代理
extension URLSessionSample: URLSessionDataDelegate {

    /// 接收到服务器响应[仅一次]
    /// 通知>>服务器返回响应头
    /// 询问>>下一步操作
    /// 服务器返回响应头、询问下一步操作(取消操作、普通传输、下载、数据流传输)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        data = Data()
        //        completionHandler(.cancel)
        completionHandler(.allow)
        //        completionHandler(.becomeDownload)
        //        completionHandler(.becomeStream)
    }
    /// 通知>>数据任务更改为下载任务
    /// 可以通过上面的 completionHandler(.becomeDownload) 进行测试
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) { }

    /// 通知>>数据任务已更改为流任务
    /// 可以通过上面的 completionHandler(.becomeStream) 进行测试
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) { }

    /// 接受到服务器返回数据[多次]
    /// 通知>>服务器成功返回数据
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data)
    }
    /// 询问>>是否把Response存储到Cache中
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        let cachedURLResponse = CachedURLResponse(response: proposedResponse.response, data: proposedResponse.data, userInfo: nil, storagePolicy: .notAllowed)
        completionHandler(cachedURLResponse)
    }

}
extension URLSessionSample {
    struct IdentityAndTrust {
        var identityRef: SecIdentity
        var trust: SecTrust
        var certArray: AnyObject
    }

    /// 获取客户端证书相关信息
    func extractIdentity() ->IdentityAndTrust {
        var identityAndTrust: IdentityAndTrust!
        var securityError: OSStatus = errSecSuccess

        let path: String = Bundle.main.path(forResource: "myKey", ofType: "p12")!
        let PKCS12Data = NSData(contentsOfFile: path)!
        let key = kSecImportExportPassphrase
        /// 客户端证书密码
        let opts = [key: "123456"]

        var items: CFArray?
        securityError = SecPKCS12Import(PKCS12Data, opts as CFDictionary, &items)

        if securityError == errSecSuccess {
            let certItems: CFArray = items as CFArray!
            let certItemsArray = certItems as Array
            let dict = certItemsArray.first
            if let certEntry = dict as? [String: AnyObject] {
                let identityPointer = certEntry["identity"]
                let secIdentityRef = identityPointer as! SecIdentity
                dlog("\(String(describing: identityPointer))  :::: \(secIdentityRef)")

                let trustPointer = certEntry["trust"]
                let trustRef = trustPointer as! SecTrust
                dlog("\(String(describing: trustPointer))  :::: \(trustRef)")

                let chainPointer = certEntry["chain"]
                identityAndTrust = IdentityAndTrust(identityRef: secIdentityRef, trust: trustRef, certArray: chainPointer!)
            }
        }
        return identityAndTrust
    }
}

// MARK: - URLSessionDownloadDelegate[3] - 下载任务代理
extension URLSessionSample: URLSessionDownloadDelegate {

    /// 通知>>下载任务已经完成
    /// location 临时文件的位置
    /// locationURL 需要手动移动文件至需要保存的目录
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        try? fileManager.moveItem(at: location, to: self.locationURL)
    }


    /// 监听下载任务进度
    ///
    /// - Parameters:
    ///   - session:  session
    ///   - downloadTask: downloadTask
    ///   - bytesWritten: 已经下载的字节数
    ///   - totalBytesWritten: 总共字节数
    ///   - totalBytesExpectedToWrite: 剩余的字节数
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let written = CGFloat(bytesWritten)
        let total = CGFloat(totalBytesWritten)
        let expected = CGFloat(totalBytesExpectedToWrite)
        dlog(written, total, expected)
    }


    /*
     你可以通过 [session downloadTaskWithResumeData：resumeData]之类的方法来重新恢复一个下载任务
     resumeData在下载任务失败的时候会通过error.userInfo[NSURLSessionDownloadTaskResumeData]来返回以供保存
     */
    /// 从 fileOffset 处开始下载, 用于断点续传
    ///
    /// - Parameters:
    ///   - session: session
    ///   - downloadTask: downloadTask
    ///   - fileOffset: 已经下载的文件大小
    ///   - expectedTotalBytes: 预期总大小
    /// 通知>>下载任务已经恢复下载
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) { }

}

// MARK: - URLSessionStreamDelegate[3] - 流任务代理
extension URLSessionSample: URLSessionStreamDelegate {
    /// 通知>>数据流的连接中读数据的一边已经关闭
    func urlSession(_ session: URLSession, readClosedFor streamTask: URLSessionStreamTask) { }

    /// 通知>>数据流的连接中写数据的一边已经关闭
    func urlSession(_ session: URLSession, writeClosedFor streamTask: URLSessionStreamTask) { }

    /// 通知>>系统已经发现了一个更好的连接主机的路径
    func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) { }

    /// 通知>>流任务已完成
    func urlSession(_ session: URLSession, streamTask: URLSessionStreamTask, didBecome inputStream: InputStream, outputStream: OutputStream) { }
}
