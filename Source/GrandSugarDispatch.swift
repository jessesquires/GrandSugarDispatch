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
 Describes the execution type of a dispatch queue.
 */
public enum Execution {
    /// Submits a closure for asynchronous execution on a dispatch queue and returns immediately.
    case async

    /// Submits a closure for synchronous execution on a dispatch queue and waits until that closure completes.
    case sync

    /// Submits a barrier closure for asynchronous execution and returns immediately.
    case barrierAsync

    /// Submits a barrier closure for synchronous execution and waits until that closure completes.
    case barrierSync

    /**
     Enqueue a closure for execution after the specified delay in seconds.

     - parameter seconds: The time in seconds after which the closure should execute.
     */
    case delay(seconds: Double)
}


/**
 Describes the concurrency type of a custom dispatch queue.
 */
public enum Concurrency {
    /// Specifies a concurrent dispatch queue.
    case concurrent

    /// Specifies a serial dispatch queue.
    case serial
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
     A custom dispatch queue to which closures can be submitted.

     - parameter dispatch_queue_t: A dispatch queue.
     */
    case custom(dispatch_queue_t)

    /**
     Creates a new dispatch queue with the specified concurrency.

     - parameter label:       A label to attach to the queue to uniquely identify it.
     - parameter concurrency: The concurrency type of the dispatch queue.

     - returns: A newly created dispatch queue.
     */
    public static func create(label label: String, concurrency: Concurrency) -> dispatch_queue_t {
        switch concurrency {
        case .concurrent:
            return dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT)
        case .serial:
            return dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL)
        }
    }

    private var dispatchQueue: dispatch_queue_t {
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
        case .custom(let queue):
            return queue
        }
    }
}

/**
 Submits a closure for execution on the specified dispatch queue using the specified execution type.

 - parameter queue:     The queue on which to submit the closure.
 - parameter execution: The execution type for the queue.
 - parameter closure:   The closure to submit to the dispatch queue.
 */
public func dispatch(queue queue: DispatchQueue, execution: Execution = .async, closure: () -> Void) {

    switch execution {
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
