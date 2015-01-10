//
//  ViewController.swift
//  BullsEye
//
//  Created by Mosab Elagha on 12/21/14.
//  Copyright (c) 2014 edu.illinois.melagha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	/* variables */
    var currentValue  = 0 //need to initialize to something ... Swift requirement?
	var targetValue = 0
	var score: Int = 0
	var round = 0
	
    @IBOutlet weak var slider: UISlider!	//slider outlet. can find/set current value by using slider.value
	@IBOutlet weak var targetLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var roundLabel: UILabel!
	
	/* functions */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
		slider.setThumbImage(thumbImageNormal, forState: .Normal)
		
		let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
		slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
		
		let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
		
		if let trackLeftImage = UIImage(named: "SliderTrackLeft")
		{
			let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
			slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
		}
		
		if let trackRightImage = UIImage(named: "SliderTrackRight")
		{
			let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
			slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
		}
		
		startNewGame()
		updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startNewRound()
	{
		currentValue = Int(slider.value)
		targetValue = 1 + Int(arc4random_uniform(100))
		round++
	}
    
    @IBAction func sliderMoved(slider: UISlider)
    {
        currentValue = lroundf(slider.value)
    }
	
	func updateLabels()
	{
		targetLabel.text = String(targetValue)
		scoreLabel.text = String(score)
		roundLabel.text = String(round)
	}
	
	func calculateScore() -> Int
	{
		var score: Int = 100
		
		let difference = Int(abs(currentValue - targetValue))
		
		return score - difference
	}
	@IBAction func startNewGame()
	{
		score = 0;
		round = 0;
		startNewRound()
		updateLabels()
	}
	@IBAction func showAlert()
	{
		var currScore = calculateScore()
		
		var title = "No score"
		
		if currScore == 100{
			title = "Bull's Eye!!"
			currScore += 100
		}
		else if currScore > 98 {
			title = "Almost!"
			currScore += 50
		}
		else if currScore > 95 {
			title = "Pretty close!"
		}
		else if currScore > 90 {
			title = "You can do better"
			currScore -= 50
		}
		else{
			title = "Not even close"
			currScore = 100 - -1*currScore
		}
		
		let message = "You hit \(currentValue)\n" + "You scored \(currScore) points"
		score += currScore
		
		let alert = UIAlertController(  title: title , message: message, preferredStyle: .Alert)
		
		let action = UIAlertAction( title: "OK", style: .Default, handler: { action in
																		self.startNewRound()
																		self.updateLabels()
																	})
		
		
		alert.addAction(action)         //add a popout to the alert
		
		//make alert visible
		presentViewController(alert, animated: true, completion: nil)
	}
}

