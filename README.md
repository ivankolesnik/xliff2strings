# xliff2strings

A command line tool to generate .strings and .stringdict files from .xliff file

### Prerequisites

You exported localizations from XCode, used 3rd party service (or dedicated person) to update your translations and XCode refuses to import your xliff correctly?
I know that pain, bro! That's why I created this tool so that you can just replace your files with new ones!

It uses Swift Package Manager and should be able to target 10.10 and later.

### Installing

1. Download this project.
2. Run `swift build`
3. Grab binary from `.build/x86_64-apple-macosx10.10/debug/xliff2strings`
4. Run

## Notes and Warnings

`stringsdict` generator uses some magic and hardcoded values since `xliff` does not contain all needed information. This includes following keys:
Key | Value
---- | -----
NSStringFormatSpecTypeKey | NSStringPluralRuleType
NSStringFormatValueTypeKey | d

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [SwiftCLI](https://github.com/jakeheis/SwiftCLI) - library for Swift CLI apps
* [XMLCoder](https://github.com/MaxDesiatov/XMLCoder) - wonderful library that did all heavy XML parsing for me
