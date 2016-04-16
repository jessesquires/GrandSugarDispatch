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


public enum Concurrency {
    case async
    case sync
    case barrierAsync
    case barrierSync
    case delay(Double)
}


public enum DispatchQueue {
    case main
    case userInteractive
    case userInitiated
    case regular
    case utility
    case background
    case concurrent(String)
    case serial(String)

    var dispatchQueue: dispatch_queue_t {
        switch self {
        case main:
            return dispatch_get_main_queue()
        case userInteractive:
            return dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
        case userInitiated:
            return dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
        case regular:
            return dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        case utility:
            return dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)
        case background:
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
    case .delay(let d):
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(d * Double(NSEC_PER_SEC))), queue.dispatchQueue, closure)
    }
}
