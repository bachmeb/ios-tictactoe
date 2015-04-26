//
//  gridClass.swift
//  ticTacToe
//
//  Created by Marlena Hansen on 4/16/15.
//  Copyright (c) 2015 University of Cincinnati. All rights reserved.
//

import Foundation
import UIKit

class gridClass {
    
    var gridRows : Int!
    var gridColumns : Int!
    var gridTotal : Int!
    
    var buttonCounter = 0
    var buttons : [[UIButton]] = [[]]

    
    
    
    init(rows : Int, columns : Int){
        gridRows = rows
        gridColumns = columns
        gridTotal = gridRows * gridColumns
    }
    

    func createGrid(vc : UIViewController){
        if(gridRows == 3){
            
            createThree(vc, rows: 3, columns: 3)
            
        } else if (gridRows == 4) {
            
            createFour(vc, rows: 4, columns: 4)
            
        } else if (gridRows == 5) {
            
            createFive(vc, rows: 5, columns: 5)
            
        } else {
            
            println("Incorrect Grid Size")
            
        }
    }
    
    func createThree(vc : UIViewController, rows : Int, columns : Int){
        
        //inserting the grid
        var gridImage : UIImage = UIImage(named: "grid3.png")!
        var gridView = UIImageView(image: gridImage)
        
        gridView.frame = CGRect(x: 45, y: 200, width: 300, height: 300)
    
        // Add the grid view to the view controller
        vc.view.addSubview(gridView)
        
        createButton(vc, rows: rows, columns: columns, height: 105) // Hard-coded value
        
    }
    
 
    
    func createFour(vc : UIViewController, rows : Int, columns : Int){
        
        //inserting the grid
        var gridImage : UIImage = UIImage(named: "grid4.png")!
        var gridView = UIImageView(image: gridImage)
        
        gridView.frame = CGRect(x: 45, y: 200, width: 300, height: 300)
        
        vc.view.addSubview(gridView)
        
        createButton(vc, rows: rows, columns: columns, height: 80)
        
    }
  
    func createFive(vc : UIViewController, rows : Int, columns : Int){
     
        //inserting the grid
        var gridImage : UIImage = UIImage(named: "grid5.png")!
        var gridView = UIImageView(image: gridImage)
        
        gridView.frame = CGRect(x: 45, y: 200, width: 300, height: 300)
        
        vc.view.addSubview(gridView)
        
        createButton(vc, rows: rows, columns: columns, height: 62)
        
    }
    
    //inserting buttons
    func createButton(vc : UIViewController, rows : Int, columns : Int, height : Int){

        // Make a temp button
        var tempButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        // 
        buttons = [[UIButton]](count: gamePlayViewController.grid.rows, repeatedValue:[UIButton](count: gamePlayViewController.grid.columns, repeatedValue: tempButton))
        
        for var i = 0; i < gamePlayViewController.grid.rows; i++ {
            for var c = 0; c < gamePlayViewController.grid.columns; c++ {
                
                var xInitial : CGFloat = CGFloat(45 * 1)
                var yInitial : CGFloat = CGFloat(200 * 1)
                
                
                var size : Int = height
                var size2 : CGFloat = CGFloat(height)
                
                var button : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
                    
                var yValue:CGFloat = CGFloat(200 + (size * i))
                var xValue:CGFloat = CGFloat(45 + (size * c))
                
                button.frame = CGRectMake(xValue, yValue, size2, size2)
                
                    
                button.setTitle("\(c) \(i)", forState: UIControlState.Normal)
                button.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
                    
                button.addTarget(vc, action: "checkBox:", forControlEvents: UIControlEvents.TouchUpInside)
                    
                vc.view.addSubview(button)
                    
                buttonCounter++
                buttons[i][c] = button

 
            }
        }
    }
    
    func getButtonCounter() -> Int {
        return buttonCounter
    }
    
    
}