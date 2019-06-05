//
//  Plurals.swift
//  xliff2strings
//
//  Created by V1tol on 05/06/2019.
//

import Foundation

struct Plurals: Encodable {
    let contents: [String: Plural]
    
    init(with translations: [Translation]) {
        let elements: [PluralElement] = translations.compactMap(PluralElement.init(from:))
        // group plural elements by plural key
        let grouped: [String: [PluralElement]] = Dictionary(grouping: elements, by: { $0.key })
        let plurals: [Plural] = grouped.compactMap({ Plural(key: $0.key, plurals: $0.value) })
        // grouping plurals by key
        self.contents = plurals.reduce(into: [:], { $0[$1.key] = $1 })
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingUnknownKeys.self)
        for (key, plural) in contents {
            // key is dynamic
            try container.encode(plural, forKey: .make(key))
        }
    }
}
