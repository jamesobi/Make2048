//
//  Tile.swift
//  Make2048
//
//  Created by James Sobieski on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

enum Value {
    case Two, Four, Eight, Sixteen, ThirtyTwo, SixtyFour, OneTwentyEight, TwoFiftySix, FiveTwelve, OneThousandTwentyFour, TwentyFortyEight, None
    
}
class Tile: CCNodeColor {
    weak var backgroundColorNode:CCNodeColor!
    weak var valueLabel:CCLabelTTF!
    
    
    let height = 70
    let width = 70
    
    var value:Value = .None {
        didSet {
            
            switch value {
            case .Two:
                self.valueLabel.string = "2"
                self.backgroundColorNode.color = CCColor.blueColor()
            
            case .Four:
                self.valueLabel.string = "4"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .Eight:
                self.valueLabel.string = "8"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .Sixteen:
                self.valueLabel.string = "16"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .ThirtyTwo:
                self.valueLabel.string = "32"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .SixtyFour:
                self.valueLabel.string = "64"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .OneTwentyEight:
                self.valueLabel.string = "128"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .TwoFiftySix:
                self.valueLabel.string = "256"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .FiveTwelve:
                self.valueLabel.string = "512"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .OneThousandTwentyFour:
                self.valueLabel.string = "1024"
                self.backgroundColorNode.color = CCColor.blueColor()
            
            case .TwentyFortyEight:
                self.valueLabel.string = "2048"
                self.backgroundColorNode.color = CCColor.blueColor()
                
            case .None:
                self.valueLabel.string = "0"
                self.backgroundColorNode.color = CCColor.grayColor()
                
            default:
                self.valueLabel.string = "-1"
            }
            
        
        }
    }
    
    
}