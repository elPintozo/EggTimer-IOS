//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var customProgressBar: UIProgressView!
    
    let eggTime : [String:Float] = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    
    var globalTimer: Timer = Timer()
    var globalTimeCounter : Float = 5
    var globalTimeSelected : Float = 5

    @IBAction func ButtonPressed(_ sender: UIButton) {
        
        let hardness : String = sender.currentTitle!
        loveCalculator(time: eggTime[hardness]!)
    }
    
    func loveCalculator(time : Float){
        titleLabel.text = "Time: \(Int(time)) minutes."
        
        //Reset time
        globalTimer.invalidate()
        
        //Reset Progress bar
        customProgressBar.setProgress(1.0, animated: false)
        
        //assing time
        globalTimeCounter = time
        globalTimeSelected = time
    
        //Schedule timer
        globalTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1),
                             target: self,
                             selector: #selector(ViewController.custonCounter),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func custonCounter(){
        
        if globalTimeCounter >= 1{
            titleLabel.text = "Wait \(Int(globalTimeCounter)) minute."
            customProgressBar.setProgress(calculatePercentage(totalValue: globalTimeSelected, partialValue: globalTimeCounter), animated: true)
            globalTimeCounter = globalTimeCounter-1
            
        }else{
            //stop time
            globalTimer.invalidate()
            
            //assing default time
            globalTimeCounter = 5
            
            // To complete progressbar
            customProgressBar.setProgress(0, animated: true)
            
            titleLabel.text = "It's done."
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
                self.titleLabel.text = "How do you like your eggs?"
            }
        }
    }
    func calculatePercentage(totalValue: Float, partialValue: Float)-> Float {
        return partialValue/totalValue
    }
}
