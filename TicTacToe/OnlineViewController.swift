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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print("online view loaded")
        TTTSocket.sharedInstance.socket.on("join_game") { (params, emitter) in
            print(params, emitter)
            self.performSegue(withIdentifier: "presentOnlineGame", sender: nil)
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
            //todo create loader
        }else{
            let alert = UIAlertController(title: "Error", message: "Please enter a name in the Username field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "join_game"){
            //let controller = segue.destination as! OnlineModalController
            //use sender to set up some data
        }
    }
    
}
