// Logger.swift
// Logger
// Created by Vijaysudh Madhusoodhan on 1/30/24.
// Copyright © 2024 Vijaysudh Madhusoodhan. All rights reserved.

import Foundation

/// Log Type defines the type of log being printed
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

/// Protocol to direct the Log messages
public protocol LogOutput {
    func write(_ message: String)
}

/// Logger Class to print tracable logs
public class Logger {
    private var logLevel: LogType = .debug
    private var logOutput: LogOutput = ConsoleLogOutput()
    
    private init() {
        
    }
    
    public static let shared = Logger()
    
    
    /// Change the log level to be printed
    /// - Parameter logLevel: Minimum level of log to be printed
    public func change(logLevel: LogType) {
        self.logLevel = logLevel
    }
    
    
    /// Set the log output. Defaults to console if not used
    /// - Parameter logOutput: Concrete implementation where the logs should be written
    func set(logOutput: LogOutput) {
        self.logOutput = logOutput
    }
    
    /// Processes the log message and adds additional tracability parameters
    /// - Parameters:
    ///   - logType: Log type for the message
    ///   - items: Message content
    ///   - file: File that the log is generated from
    ///   - function: function that the log is generated fron
    ///   - line: line number in the file
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
        
        let message = "\(formatter.string(from: date)) - \(filename).\(function): [\(line)] \(logType.logTypePrefix())  \(items)"
        logOutput.write(message)
    }
}


/// ConsoleLogOutput is the default implementation for the logs to be written to the console
public class ConsoleLogOutput: LogOutput {
    public func write(_ message: String) {
        print(message)
    }
}


