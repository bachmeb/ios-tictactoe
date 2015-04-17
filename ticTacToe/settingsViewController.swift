//
//  settingsViewController.swift
//  ticTacToe
//
//  Created by Marlena Hansen on 4/9/15.
//  Copyright (c) 2015 University of Cincinnati. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    
    @IBOutlet weak var playerButton: UISegmentedControl!
    
    struct playerInfo {
       static var playerType:Bool = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(playerInfo.playerType){
            playerButton.selectedSegmentIndex = 1
        } else {
            playerButton.selectedSegmentIndex = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func playerChange(sender: UISegmentedControl) {
        //1 is x, 0 is o
        var playerIndex = playerButton.selectedSegmentIndex
        //defaults to o
        var playerValue = 0
        
        playerValue = playerIndex
        
        // O is false, X is true
        if(playerValue == 0){
            playerInfo.playerType = false
        } else {
            playerInfo.playerType = true
        }
    }
    
    
    
    

}
