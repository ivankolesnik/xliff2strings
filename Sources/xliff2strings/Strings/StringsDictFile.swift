//
//  StringsDict.swift
//  xliff2strings
//
//  Created by ivankolesnik on 03/06/2019.
//

import Foundation

struct StringsDictFile: StringsWritable {
    private let translations: [Translation]
    private let fileUrl: URL
    
    init(fileOrigin: FileOrigin, saveFolder: URL) {
        self.translations = fileOrigin.translations
        self.fileUrl = saveFolder
            .appendingPathComponent(fileOrigin.filePath, isDirectory: false)
            .resolvingSymlinksInPath()
    }
    
    func encodeAndSave() throws {
        // stringsdict file is a plist
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        let groupedPlurals = Plurals(with: translations)
        let data = try encoder.encode(groupedPlurals)
        
        let file = try createFileHandle(forSafeWritingTo: fileUrl)
        defer { file.closeFile() }
        
        file.write(data)
    }
}
