//
//  Date+Extension.swift
//  autosavedBeta
//
//  Created by Asia Michelle Serrano on 9/29/23.
//

import Foundation

fileprivate enum DateEnum: String {
    case dashes = "yyyy-MM-dd"
    case dashless = "yyyyMMdd"
    case long = "MMMM d, y"
    case year = "yyyy"
    case timestamp = "yyyyMMdd-hhmmssa"
}

fileprivate extension DateFormatter {
    
    static func create(_ dateString: String) -> Date {
        DateFormatter(formatString: DateEnum.dashless.rawValue).date(from: dateString)!
    }
    
    static func format(_ date: Date, _ form: DateEnum) -> String {
        DateFormatter(formatString: form.rawValue).string(from: date)
    }
    
    private convenience init(formatString: String) {
        self.init()
        self.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        self.dateFormat = formatString
    }
    
}

public extension Date {
    
    static var random: Self {
        let low: TimeInterval = Self(1900,1,1).timeIntervalSinceNow
        let high: TimeInterval = Self.today.timeIntervalSinceNow
        return Date(timeIntervalSinceNow: TimeInterval.random(in: low...high))
    }

    static var today: Self {
        .init(Date.now)
    }
    
//    public static func currentTimestamp() -> Int {
//        return Int(Self().timeIntervalSince1970 * 1000)
//    }
    
    private init(_ dashless: String) {
        self = DateFormatter.create(dashless)
    }
    
    init(_ year: Int, _ month: Int, _ day: Int) {
        
        func form(_ int: Int) -> String {
            String(format: "%02d", int)
        }
        
        self = .init("\(year)\(form(month))\(form(day))")
    }
    
    init(_ other: Self) {
        self = .init(other.dashless)
    }

    var long: String {
        DateFormatter.format(self, .long)
    }
    
    var dashless: String {
        DateFormatter.format(self, .dashless)
    }

    var year: String {
        DateFormatter.format(self, .year)
    }
//
//    public var dashes: String {
//        DateFormatter.format(self, .dashes)
//    }
//
//    public var timestamp: String {
//        DateFormatter.format(self, .timestamp)
//    }
//
//    public var timeless: Self {
//        Self.init(self.dashless)
//    }
    
}
