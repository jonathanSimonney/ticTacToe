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
    var isOurPlayerX :Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        if !self.isOurPlayerTurn(){
            self.showError(errorType: "not_your_turn")
            return
        }
        let boxPlayedNumber = sender.tag - 1
        TTTSocket.sharedInstance.socket.emit("movement", boxPlayedNumber)
    }
    
    public func setAttrs(params: Any?, playerUsername: String){
        let unwrappedDictJson = self.unwrappReturn(params: params)
        self.xPlayerName = unwrappedDictJson["playerX"] as! String?
        self.oPlayerName = unwrappedDictJson["playerO"] as! String?
        self.isXPlayerTurn = unwrappedDictJson["currentTurn"] as! String == "x"
        self.isOurPlayerX = playerUsername == self.xPlayerName
    }
    
    private func setButtonsBorder(){
        for i in 1...9{
            let button = self.view.viewWithTag(i) as? UIButton
            button?.layer.borderColor = UIColor.black.cgColor
            button?.layer.borderWidth = 2
        }
    }
    
    private func isOurPlayerTurn() -> Bool{
        if (self.isOurPlayerX)!{
            return isXPlayerTurn!
        }
        return !isXPlayerTurn!
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
        if (unwrappedDictJson["err"] is NSNull){
            self.makeMovement(params: unwrappedDictJson)
        }else{
            print(unwrappedDictJson["err"])
            self.showError(errorType: unwrappedDictJson["err"] as! String)
        }
        //errors possible : wrong_movement, game_finished
    }
    
    private func makeMovement(params: [String: Any]){
        params["index"]
        params["win"]
        params["grid"]
        print(params)
        
        self.setImageInBox(boxNumber: params["index"] as! Int + 1)
        self.updateCurrentPlayerTurn()
    }
    
    private func setImageInBox(boxNumber: Int){
        let currentPlayerId = self.isOurPlayerTurn() ? 1 : 0
        let buttonTouched = self.view.viewWithTag(boxNumber) as! UIButton
        
        let currentPlayerPicture = UIImage(named: "picturePlayer" + String(currentPlayerId)+".png")
        buttonTouched.setImage(currentPlayerPicture, for: .normal)
    }
    
    private func updateCurrentPlayerTurn(){
        self.isXPlayerTurn = !self.isXPlayerTurn!
        let currentPlayer = self.isXPlayerTurn! ? "Player X" : "Player O"
        self.currentTurn.text = "Current turn : " + currentPlayer
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
