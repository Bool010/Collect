//
//  Date+WN.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/14.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation


/// ISOFormatter
///
/// 提供单例shared, 避免多次用到多次创建
class ISOFormatter: DateFormatter {
    
    static let shared = ISOFormatter.init(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ", locale: Locale.init(identifier: "en_US_POSIX"))
    
    override init() {
        super.init()
    }
    
    convenience init(dateFormat: String, locale: Locale) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = locale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension Date {
    
    /// 返回一个Date的年份
    ///
    /// - Returns: 年份
    func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    
    /// 返回一个Date的月份
    ///
    /// - Returns: 月份
    func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    
    /// 返回一个Date的日
    ///
    /// - Returns: 日
    func day() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    
    /// 返回一个Date的小时
    ///
    /// - Returns: 小时
    func hour() -> Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    
    /// 返回一个Date的分钟
    ///
    /// - Returns: 分钟
    func minute() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    
    /// 返回一个Date的秒数
    ///
    /// - Returns: 秒
    func second() -> Int {
        return Calendar.current.component(.second, from: self)
    }
    
    
    /// 返回一个Date的纳秒
    ///
    /// - Returns: 纳秒
    func nanosecond() -> Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
    
    
    /// 返回一个Date的星期
    ///
    /// - Returns: 星期
    func weekday() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    
    /// 该日期是本月的第几个星期几
    ///
    /// - Returns: 该日期是本月的第几个星期几
    func weekdayOrdinal() -> Int {
        return Calendar.current.component(.weekdayOrdinal, from: self)
    }
    
    
    /// 是指该日期是本月的第几周。一周从星期日开始。
    /// e.g. 如果本月是从周二开始的，即1号是周二，2号是周三，6号是周日，7号是周一，8号是第二个周二。
    ///      那么如果日期设定为1，2，3，4，5号的话，则weekOfMonth和weekdayOrdinal都是1。
    ///      那么如果日期设定为6，7号的话，则weekOfMonth是2，但是weekdayOrdinal却是1，因为6号虽然是第二周，
    ///      但是却是本月第一个周日，同样7号虽然也是第二周，但是却是本月第一个周一。👆
    /// - Returns: 日期是本月的第几周
    func weekOfMonth() -> Int {
        return Calendar.current.component(.weekOfMonth, from: self)
    }
    
    
    /// 该Date一年中的第几周
    ///
    /// - Returns: 一年中的第几周
    func weekOfYear() -> Int {
        return Calendar.current.component(.weekOfYear, from: self)
    }
    
    func yearForWeekOfYear() -> Int {
        return Calendar.current.component(.yearForWeekOfYear, from: self)
    }
    
    
    /// 几刻钟，也就是15分钟。范围为1-4
    ///
    /// - Returns: 几刻钟
    func quarter() -> Int {
        return Calendar.current.component(.quarter, from: self)
    }
    
    
    /// 该Date是否是闰月
    ///
    /// - Returns: 是否是闰月
    func isLeapMonth() -> Bool {
        return Calendar.current.dateComponents(in: TimeZone.current, from: self).isLeapMonth!
    }
    
    
    /// 该Date是否是今天
    ///
    /// - Returns: 是否是今天
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    
    /// 该Date是否是昨天
    ///
    /// - Returns: 是否是昨天
    func isYesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    
    /// 该Date是否是明天
    ///
    /// - Returns: 是否是明天
    func isTomorrow() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    
    /// 该Date是否是周末
    ///
    /// - Returns: 是否是周末
    func isWeekend() -> Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    
    
    /// 将日期转换为字符串
    ///
    /// - Parameter format: 代表所需的日期格式字符串
    ///   e.g. @"yyyy-MM-dd HH:mm:ss"
    /// - Returns: 格式化的日期字符串
    @discardableResult
    func string(format: String) -> String {
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    
    /// 将日期转换为字符串
    ///
    /// - Parameters:
    ///   - format: 代表所需的日期格式字符串
    ///   - timeZone: 想要的时区.
    ///   - locale: 想要的位置
    /// - Returns: 格式化的日期字符串
    @discardableResult
    func string(format: String, timeZone: TimeZone?, locale: Locale?) -> String {
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        if let locale = locale {
            formatter.locale = locale
        }
        return formatter.string(from: self)
    }
    
    
    /// 返回一个字符串,表示这个日期以ISO8601格式。
    /// e.g. "2010-07-09T16:13:30+12:00"
    ///
    /// - Returns: 以ISO8601 格式化的日期字符串。
    @discardableResult
    func stringISOformat() -> String {
        
        let formatter = ISOFormatter.shared
        return formatter.string(from: self)
    }

    
    /// 向该Date添加几秒钟
    ///
    /// - Parameter hours: 几秒钟
    /// - Returns: 相加后的日期
    func addingSeconds(_ seconds: TimeInterval) -> Date {
        
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate + seconds
        let newDate = Date.init(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    
    /// 向该Date添加几分钟
    ///
    /// - Parameter hours: 几分钟
    /// - Returns: 相加后的日期
    func addingMinutes(_ minutes: Int) -> Date {
        
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate + TimeInterval(60 * minutes)
        let newDate = Date.init(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    
    /// 向该Date添加几小时
    ///
    /// - Parameter hours: 几小时
    /// - Returns: 相加后的日期
    func addingHours(_ hours: Int) -> Date {
        
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate + TimeInterval(3600 * hours)
        let newDate = Date.init(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }
    
    
    /// 向该Date添加几天
    ///
    /// - Parameter days: 几天
    /// - Returns: 相加之后的日期
    func addingDays(_ days: Int) -> Date {
        
        let aTimeInterval: TimeInterval = self.timeIntervalSinceReferenceDate + TimeInterval(86400 * days)
        let newDate = Date.init(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }

    
    /// 向该Date添加几周
    ///
    /// - Parameter weeks: 几周
    /// - Returns: 相加后的日期
    func addingWeeks(_ weeks: Int) -> Date? {
        
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.weekOfYear = weeks
        return calendar.date(byAdding: components, to: self)
    }
    
    
    /// 向该Date添加几月
    ///
    /// - Parameter month: 几月
    /// - Returns: 相加后的日期
    func addingMonths(_ month: Int) -> Date? {
        
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.month = month
        return calendar.date(byAdding: components, to: self)
    }
    
    
    /// 向该Date添加几年
    ///
    /// - Parameter month: 几年
    /// - Returns: 相加后的日期
    func addingYears(_ year: Int) -> Date? {
        
        let calendar = Calendar.current
        var components = DateComponents.init()
        components.year = year
        return calendar.date(byAdding: components, to: self)
    }
}
