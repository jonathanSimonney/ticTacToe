//
//  OnlineViewController.swift
//  TicTacToe
//
//  Created by SUP'Internet 14 on 30/01/2018.
//  Copyright © 2018 SUP'Internet 14. All rights reserved.
//

import UIKit

class OnlineViewController: ViewController {
    
    @IBOutlet weak var usernameView: UITextField!
    var sv: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print("online view loaded")
        TTTSocket.sharedInstance.socket.on("join_game") { (params, emitter) in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "presentOnlineGame", sender: params)
            }
            UIViewController.removeSpinner(spinner: self.sv)
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
            self.sv = UIViewController.displaySpinner(onView: self.view)
        }else{
            let alert = UIAlertController(title: "Error", message: "Please enter a name in the Username field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presentOnlineGame"){
            let controller = segue.destination as! OnlineModalController
            controller.setAttrs(params: sender, playerUsername: usernameView.text!)
        }
    }
    
}
