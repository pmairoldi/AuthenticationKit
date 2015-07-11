import Foundation
import XCTest

extension XCTestCase {
    
    func XCTAssertEqualOptional<T: Any where T: Equatable>(@autoclosure a: () -> T?, @autoclosure _ b: () -> T?, _ message: String? = nil, file: String = __FILE__, line: UInt = __LINE__) {
        if let _a = a() {
            if let _b = b() {
                XCTAssertEqual(_a, _b, (message != nil ? message! : ""), file: file, line: line)
            } else {
                XCTFail((message != nil ? message! : "a != nil, b == nil"), file: file, line: line)
            }
        } else if let _ = b() {
            XCTFail((message != nil ? message! : "a == nil, b != nil"), file: file, line: line)
        } else {
            XCTAssert(true, (message != nil ? message! : ""), file: file, line: line)
        }
    }
    
    func XCTAssertEqualOptionalAnyDictionary(@autoclosure a: () -> [NSObject : AnyObject]?, @autoclosure _ b: () -> [NSObject : AnyObject]?, _ message: String? = nil, file: String = __FILE__, line: UInt = __LINE__) {
        if let _a = a() {
            if let _b = b() {
                let v = _a.values.elementsEqual(_b.values, isEquivalent: { (elem1, elem2) -> Bool in
                    elem1.isEqual(elem2)
                })
                
                let k = _a.keys.elementsEqual(_b.keys, isEquivalent: { (elem1, elem2) -> Bool in
                    elem1.isEqual(elem2)
                })
                XCTAssert(k && v, (message != nil ? message! : ""), file: file, line: line)
            } else {
                XCTFail((message != nil ? message! : "a != nil, b == nil"), file: file, line: line)
            }
        } else if let _ = b() {
            XCTFail((message != nil ? message! : "a == nil, b != nil"), file: file, line: line)
        } else {
            XCTAssert(true, (message != nil ? message! : ""), file: file, line: line)
        }
    }
    
}