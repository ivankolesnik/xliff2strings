//
//  Translation.swift
//  xliff2strings
//
//  Created by ivankolesnik on 31/05/2019.
//

import Foundation

struct Translation: Decodable {
    let id: String
    let source: String
    let target: String?
    let note: String?
    
    var safeTarget: String {
        // WORKAROUND: for en target can be empty, use source
        return target ?? source
    }
    
    var safeNote: String {
        // WORKAROUND: if note does not exist, use source as comment
        return note ?? source
    }
}
