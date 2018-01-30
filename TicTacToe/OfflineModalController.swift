//
//  OfflineModalController.swift
//  TicTacToe
//
//  Created by SUP'Internet 14 on 30/01/2018.
//  Copyright © 2018 SUP'Internet 14. All rights reserved.
//

import UIKit

class OfflineModalController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("offline modal loaded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonTouch(_ sender: Any) {
        print((sender as! UIButton).tag)
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
