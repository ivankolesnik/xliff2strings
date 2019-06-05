//
//  Plural.swift
//  xliff2strings
//
//  Created by ivankolesnik on 04/06/2019.
//

import Foundation

struct Plural: Encodable {
    // using unknown keys since value key is dynamic
    private let formatKey: CodingUnknownKeys = .make("NSStringLocalizedFormatKey")
    private let valuesKey: CodingUnknownKeys
    
    let key: String
    let format: String
    private(set) var values: [String:String] = [
        // TODO: find a magic way to create this keys from xliff contents
        "NSStringFormatSpecTypeKey":"NSStringPluralRuleType",
        "NSStringFormatValueTypeKey":"d"
    ]
    private(set) var unknown: [String:String] = [:]
    
    init?(key: String, plurals: [PluralElement]) {
        var dictionaryKey = "VARIABLE"
        // NSStringLocalizedFormatKey value
        var formatValue = "%#@VARIABLE@"
        
        for plr in plurals {
            guard let top = plr.path[safe: 0] else {
                print("No path for plural: \(plr.key)")
                continue
            }
            
            switch top {
            case formatKey.stringValue:
                formatValue = plr.translation.safeTarget
            default:
                // assuming any unknown key as key for nested dict
                // nested values are not supported (if they exist at all)
                guard let nested = plr.path[safe: 1] else {
                    // some unknown key in stringsdict was present
                    print("Unknown values key: \(top)")
                    unknown[top] = plr.translation.safeTarget
                    continue
                }
                // this is a key for nested dictionary
                dictionaryKey = top
                self.values[nested] = plr.translation.safeTarget
            }
        }
        
        self.key = key
        self.format = formatValue
        self.valuesKey = .make(dictionaryKey)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingUnknownKeys.self)
        try container.encode(format, forKey: formatKey)
        try container.encode(values, forKey: valuesKey)
        // encode unknown found keys
        // usually no unknown snould be present
        for (key, value) in unknown {
            try container.encode(value, forKey: .make(key))
        }
    }
}
