//
//  ViewController.swift
//  LXToolKit_Example
//
//  Created by lxthyme on 04/11/2023.
//  Copyright (c) 2023 lxthyme. All rights reserved.
//

import UIKit
import LXToolKit_Example

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let vc = LXToolKitTestVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

