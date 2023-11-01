//
//  ImageURLProtocol.swift
//  DJTest
//
//  Created by lxthyme on 2023/10/24.
//

import Foundation

class ImageURLProtocol: URLProtocol {
    var cancelledOrComplete: Bool = false
    var block: DispatchWorkItem!

    private static let queue = DispatchSerialQueue(label: "com.apple.imageLoaderURLProtocol")

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }

    final override func startLoading() {
        guard let reqURL = request.url,
        let urlClient = client else {
            return
        }

        block = DispatchWorkItem(block: {
            if self.cancelledOrComplete == false {
                let fileURL = if #available(iOS 16.0, *) {
                    URL(filePath: reqURL.path)
                } else {
                    // Fallback on earlier versions
                    URL(fileURLWithPath: reqURL.path, isDirectory: false)
                }

                if let data = try? Data(contentsOf: fileURL) {
                    urlClient.urlProtocol(self, didLoad: data)
                    urlClient.urlProtocolDidFinishLoading(self)
                }
            }
            self.cancelledOrComplete = true
        })
        ImageURLProtocol.queue.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 500 * NSEC_PER_MSEC), execute: block)
    }

    override func stopLoading() {
        ImageURLProtocol.queue.async {
            if self.cancelledOrComplete == false,
               let cancelBLock = self.block {
                cancelBLock.cancel()

                self.cancelledOrComplete = true
            }
        }
    }

    static func urlSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [ImageURLProtocol.classForCoder()]

        return URLSession(configuration: config)
    }
}

