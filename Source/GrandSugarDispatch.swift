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


import Foundation

/**
 Describes the concurrency type of a dispatch queue.
 */
public enum Concurrency {
    case async
    case sync
    case barrierAsync
    case barrierSync
    case delay(seconds: Double)
}


/**
 Describes the type of dispatch queue.
 */
public enum DispatchQueue {
    /// The serial dispatch queue associated with the application’s main thread.
    case main

    /// A system-defined global concurrent queue with a "user interactive" quality of service.
    case userInteractive

    /// A system-defined global concurrent queue with a "user initiated" quality of service.
    case userInitiated

    /// A system-defined global concurrent queue with a default quality of service.
    case regular

    /// A system-defined global concurrent queue with a "utility" quality of service.
    case utility

    /// A system-defined global concurrent queue with a "background" quality of service.
    case background

    /**
     A new concurrent dispatch queue to which blocks can be submitted.

     - parameter label: A label to attach to the queue to uniquely identify it.
     */
    case concurrent(label: String)

    /**
     A new serial dispatch queue to which blocks can be submitted.

     - parameter label: A label to attach to the queue to uniquely identify it.
     */
    case serial(label: String)

    var dispatchQueue: dispatch_queue_t {
        switch self {
        case .main:
            return dispatch_get_main_queue()
        case .userInteractive:
            return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
        case .userInitiated:
            return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
        case .regular:
            return dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        case .utility:
            return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
        case .background:
            return dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
        case .concurrent(let name):
            return dispatch_queue_create(name, DISPATCH_QUEUE_CONCURRENT)
        case .serial(let name):
            return dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL)
        }
    }
}


public func dispatch(queue queue: DispatchQueue, concurrency: Concurrency = .async, closure: () -> Void) {

    switch concurrency {
    case .async:
        dispatch_async(queue.dispatchQueue, closure)
    case .sync:
        dispatch_sync(queue.dispatchQueue, closure)
    case .barrierAsync:
        dispatch_barrier_async(queue.dispatchQueue, closure)
    case .barrierSync:
        dispatch_barrier_sync(queue.dispatchQueue, closure)
    case .delay(let seconds):
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC))), queue.dispatchQueue, closure)
    }
}
