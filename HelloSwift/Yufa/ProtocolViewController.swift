//
//  ProtocolViewController.swift
//  HelloSwift
//
//  Created by Darius Guo on 2022/1/25.
//

import UIKit

protocol Coordication {
    associatedtype DeleteCoordicater
    associatedtype DeleteCoordicater2
    var coordicater: DeleteCoordicater {get}
}

protocol MarketChartViewControllerCoordinator: AnyObject {
    
}

class ProtocolViewController: TCBaseViewController, Coordication {
    
    typealias DeleteCoordicater2 = Int
    
    var coordicater: MarketChartViewControllerCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

class QueueViewController: TCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let queue = DispatchQueue(label: "com.save")
        queue.async {
        
        }
        queue.sync {
        
        }
        
        let conqueue = DispatchQueue(label: "", attributes: DispatchQueue.Attributes.concurrent)
        conqueue.sync {
        
        }
        conqueue.async {
        
        }
        
    }
    
    func testSerialQueue() {
        let queue = DispatchQueue(label: "queue")
        print("------ 开始 -------")
        queue.async {
            Thread.sleep(forTimeInterval: 3)
            print("------ async 1 -------")
        }

        print("------ async 1 不阻塞 -------")

        queue.async {
            print("------ async 2 -------")
        }

        queue.sync {
            Thread.sleep(forTimeInterval: 3)
            print("------ sync 1 -------")
        }

        print("------ 被 sync 1 阻塞 -------")

        queue.async {
            print("------ async 3 -------")
        }

//        ------ 开始 -------
//        ------ async 1 不阻塞 -------
//        ------ async 1 -------
//        ------ async 2 -------
//        ------ sync 1 -------
//        ------ 被 sync 1 阻塞 -------
//        ------ async 3 -------
    }
    
    func testConqueue() {
        let queue = DispatchQueue(label: "queue", attributes: DispatchQueue.Attributes.concurrent)
        print("------ 开始 -------")
        queue.async {
            Thread.sleep(forTimeInterval: 3)
            print("------ async 1 -------")
        }

        print("------ async 1 不阻塞 -------")

        queue.async {
            print("------ async 2 -------")
        }

        queue.sync {
            Thread.sleep(forTimeInterval: 5)
            print("------ sync 1 -------")
        }

        print("------ 被 sync 1 阻塞 -------")

        queue.async {
            print("------ async 3 -------")
        }

//        ------ 开始 -------
//        ------ async 1 不阻塞 -------
//        ------ async 2 -------
//        ------ async 1 -------
//        ------ sync 1 -------
//        ------ 被 sync 1 阻塞 -------
//        ------ async 3 -------
        
    }
}
