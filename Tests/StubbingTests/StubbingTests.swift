import Assertions
import XCTest

@testable import Stubbing

final class StubbingTests: XCTestCase {
    enum TestCaseIterable: CaseIterable {
        case first
        case second
        case third
        case fourth
    }
    
    func testBool() throws {
        let results = (0..<1000)
            .map { _ in Bool.stub }
        
        try assertTrue(results.contains(true))
        try assertTrue(results.contains(false))
    }
    
    func testCaseIterable() throws {
        let results = (0..<1000)
            .map { _ in TestCaseIterable.stub }
        
        try assertTrue(results.contains(.first))
        try assertTrue(results.contains(.second))
        try assertTrue(results.contains(.third))
        try assertTrue(results.contains(.fourth))
    }
    
    func testCollection() throws {
        let results = (0..<100)
            .map { _ in [Int].stub }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
            
            try assertFalse(results[firstIndex].isEmpty)
        }
    }
    
    func testDate() throws {
        let results = (0..<100)
            .map { _ in Date.stub }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
        }
    }
    
    func testDictionary() throws {
        let results = (0..<100)
            .map { _ in [Int: Double].stub }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
            
            try assertFalse(results[firstIndex].isEmpty)
        }
    }
    
    func testInt() throws {
        let types: [any (FixedWidthInteger & Stubbable).Type] = [
            Int.self,
            UInt.self,
            Int8.self,
            UInt8.self,
            Int16.self,
            UInt16.self,
            Int32.self,
            UInt32.self,
            Int64.self,
            UInt64.self,
        ]
        
        for type in types {
            try type.testStub()
        }
    }
    
    func testFloat() throws {
        var types: [any (FloatingPoint & Stubbable).Type] = [
            Float.self,
            Double.self,
            Float80.self
        ]
        
        #if arch(arm64)
        types.append(Float16.self)
        #endif
        
        for type in types {
            try type.testStub()
        }
    }
    
    func testOptional() throws {
        let results = (0..<10)
            .map { _ in (0..<100).map { _ in Int?.stub } }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
        }
        
        for result in results {
            try assertTrue(result.contains(nil))
            try assertTrue(result.contains { $0 != nil })
        }
    }
    
    func testOptionalNonNil() throws {
        let results = (0..<10)
            .map { _ in (0..<100).map { _ in Int?.stubNonNil } }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
        }
        
        for result in results {
            try assertFalse(result.contains(nil))
        }
    }
    
    func testSet() throws {
        let results = (0..<100)
            .map { _ in Set<Int>.stub }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
            
            try assertFalse(results[firstIndex].isEmpty)
        }
    }
    
    func testString() throws {
        let results = (0..<100)
            .map { _ in String.stub }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
            
            try assertFalse(results[firstIndex].isEmpty)
        }
    }
    
    func testStringPrefixed() throws {
        let prefix = "TestString"
        
        let results = (0..<100)
            .map { _ in String.stub(prefix: prefix) }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
            
            try assertFalse(results[firstIndex].isEmpty)
        }
        
        for result in results {
            try assertTrue(result.hasPrefix("\(prefix): "))
        }
    }
    
    func testURL() throws {
        try URL.testStub()
    }
    
    func testUUID() throws {
        try UUID.testStub()
    }
}

extension Stubbable where Self: Equatable {
    static func testStub() throws {
        let results = (0..<10)
            .map { _ in (0..<100).map { _ in Self.stub } }
        
        for firstIndex in results.indices {
            for secondIndex in results.indices where secondIndex != firstIndex {
                try assertNotEqual(results[firstIndex], results[secondIndex])
            }
        }
    }
}
