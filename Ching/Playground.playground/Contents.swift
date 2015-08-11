//: Playground - noun: a place where people can play

import UIKit

NSDecimalNumber(string: "100.01", locale: NSLocale.currentLocale())
NSDecimalNumber(string: "192.168.1.1", locale: NSLocale.currentLocale())
NSDecimalNumber(string: "192abc", locale: NSLocale.currentLocale())
let num = NSDecimalNumber(string: "0", locale: NSLocale.currentLocale())

let formatter = NSNumberFormatter()
formatter.numberStyle = .DecimalStyle
formatter.locale = NSLocale.currentLocale()
formatter.currencySymbol = ""

formatter.stringFromNumber(num)

NSDate(timeIntervalSinceNow: -(60 * 60 * 24 * 32))

let df = NSDateFormatter()
df.dateFormat = "yyyy-MM-dd"
df.dateFromString("2015-08-10")
