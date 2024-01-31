// LoggerTest.swift
// Logger
// Created by Vijaysudh Madhusoodhan on 1/30/24.
// Copyright © 2024 Vijaysudh Madhusoodhan. All rights reserved.

import XCTest
@testable import Logger

final class LoggerTests: XCTestCase {
    let logger = Logger.shared
    let testLogOutput = TestLogOutput()
    
    override func setUp() async throws {
        logger.set(logOutput: testLogOutput)
    }
    
    override class func tearDown() {
        TestLogOutput().clearMessages()
    }
    
    /// Test Logger with debug level.
    /// All the log types will be printed
    func testDebugLoggerLevelConfiguration() {
        logger.log(withLogType: .debug, "Sample text")

        if let lastMessage = testLogOutput.readLastMessage() {
            XCTAssertTrue(lastMessage.contains("Sample text"))
            XCTAssertTrue(lastMessage.contains("[Debug]"))
        } else {
            XCTFail("Message not found")
        }
        testLogOutput.clearMessages()
    }
    
    /// Test Logger with info level.
    /// Logs with info level and higer are printed, debug logs will not be printed
    func testInfoLoggerLevelConfiguration() {
        logger.change(logLevel: .info)
        
        // Debug message should not be logged
        logger.log(withLogType: .debug, "After level change to info")
        
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTFail("Debug message logged at Info level")
        } else {
            XCTAssertTrue(true)
        }
        
        logger.log(withLogType: .info, "Info log statement")
        // Info message should be logged
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTAssertTrue(lastMessage.contains("Info log statement"))
            XCTAssertTrue(lastMessage.contains("[Info]"))
        } else {
            XCTFail("Message not found")
        }
        
        logger.log(withLogType: .warn, "Warn log statement")
        // Warn message should be logged
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTAssertTrue(lastMessage.contains("Warn log statement"))
            XCTAssertTrue(lastMessage.contains("[Warn]"))
        } else {
            XCTFail("Message not found")
        }
        
        logger.log(withLogType: .error, "Error log statement")
        // Error message should be logged
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTAssertTrue(lastMessage.contains("Error log statement"))
            XCTAssertTrue(lastMessage.contains("[Error]"))
        } else {
            XCTFail("Message not found")
        }
        testLogOutput.clearMessages()
    }
    
    /// Test Logger with warn level.
    /// Logs with warn level and higer are printed
    func testWarnLoggerLevelChange() {
        logger.change(logLevel: .warn)
        
        // Debug message should not be logged
        logger.log(withLogType: .debug, "After level change to warn")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTFail("Debug message logged at Warn level")
        } else {
            XCTAssertTrue(true)
        }
        
        // Info message should not be logged
        logger.log(withLogType: .info, "Info log statement")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTFail("Info message logged at Warn level")
        } else {
            XCTAssertTrue(true)
        }
        
        // Warn message should be logged
        logger.log(withLogType: .warn, "Warn log statement")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTAssertTrue(lastMessage.contains("Warn log statement"))
            XCTAssertTrue(lastMessage.contains("[Warn]"))
        } else {
            XCTFail("Message not found")
        }
        
        // Error message should be logged
        logger.log(withLogType: .error, "Error log statement")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTAssertTrue(lastMessage.contains("Error log statement"))
            XCTAssertTrue(lastMessage.contains("[Error]"))
        } else {
            XCTFail("Message not found")
        }
        testLogOutput.clearMessages()
    }
    
    /// Test Logger with error level.
    /// Logs with erro level and higer are printed
    func testErrorLoggerLevelChange() {
        logger.change(logLevel: .error)
        
        // Debug message should not be logged
        logger.log(withLogType: .debug, "After level change to error")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTFail("Debug message logged at Error level")
        } else {
            XCTAssertTrue(true)
        }
        
        // Info message should not be logged
        logger.log(withLogType: .info, "Info log statement")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTFail("Info message logged at Error level")
        } else {
            XCTAssertTrue(true)
        }
        
        // Warn message should not be logged
        logger.log(withLogType: .warn, "Warn log statement")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTFail("Warn message logged at Error level")
        } else {
            XCTAssertTrue(true)
        }
        
        // Error message should be logged
        logger.log(withLogType: .error, "Error log statement")
        if let lastMessage = testLogOutput.readLastMessage() {
            XCTAssertTrue(lastMessage.contains("Error log statement"))
            XCTAssertTrue(lastMessage.contains("[Error]"))
        } else {
            XCTFail("Message not found")
        }
        testLogOutput.clearMessages()
    }
}

class TestLogOutput: LogOutput {
    var messages = [String]()
    
    func write(_ message: String) {
        messages.append(message)
    }
    
    func readLastMessage() -> String? {
        return messages.last
    }
    
    func clearMessages() {
        messages.removeAll()
    }
}
