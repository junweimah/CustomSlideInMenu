//
//  ViewController.swift
//  CustomSlideInMenu
//
//  Created by Tandem on 30/05/2018.
//  Copyright © 2018 Tandem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let settings = Settings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnShowSlideInMenuClicked(_ sender: UIButton) {
        //show menu
        settings.showSettings()
    }
}

