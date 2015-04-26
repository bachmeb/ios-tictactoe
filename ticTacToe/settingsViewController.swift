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
    @IBOutlet weak var computerButton: UISegmentedControl!
    @IBOutlet weak var gridPicker: UIPickerView!
    
    var grids : NSArray = ["3 x 3", "4 x 4", "5 x 5"]
    
    struct playerInfo {
        static var playerType:Bool = false
        static var computerOn:Bool = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(playerInfo.playerType){
            playerButton.selectedSegmentIndex = 1
        } else {
            playerButton.selectedSegmentIndex = 0
        }
        
        if(playerInfo.computerOn){
            computerButton.selectedSegmentIndex = 0
        } else {
            computerButton.selectedSegmentIndex = 1
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grids.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString! {
        var gridOptions = NSAttributedString(string: grids[row] as! String, attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return gridOptions
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var grid = gridPicker.selectedRowInComponent(0)
        var gridSelected = grids.objectAtIndex(grid) as! String
        
        if(grid == 0){
            gamePlayViewController.grid.rows = 3
            gamePlayViewController.grid.columns = 3
        } else if (grid == 1){
            gamePlayViewController.grid.rows = 4
            gamePlayViewController.grid.columns = 4
        } else if (grid == 2){
            gamePlayViewController.grid.rows = 5
            gamePlayViewController.grid.columns = 5
        } else {
            gamePlayViewController.grid.rows = 3
            gamePlayViewController.grid.columns = 3
        }
        
        
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
    
    @IBAction func computerChange(sender: UISegmentedControl) {
       
        var computerIndex = playerButton.selectedSegmentIndex
        //defaults to no
        var computerValue = 1
        
        computerValue = computerIndex
        
        if (computerValue == 1){
            playerInfo.computerOn = false
        } else {
            playerInfo.computerOn = true
        }
        
        
    }
    
    
    
    
}
