//
//  ViewController.swift
//  LXToolKit
//
//  Created by LX314 on 11/12/2019.
//  Copyright (c) 2019 LX314. All rights reserved.
//

import UIKit
import Alamofire
import LXToolKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let _ = LXBaseVC()
        let identifier = self.xl_typeName
        print("identifier: \(identifier)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

