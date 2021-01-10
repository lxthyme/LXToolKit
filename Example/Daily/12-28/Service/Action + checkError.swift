//
//  Action + checkError.swift
//  LXToolKit_Exam
//
//  Created by LXThyme Jason on 2020/12/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Action
import RxSwift
import LXToolKit

// MARK: - 👀
extension Action {
    var checkError: Observable<RxMoyaError> {
        return errors.map { error -> RxMoyaError in
            switch error {
                case .notEnabled: return .unknown
                case .underlyingError(let error):
                    return error.toRxMoyaError
            }
        }
    }
}

// MARK: - 👀
extension Error {
    var toRxMoyaError: RxMoyaError {
        switch (self as NSError).code {
            case NSURLErrorTimedOut: return .timeout
            case NSURLErrorUnknown: return .unknown
            case NSURLErrorCancelled: return .cancelled
            case NSURLErrorZeroByteResource,
                 NSURLErrorCannotDecodeRawData,
                 NSURLErrorCannotDecodeContentData: return .noData
            case NSURLErrorCannotParseResponse: return .invalidJSON
            case NSURLErrorBadURL,
                 NSURLErrorCannotFindHost,
                 NSURLErrorCannotConnectToHost,
                 NSURLErrorNotConnectedToInternet,
                 NSURLErrorUnsupportedURL,
                 NSURLErrorNetworkConnectionLost,
                 NSURLErrorDNSLookupFailed,
                 NSURLErrorHTTPTooManyRedirects,
                 NSURLErrorResourceUnavailable,
                 NSURLErrorRedirectToNonExistentLocation,
                 NSURLErrorBadServerResponse,
                 NSURLErrorUserCancelledAuthentication,
                 NSURLErrorUserAuthenticationRequired,
                 NSURLErrorAppTransportSecurityRequiresSecureConnection,
                 NSURLErrorFileDoesNotExist,
                 NSURLErrorFileIsDirectory,
                 NSURLErrorNoPermissionsToReadFile,
                 NSURLErrorDataLengthExceedsMaximum,
//                 NSURLErrorFileOutsideSafeArea,
                 /// SSL errors
                 NSURLErrorSecureConnectionFailed,
                 NSURLErrorServerCertificateHasBadDate,
                 NSURLErrorServerCertificateUntrusted,
                 NSURLErrorServerCertificateHasUnknownRoot,
                 NSURLErrorServerCertificateNotYetValid,
                 NSURLErrorClientCertificateRejected,
                 NSURLErrorClientCertificateRequired,
                 NSURLErrorCannotLoadFromNetwork: return .unReachable
            // Download and file I/O errors
            case NSURLErrorCannotCreateFile,
            NSURLErrorCannotOpenFile,
            NSURLErrorCannotCloseFile,
            NSURLErrorCannotWriteToFile,
            NSURLErrorCannotRemoveFile,
            NSURLErrorCannotMoveFile,
            NSURLErrorDownloadDecodingFailedMidStream,
            NSURLErrorDownloadDecodingFailedToComplete: return .unReachable

//            @available(iOS 3.0, *)
            case NSURLErrorInternationalRoamingOff: return .unReachable
//            @available(iOS 3.0, *)
            case NSURLErrorCallIsActive: return .unReachable
//            @available(iOS 3.0, *)
            case NSURLErrorDataNotAllowed: return .unReachable
//            @available(iOS 3.0, *)
            case NSURLErrorRequestBodyStreamExhausted:return .unReachable

//            @available(iOS 8.0, *)
            case NSURLErrorBackgroundSessionRequiresSharedContainer: return .unReachable
//            @available(iOS 8.0, *)
            case NSURLErrorBackgroundSessionInUseByAnotherProcess: return .unReachable
//            @available(iOS 8.0, *)
            case NSURLErrorBackgroundSessionWasDisconnected: return .unReachable
            default: return .unknown
        }
    }
}
