//
//  TranslationWritable.swift
//  xliff2strings
//
//  Created by ivankolesnik on 03/06/2019.
//

import Foundation

protocol StringsWritable {
    init(fileOrigin: FileOrigin, saveFolder: URL)
    
    func encodeAndSave() throws
}
