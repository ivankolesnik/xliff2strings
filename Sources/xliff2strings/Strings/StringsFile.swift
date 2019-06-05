//
//  Strings.swift
//  xliff2strings
//
//  Created by ivankolesnik on 03/06/2019.
//

import Foundation

struct StringsFile: StringsWritable {
    private let translations: [Translation]
    private let fileUrl: URL
    
    init(fileOrigin: FileOrigin, saveFolder: URL) {
        self.translations = fileOrigin.translations
        self.fileUrl = saveFolder
            .appendingPathComponent(fileOrigin.filePath, isDirectory: false)
            .resolvingSymlinksInPath()
    }
    
    func encodeAndSave() throws {
        let file = try createFileHandle(forSafeWritingTo: fileUrl)
        defer { file.closeFile() }

        for translation in translations {
            // writing strings file
            let comment = "/* \(translation.safeNote) */\n".data(using: .utf8)!
            let translation = "\"\(translation.id)\" = \"\(translation.safeTarget)\";\n\n".data(using: .utf8)!
            
            file.write(comment)
            file.write(translation)
        }
    }
}
