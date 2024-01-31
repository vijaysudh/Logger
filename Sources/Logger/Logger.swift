// Logger.swift
// Logger
// Created by Vijaysudh Madhusoodhan on 1/30/24.
// Copyright © 2024 Vijaysudh Madhusoodhan. All rights reserved.

import Foundation

public enum LogType: Int {
    case debug = 1
    case info
    case warn
    case error
    
    func logTypePrefix() -> String {
        switch self {
        case .debug:
            return "[Debug]"
        case .info:
            return "[Info]"
        case .warn:
            return "[Warn]"
        case .error:
            return "[Error]"
        }
    }
}

public class Logger {
    private var logLevel: LogType = .debug
    
    private init() {
        
    }
    
    public static let shared = Logger()
    
    public func change(logLevel: LogType) {
        self.logLevel = logLevel
    }
    
    public func log(withLogType logType: LogType,
                     _ items: Any...,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) {
        guard logType.rawValue >= logLevel.rawValue else {
            return
        }
        
        let fileString = file as NSString
        let fileLastPathComponent = fileString.lastPathComponent as NSString
        let filename = fileLastPathComponent.deletingLastPathComponent
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        
        print("\(formatter.string(from: date)) - \(filename).\(function): [\(line)] \(logType.logTypePrefix()) ", items)
    }
}


