import Foundation
import SwiftCLI

let cli = CLI(singleCommand: XliffToStrings())
cli.helpCommand = nil // no options, no help needed
cli.helpFlag = nil

//let cli = CLI(name: "xliff2strings",
//              version: "0.1",
//              description: "A command line tool to generate .strings and .stringdict files from .xliff file",
//              commands: [XliffToStrings()])

//exit(cli.go(with: ["-h"]))
cli.goAndExit()
