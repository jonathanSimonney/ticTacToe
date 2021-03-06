//
//  OnlineViewController.swift
//  TicTacToe
//
//  Created by SUP'Internet 14 on 30/01/2018.
//  Copyright © 2018 SUP'Internet 14. All rights reserved.
//

import UIKit
import CDAlertView
import SwiftSpinner

class OnlineViewController: ViewController {
    
    @IBOutlet weak var usernameView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print("online view loaded")
        TTTSocket.sharedInstance.socket.on("join_game") { (params, emitter) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "presentOnlineGame", sender: params)
            }
            SwiftSpinner.hide()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinGame(_ sender: UIButton) {
        let username = usernameView.text
        if (username != ""){
            TTTSocket.sharedInstance.socket.emit("join_queue", username!)
            SwiftSpinner.show("Searching other players...")
        }else{
            let alert = CDAlertView(title: "Error", message: "Please enter a name in the Username field", type: .error)
            alert.add(action: CDAlertViewAction(title: "Ok", handler: nil))
            alert.show()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presentOnlineGame"){
            let controller = segue.destination as! OnlineModalController
            controller.setAttrs(params: sender, playerUsername: usernameView.text!)
        }
    }
    
}
