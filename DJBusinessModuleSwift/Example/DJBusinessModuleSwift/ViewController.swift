//
//  ViewController.swift
//  DJBusinessModuleSwift
//
//  Created by lxthyme on 07/17/2022.
//  Copyright (c) 2022 lxthyme. All rights reserved.
//

import UIKit
import DJBusinessModuleSwift

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let vc = LXTestVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

