//
//  Errors.swift
//  xliff2strings
//
//  Created by ivankolesnik on 03/06/2019.
//

import Foundation

enum FileError: Error, LocalizedError, CustomDebugStringConvertible {
    case notExists
    case createFail
    
    var errorDescription: String? {
        switch self {
        case .notExists:
            return "File/folder does not exist"
        case .createFail:
            return "Failed to create file/folder"
        }
    }
    
    var debugDescription: String {
        return errorDescription ?? "Unknown error happened"
    }
}
