//
//  Utils.swift
//  xliff2strings
//
//  Created by ivankolesnik on 04/06/2019.
//

import Foundation

struct CodingUnknownKeys: CodingKey {
    var intValue: Int?
    var stringValue: String
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }
    
    static func make(_ key: Int) -> CodingUnknownKeys {
        return CodingUnknownKeys(intValue: key)!
    }
    
    static func make(_ key: String) -> CodingUnknownKeys {
        return CodingUnknownKeys(stringValue: key)!
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        guard index >= startIndex, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

func createFileHandle(forSafeWritingTo url: URL) throws -> FileHandle {
    try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    if !FileManager.default.createFile(atPath: url.path, contents: nil) {
        throw FileError.createFail
    }
    
    return try FileHandle(forWritingTo: url)
}

// SPM v4.2 does not support target OS and defaults to 10.10 SDK
// make a helper to resolve relative URL on 10.10
func createFileUrl(for path: String, isDirectory: Bool, relativeTo url: URL? = nil) -> URL {
    if #available(OSX 10.11, iOS 9.0, *) {
        return URL(fileURLWithPath: path, isDirectory: isDirectory, relativeTo: url)
    } else {
        let strPath: String = url?.appendingPathComponent(path, isDirectory: isDirectory).path ?? path
        
        var url = URL(fileURLWithPath: strPath, isDirectory: isDirectory)
        url.resolveSymlinksInPath()
        return url
    }
}

// merge two optional dictionaries
// does not do deep merge
// prefers values from second dictionary
func mergeDicts<K, E>(base: [K: E]?, with: [K: E]?) -> [K: E] {
    switch (base, with) {
    case (.some(let b), .some(let w)):
        return b.merging(w, uniquingKeysWith: { $1 })
    case (.some(let b), .none):
        return b
    case (.none, .some(let w)):
        return w
    default:
        return [K:E]()
    }
}
