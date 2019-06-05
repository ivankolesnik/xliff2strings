//
//  XLIFF.swift
//  xliff2strings
//
//  Created by ivankolesnik on 29/05/2019.
//

import Foundation
import XMLCoder

struct Xliff: Decodable {
    enum CodingKeys: String, CodingKey {
        case files = "file"
    }
    
    let files: [FileOrigin]
    
    func getStringFiles(outFolder out: URL) -> [StringsWritable] {
        return files.map({ file -> StringsWritable in
            // check if file is .strings or .stringsdict
            return file.isStringsDict
                ? StringsDictFile(fileOrigin: file, saveFolder: out)
                : StringsFile(fileOrigin: file, saveFolder: out)
        })
    }
}
