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

        dispatch(queue: .main, execution: .async) {
            XCTAssertTrue(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatUserInteractiveQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .userInteractive, execution: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatUserInitiatedQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .userInitiated, execution: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatDefaultQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .regular, execution: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func test_thatUtilityQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .utility, execution: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatBackgroundQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .background, execution: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatCustomConcurrentQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        let concurrentQ = DispatchQueue.create(label: "com.jessesquires.GrandSugarDispatch", concurrency: .concurrent)
        
        dispatch(queue: .custom(concurrentQ), execution: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatCustomSerialQueue_executesAsynchronously() {
        let expectation = expectationWithDescription(#function)

        let serialQ = DispatchQueue.create(label: "com.jessesquires.GrandSugarDispatch", concurrency: .serial)

        dispatch(queue: .custom(serialQ), execution: .async) {
            XCTAssertFalse(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

    func test_thatMainQueue_executesAfterDelay() {
        let expectation = expectationWithDescription(#function)

        dispatch(queue: .main, execution: .delay(seconds: 1)) {
            XCTAssertTrue(NSThread.isMainThread())
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout) { (error) in
            XCTAssertNil(error)
        }
    }

}
