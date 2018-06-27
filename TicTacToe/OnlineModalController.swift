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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("online modal loaded")
        setButtonsBorder()
        setViewContent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CloseAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil);
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
    
    public func setAttrs(params: Any?){
        let paramsArray = params as! NSArray
        let unwrappedDictJson = paramsArray[0] as! [String: Any]
        self.xPlayerName = unwrappedDictJson["playerX"] as! String?
        self.oPlayerName = unwrappedDictJson["playerO"] as! String?
        self.isXPlayerTurn = unwrappedDictJson["currentTurn"] as! String == "x"
    }

}
