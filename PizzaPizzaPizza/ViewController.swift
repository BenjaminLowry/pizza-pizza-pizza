//
//  ViewController.swift
//  PizzaPizzaPizza
//
//  Created by Ben LOWRY on 2/2/17.
//  Copyright © 2017 Ben LOWRY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //all of our switches
    @IBOutlet weak var pepperoniSwitch: UISwitch!
    @IBOutlet weak var sausageSwitch: UISwitch!
    @IBOutlet weak var cheeseSwitch: UISwitch!
    @IBOutlet weak var spinachSwitch: UISwitch!
    @IBOutlet weak var anchoviesSwitch: UISwitch!
    @IBOutlet weak var pineappleSwitch: UISwitch!
    @IBOutlet weak var canadianBaconSwitch: UISwitch!
    @IBOutlet weak var parmaHamSwitch: UISwitch!
    
    //the button we press to make pizza
    @IBOutlet weak var makePizzaButton: UIButton!

    //dictionary to keep track of what toppings we want
    var toppingDictionary: [String: Bool] = [String: Bool]()
    
    //our pizza image view
    var pizzaImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //we don't want any toppings selected to begin with
        //we must also do this to initialize the 'key' values
        toppingDictionary = ["Pepperoni": false, "Sausage": false, "Cheese": false, "Spinach": false, "Anchovies": false, "Pineapple": false, "Canadian Bacon": false, "Parma Ham": false, "Other Topping": false]
    }

    @IBAction func switchFlipped(_ sender: UISwitch) {
        //find which switch was flipped, and update the dictionary
        switch sender {
        case pepperoniSwitch: //the pepperoni switch was flipped
            toppingDictionary["Pepperoni"] = sender.isOn //so set the dictionary value for "pepperoni" to the value of the switch
        case sausageSwitch:
            toppingDictionary["Sausage"] = sender.isOn
        case cheeseSwitch:
            toppingDictionary["Cheese"] = sender.isOn
        case spinachSwitch:
            toppingDictionary["Spinach"] = sender.isOn
        case anchoviesSwitch:
            toppingDictionary["Anchovies"] = sender.isOn
        case pineappleSwitch:
            toppingDictionary["Pineapple"] = sender.isOn
        case canadianBaconSwitch:
            toppingDictionary["Canadian Bacon"] = sender.isOn
        case parmaHamSwitch:
            toppingDictionary["Parma Ham"] = sender.isOn
        default:
            print("error")
        }
    }
    
    @IBAction func makePizza(_ sender: UIButton) {
        
        //an array to hold the toppings we want
        var toppings = [String]()
        
        //loop through each key in our topping dictionary
        for key in toppingDictionary.keys {
            
            //if we want a specific topping
            if toppingDictionary[key] == true {
                //add the topping to our list
                toppings.append(key)
            }
        }
        
        //the string we will add to our alert
        var alertString = String()
        
        //loop through our list of desired toppings
        for topping in toppings {
            
            //if we are at the last desired topping, we need to change how we append the string
            if toppings.index(of: topping) == toppings.count - 1 {
                
                //add an "and" before the topping name so our message makes grammatical sense
                alertString += "and \(topping)"
                
            } else { //if the topping is not the last desired topping
                
                //add our topping to the string with a comma and space
                alertString += "\(topping), "
            }
        }
        
        //create a new alert for us to show
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want a pizza with \(alertString)?", preferredStyle: .actionSheet)
        
        //create an action for the user to confirm that they want the pizza
        let confirmAction = UIAlertAction(title: "Yes", style: .default, handler: {
            alert in
            //if they select this option:
            
            //disable the button
            sender.isUserInteractionEnabled = false
            
            //start the countdown
            self.countdownButton()
        })
        
        //create an action for the user to decline making the pizza
        let cancelAction = UIAlertAction(title: "Nah...", style: .cancel, handler: nil)
        
        //add our actions to our alert
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        //show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func countdownButton() {
        
        //our pizza will take five seconds to make
        var secondsLeft = 5
        
        //set the title of our button to show how much time it will take
        makePizzaButton.setTitle("Your pizza will be ready in \(secondsLeft) seconds!", for: .normal)
        
        //create a timer that will change our button every second
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            
            //one second has passed, so deincrement how many seconds are left
            secondsLeft -= 1
            
            //if there are no seconds left
            if secondsLeft == 0 {
                
                //stop the timer
                timer.invalidate()
                
                //our pizza is ready, so call this function
                self.pizzaReady()
            }
            
            //update the text of our button to show changing time left
            UIView.performWithoutAnimation {
                self.makePizzaButton.setTitle("Your pizza will be ready in \(secondsLeft) seconds!", for: .normal)
                self.makePizzaButton.layoutIfNeeded()
            }
            
        })
        
    }
    
    func pizzaReady() {
        
        //set our imageView variable to a new UIImageView
        pizzaImageView = UIImageView(frame: self.view.frame)
        
        //set the imageView's image to our pizza image
        pizzaImageView.image = #imageLiteral(resourceName: "Pepperoni-Pizza.png")
        
        //make it so the pizza image scales properly
        pizzaImageView.contentMode = .scaleAspectFit
        
        //add our imageView to the screen
        self.view.addSubview(pizzaImageView)
        
        //create a new label that we can use to show a message
        let label = UILabel(frame: self.view.frame)
        
        //set the label's font
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        
        //give the label a message
        label.text = "Your pizza's ready!"
        
        //center the text of the label on the screen
        label.textAlignment = .center
        
        //add the label on top of our image
        pizzaImageView.addSubview(label)
        
        //create an object that will sense when we tap on the image, and then call our "reset" func
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reset))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    func reset() {
        
        //enable the button so it can be pressed again
        makePizzaButton.isUserInteractionEnabled = true
        
        //reset the text of our makePizzaButton
        makePizzaButton.setTitle("Make my pizza!", for: .normal)
        
        //hide the imageView
        pizzaImageView.removeFromSuperview()
        
        //loop through the views on the screen
        for view in view.subviews {
            
            //find all of the switches
            if let mySwitch = view as? UISwitch {
                
                //make sure the switch is turned off
                mySwitch.isOn = false
            }
        }
        
        //loop through our dictionary values and reset them to "false"
        for key in toppingDictionary.keys {
            toppingDictionary[key] = false
        }
    }

}

