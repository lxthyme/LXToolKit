//
//  LXMultiRequestTestVC.swift
//  LXToolKit_Example
//
//  Created by LXThyme Jason on 2020/8/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import LXToolKit

class LXMultiRequestTestVC: LXBaseVC {

    lazy var queue: DispatchQueue = {
        let queueLabel = Bundle.main.bundleIdentifier ?? "" + ".concurrentQueue"
        let queue = DispatchQueue(label: queueLabel, qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
        return queue
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        test1()
//        test2()
//        test3()
        test4()
    }

}

// MARK: - <#Title...#>
extension LXMultiRequestTestVC {
    func test1() {
        let queue = OperationQueue()
        let op1 = BlockOperation {
            dlog("1: ", Thread.current)
        }
        let op2 = BlockOperation {
            dlog("2: ", Thread.current)
        }
        let op3 = BlockOperation {
            dlog("3: ", Thread.current)
        }

        /// 添加依赖
        op1.addDependency(op2)
        op2.addDependency(op3)

        /// 将操作添加到队列中
        queue.addOperation(op1)
        queue.addOperation(op2)
        queue.addOperation(op3)
    }

    func test2() {
        let queueLabel = Bundle.main.bundleIdentifier ?? "" + ".concurrentQueue"
        let queue = DispatchQueue(label: queueLabel, qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
        let group = DispatchGroup()
//        queue.async(group: <#T##DispatchGroup#>, execute: <#T##DispatchWorkItem#>)
//        queue.async(group: group, qos: .default, flags: .init(), execute: <#T##() -> Void#>)
        queue.async(group: group, execute: DispatchWorkItem(block: {
            group.enter()
            DispatchQueue.global().async {
                sleep(7)
                dlog("Task 2")
                group.leave()
            }
        }))
        queue.async(group: group, execute: DispatchWorkItem(block: {
            group.enter()
            DispatchQueue.global().async {
                sleep(5)
                dlog("Task 1")
                group.leave()
            }
        }))
        queue.async(group: group, execute: DispatchWorkItem(block: {
            group.enter()
            DispatchQueue.global().async {
                sleep(10)
                dlog("Task 3")
                group.leave()
            }
        }))
        group.notify(queue: queue) {
            DispatchQueue.global().async {
                dlog("All Done!")
            }
        }
    }

    func test3() {
        queue.async {
            sleep(5)
            dlog("A")
        }
        queue.async {
            sleep(3)
            dlog("B")
        }
        queue.async(group: nil, qos: .default, flags: .barrier) {
            dlog("Barrier")
        }
        queue.async {
            dlog("C")
        }
        queue.async {
            dlog("D")
        }
    }

    func test4() {
        let semaphore = DispatchSemaphore(value: 1)
//        semaphore.wait()
//        semaphore.signal()
        DispatchQueue.global().async {
            semaphore.wait()
            DispatchQueue.global().async {
                sleep(7)
                dlog("Task 3")
                semaphore.signal()
            }
        }
        DispatchQueue.global().async {
            semaphore.wait()
            DispatchQueue.global().async {
                sleep(3)
                dlog("Task 1")
                semaphore.signal()
            }
        }
        DispatchQueue.global().async {
            semaphore.wait()
            DispatchQueue.global().async {
                sleep(5)
                dlog("Task 2")
                semaphore.signal()
            }
        }
        DispatchQueue.global().async {
            semaphore.wait()
            semaphore.signal()
            dlog("All Done!")
        }
    }
}
