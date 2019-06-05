//
//  Xliff2Strings.swift
//  xliff2strings
//
//  Created by ivankolesnik on 31/05/2019.
//

import Foundation
import SwiftCLI
import XMLCoder


private let folderValidation = Validation<String>.custom("Expected a folder path!") { (folder: String) -> Bool in
    var isDirectory: ObjCBool = false
    let exists = FileManager.default.fileExists(atPath: folder, isDirectory: &isDirectory)
    return exists && isDirectory.boolValue
}

private let fileValidation = Validation<String>.custom("Expected a .xliff file!") { (file: String) -> Bool in
    var isDirectory: ObjCBool = false
    let exists = FileManager.default.fileExists(atPath: file, isDirectory: &isDirectory)
    return exists && !isDirectory.boolValue
}

final class XliffToStrings: Command {
    let name = "xliff2strings"
    let shortDescription = "A command line tool to generate .strings and .stringdict files from .xliff file"
    
    let inFile = Parameter(completion: .filename, validation: [fileValidation])
    let outFolder = Parameter(completion: .filename, validation: [folderValidation])
    
//    let inFile = Key<String>("-i", "--in", description: "input .xliff file to process", validation: [fileValidation])
//    let outFolder = Key<String>("-o", "--out", description: "output directory", validation: [folderValidation])
    
    func execute() throws {
        let workingDir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
        
//        guard let data = inFile.value.flatMap(FileManager.default.contents(atPath:)) else {
        guard let data = FileManager.default.contents(atPath: inFile.value) else {
            throw FileError.notExists
        }
        let out = createFileUrl(for: outFolder.value, isDirectory: true, relativeTo: workingDir)
                
        let decoder = XMLDecoder()
        decoder.trimValueWhitespaces = false
        let xliff = try decoder.decode(Xliff.self, from: data)
        
        let strings = xliff.getStringFiles(outFolder: out)
        for st in strings {
            try st.encodeAndSave()
        }
    }
}
