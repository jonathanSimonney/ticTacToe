//
//  OnlineModalController.swift
//  TicTacToe
//
//  Created by SUP'Internet 14 on 30/01/2018.
//  Copyright © 2018 SUP'Internet 14. All rights reserved.
//

import UIKit

class OnlineModalController: UIViewController {
    
    @IBOutlet weak var xPlayer: UILabel!
    @IBOutlet weak var oPlayer: UILabel!
    @IBOutlet weak var currentTurn: UILabel!
    
    var xPlayerName :String?
    var oPlayerName :String?
    var isXPlayerTurn :Bool?
    var board :Board!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.board = Board()
        setButtonsBorder()
        setViewContent()
        TTTSocket.sharedInstance.socket.on("movement") { (params, _) in
            self.updateGrid(params: params)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        if self.board.canPlayInBox(boxNumber: sender.tag){
            let boxPlayedNumber = sender.tag - 1
            TTTSocket.sharedInstance.socket.emit("movement", boxPlayedNumber)
        }else{
            self.showError(errorType: "wrong_movement")
        }
    }
    
    public func setAttrs(params: Any?){
        let unwrappedDictJson = self.unwrappReturn(params: params)
        self.xPlayerName = unwrappedDictJson["playerX"] as! String?
        self.oPlayerName = unwrappedDictJson["playerO"] as! String?
        self.isXPlayerTurn = unwrappedDictJson["currentTurn"] as! String == "x"
    }
    
    private func setButtonsBorder(){
        for i in 1...9{
            let button = self.view.viewWithTag(i) as? UIButton
            button?.layer.borderColor = UIColor.black.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    private func setViewContent(){
        self.xPlayer.text = "Player X : " + self.xPlayerName!
        self.oPlayer.text = "Player O : " + self.oPlayerName!
        let currentPlayer = self.isXPlayerTurn! ? "Player X" : "Player O"
        self.currentTurn.text = "Current turn : " + currentPlayer
    }
    
    private func unwrappReturn(params: Any?) -> [String: Any]{
        let paramsArray = params as! NSArray
        return paramsArray[0] as! [String: Any]
    }
    
    private func updateGrid(params: Any?){
        let unwrappedDictJson = self.unwrappReturn(params: params)
        print(unwrappedDictJson)
        if (unwrappedDictJson["error"] == nil){
            print(unwrappedDictJson)
            self.makeMovement(params: unwrappedDictJson)
        }else{
            self.showError(errorType: unwrappedDictJson["err"] as! String)
        }
        //errors possible : game_finished, not_your_turn
    }
    
    private func makeMovement(params: [String: Any]){
        params["index"]
        params["player_played"]
        params["win"]
        params["player_play"]
    }
    
    private func showError(errorType: String){
        var errorMessage: String
        
        switch errorType{
        case "wrong_movement":
            errorMessage = "You can't play if the box is already full!"
        case "game_finished":
            errorMessage = "The game is already finished, you can't keep playing!"
        case "not_your_turn":
            errorMessage = "It's not your turn!"
        default:
            errorMessage = "Unknown error, please report the problem."
        }
        
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
