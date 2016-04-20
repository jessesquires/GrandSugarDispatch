//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://jessesquires.com/GrandSugarDispatch
//
//
//  GitHub
//  https://github.com/jessesquires/GrandSugarDispatch
//
//
//  License
//  Copyright © 2016 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//


import XCTest

@testable import GrandSugarDispatch

let timeout = NSTimeInterval(30)


final class GrandSugarDispatchTests: XCTestCase {
    
    func test_thatMainQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .main, concurrency: .async) {
            XCTAssertTrue(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatUserInteractiveQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .userInteractive, concurrency: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatUserInitiatedQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .userInitiated, concurrency: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatDefaultQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .regular, concurrency: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func test_thatUtilityQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .utility, concurrency: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatBackgroundQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .background, concurrency: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

}
