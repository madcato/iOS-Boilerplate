//
//  String+hash.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 17/6/21.
//  Copyright © 2021 veladan. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import var CommonCrypto.CC_SHA1_DIGEST_LENGTH
import func CommonCrypto.CC_SHA1
import var CommonCrypto.CC_SHA256_DIGEST_LENGTH
import func CommonCrypto.CC_SHA256
import typealias CommonCrypto.CC_LONG

extension String { // swiftlint:disable:this extension_access_modifier
    /// Calculate the md5 hash of this string
    public func md5() -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = data(using: .utf8)! // swiftlint:disable:this force_unwrapping
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                   let digestBytesBlindMemory =
                        digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress,
                           messageLength,
                           digestBytesBlindMemory)
                }
                return 0
            }
        }

        let md5Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }

    /// Calculate the sha1 hash of this string
    public func sha1() -> String {
        let length = Int(CC_SHA1_DIGEST_LENGTH)
        let messageData = data(using: .utf8)! // swiftlint:disable:this force_unwrapping
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                   let digestBytesBlindMemory =
                        digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_SHA1(messageBytesBaseAddress,
                            messageLength,
                            digestBytesBlindMemory)
                }
                return 0
            }
        }

        let sha1Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
        return sha1Hex
    }

    /// Calculate the sha256 hash of this string
    public func sha256() -> String {
        let length = Int(CC_SHA256_DIGEST_LENGTH)
        let messageData = data(using: .utf8)! // swiftlint:disable:this force_unwrapping
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                   let digestBytesBlindMemory =
                        digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_SHA256(messageBytesBaseAddress,
                              messageLength,
                              digestBytesBlindMemory)
                }
                return 0
            }
        }

        let sha256Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
        return sha256Hex
    }
}
