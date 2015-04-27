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
    
    var gridClassRows : Int!
    var gridClassColumns : Int!
    var gridClassTotal : Int!
    
    var gridClassX : Int!
    var gridClassY : Int!
    var gridClassWidth : Int!
    var gridClassHeight : Int!
    
    var gridClassButtonRoot3 : Int!
    var gridClassButtonRoot4 : Int!
    var gridClassButtonRoot5 : Int!
    
    var buttonCounter = 0
    var buttons : [[UIButton]] = [[]] // 2-dimensional array
    
    //
    init(rows : Int, columns : Int){
        gridClassRows = rows
        gridClassColumns = columns
        gridClassTotal = gridClassRows * gridClassColumns
        
        gridClassX = 10
        gridClassY = 200
        gridClassHeight = 300
        gridClassWidth = 300
        
        gridClassButtonRoot3 = 105
        gridClassButtonRoot4 = 80
        gridClassButtonRoot5 = 62
        
    }
    
    // Called by gamePlayViewController
    func createGrid(vc : UIViewController){
        
        //inserting the grid. default to 3
        var gridImage : UIImage = UIImage(named: "grid3.png")!
        if (gridClassRows == 4) {gridImage = UIImage(named: "grid4.png")!}
        else if (gridClassRows == 5) {gridImage = UIImage(named: "grid5.png")!}

        // Add the gridImage to the gridImageView
        var gridImageView = UIImageView(image: gridImage)
        
        // Center the image
        //        gridImageView.contentMode = UIViewContentMode.ScaleToFill
        
        // Set the frame of the gridImageView
        gridImageView.frame = CGRect(x: gridClassX, y: gridClassY, width: gridClassWidth, height: gridClassHeight)
        
        // Add the grid view to the view controller
        vc.view.addSubview(gridImageView)
        
        
        if (gridClassRows == 3) {
            createButtons(vc, rows: gridClassRows, columns: gridClassColumns, height: gridClassButtonRoot3) // Hard-coded value
        }
        else if (gridClassRows == 4) {
            createButtons(vc, rows: gridClassRows, columns: gridClassColumns, height: gridClassButtonRoot4) // Hard-coded value
        }
        else if (gridClassRows == 5) {
            createButtons(vc, rows: gridClassRows, columns: gridClassColumns, height: gridClassButtonRoot5)  // Hard-coded value
        }
        
    }

    
    // Create all of the UI buttons
    func createButtons(vc : UIViewController, rows : Int, columns : Int, height : Int){ // This should ask for a x,y position for the top left corner

        // Make a temp button
        var tempButton : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        // make an array of buttons
        buttons = [[UIButton]](count: gamePlayViewController.gridStruct.rows, repeatedValue:[UIButton](count: gamePlayViewController.gridStruct.columns, repeatedValue: tempButton))
        
        for var i = 0; i < gamePlayViewController.gridStruct.rows; i++ {
            for var c = 0; c < gamePlayViewController.gridStruct.columns; c++ {
                
                var xInitial : CGFloat = CGFloat(gridClassX * 1)  // This value can be derived from the x property of gridview.frame
                var yInitial : CGFloat = CGFloat(gridClassY * 1)
                
                // how tall is the button
                var squareRootInt : Int = height
                var squareRootFloat : CGFloat = CGFloat(squareRootInt)
                
                //TODO: What does buttonWithType do?
                var button : UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton

                // increment the position of each button by the size of each button
                var yValue:CGFloat = CGFloat(Int(yInitial) + (squareRootInt * i))
                var xValue:CGFloat = CGFloat(Int(xInitial) + (squareRootInt * c))
                
                // Frame: Setting this property changes the point specified by the center property and the size in the bounds rectangle accordingly. The coordinates of the frame rectangle are always specified in points.
                button.frame = CGRectMake(xValue, yValue, squareRootFloat, squareRootFloat)
                
                // The title of the button is the row concat with the column number
                button.setTitle("\(c) \(i)", forState: UIControlState.Normal)
                
                // Make the button see-through
                button.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
                
                // The target object—that is, the object to which the action message is sent.
                button.addTarget(vc, action: "checkBox:", forControlEvents: UIControlEvents.TouchUpInside)
                
                // Add the button to the view
                vc.view.addSubview(button)
                
                // Increment the counter
                buttonCounter++
                
                // Assign the button to the buttons array
                buttons[i][c] = button
 
            }
        }
    }
    
    func getButtonCounter() -> Int {
        return buttonCounter
    }
    
    
}