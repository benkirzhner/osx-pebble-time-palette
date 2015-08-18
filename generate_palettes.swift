#!/usr/bin/env xcrun swift

import Foundation
import AppKit

let data = NSFileHandle
    .fileHandleWithStandardInput()
    .readDataToEndOfFile()

var jsonErrorOptional: NSError?
let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(
    data, options: NSJSONReadingOptions(0), error: &jsonErrorOptional
)

if let json = jsonOptional as? Array<Dictionary<String, AnyObject>> {
    let palette = NSColorList(name: "Pebble Time")

    for colorDict in json {
        var red = colorDict["red"] as! CGFloat
        var green = colorDict["green"] as! CGFloat
        var blue = colorDict["blue"] as! CGFloat
//      var sunlightRed = colorDict["sunlight_red"] as! CGFloat
//      var sunlightGreen = colorDict["sunlight_green"] as! CGFloat
//      var sunlightBlue = colorDict["sunlight_blue"] as! CGFloat
        let name = colorDict["name"] as! String

        let regularColor = NSColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)

        palette.setColor(regularColor, forKey: name)
    }

    palette.writeToFile(".")
}
