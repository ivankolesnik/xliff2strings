//
//  PluralElement.swift
//  xliff2strings
//
//  Created by V1tol on 05/06/2019.
//

import Foundation

// proxy element that parses plural key and key path
struct PluralElement {
    let key: String
    let path: [String]
    let translation: Translation
    
    init?(from translation: Translation) {
        let tokens = translation.id.split(separator: "/")
        // /plural_days_ago:dict/NSStringLocalizedFormatKey:dict/:string
        if tokens.count < 3 {
            print("ID has less than 3 tokens: \(translation.id)")
            return nil
        }
        
        var keys = tokens.compactMap({ token -> String? in
            // get last index because colon can be present in the key
            guard let sep = token.lastIndex(of: ":") else {
                print("Cannot split token: \(token)")
                return nil
            }
            
            return String(token.prefix(upTo: sep))
        }).dropLast() // dropping last element since it is useless for us
        
        self.key = keys.removeFirst()
        self.path = Array(keys)
        self.translation = translation
    }
}
