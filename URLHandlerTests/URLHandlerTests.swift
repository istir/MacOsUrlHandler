//
//  URLHandlerTests.swift
//  URLHandlerTests
//
//  Created by Joachim Bargsten on 04/01/2023.
//

import XCTest
@testable import URLHandler

final class URLHandlerTests: XCTestCase {
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test1() throws {
    let actual = URL(string: "://abc/def").flatMap { extractLocation(url: $0) }!
    XCTAssertEqual(actual.0, "abc")
    XCTAssertEqual(actual.1, "def")
  }

  func test2() throws {
    XCTAssertNil(extractLocation(url: URL(string: ":///abc/def/ghi")!))
    XCTAssertNil(extractLocation(url: URL(string: "://abc/..")!))
    XCTAssertNil(extractLocation(url: URL(string: "://&/a")!))
    XCTAssertNil(extractLocation(url: URL(string: ":///")!))
    XCTAssertNil(extractLocation(url: URL(string: "://")!))
    XCTAssertNil(extractLocation(url: URL(string: "://a/a=b")!))
    XCTAssertNil(extractLocation(url: URL(string: "abc/def")!))
  }

  func test3() throws {
    XCTAssertEqual(try? getConfigFilePath(), URL(filePath: "/Users/jwb/.config/.yaml"))
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    measure {
      // Put the code you want to measure the time of here.
    }
  }
}
