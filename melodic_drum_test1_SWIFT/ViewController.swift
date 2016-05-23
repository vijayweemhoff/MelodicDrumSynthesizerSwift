//
//  ViewController.swift
//  melodic_drum_test1_SWIFT
//
//  Created by Vijay Weemhoff on 10-05-16.
//  Copyright © 2016 Vijay Weemhoff. All rights reserved.
//

import UIKit
import AudioKit

var mutArray : NSMutableArray = ["List is empty"]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        //make test tone
      playSound();
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var xMutArray = 0;
    var counterAddArray=0;
    var countPlus=0;

    @IBAction func tapButtonPressedDown(sender: UIButton) {
        //NSLog("tap!");
        
        let stringForTextField = String(mutArray[xMutArray]);
        xMutArray=xMutArray+1;
        
        //check if mutArray is empty, to not show "List is Empty"
        if(counterAddArray>=1)
        {
        countPlus=1;
        }
        else
        {
            countPlus=0;
        }
        
        //check if index is equal to how many objects there are in the mutArray
        // +1 is necessary to lose the "List is Empty" note
        // countPlus is to lose "List is empty" when there are objects added to mutArray
        if(xMutArray>=(counterAddArray+1))
        {
            xMutArray=(0+countPlus);
        }
        
        //NSLog("xMutArray: %d", xMutArray);
        
        showArrayTextField.text = stringForTextField;
    }
    
    @IBAction func addToArrayPressedDown(sender: UIButton) {
        //xMutArray is 1 to lose the "List is Empty" line
        xMutArray=1;
        
        counterAddArray=counterAddArray+1;
        
        //create a random MIDI value to simulate not yet existing keyboard
        let randomMIDI = Int(arc4random_uniform(126)+1);
        mutArray.addObject(randomMIDI);
        //NSLog("counterAddArray is: %d",counterAddArray);
        NSLog("array is: %@",mutArray);
    }
    
    
    @IBAction func clearListButtonPressedTouchUpInside(sender: UIButton) {
        xMutArray=0;
        counterAddArray=0;
        mutArray.removeAllObjects();
        mutArray.addObject("List is empty");
    }
    
    @IBAction func deleteLastObjectPressedTouchUpInside(sender: UIButton) {
        //NSLog("Delete last object is pressed");
        //NSLog("counterAddArray is: %d",counterAddArray);
        if(counterAddArray==0)
        {
            xMutArray=0;
        }
        else
        {
        xMutArray=1;
        }
        
        if(counterAddArray>0)
        {
             mutArray.removeLastObject();
             counterAddArray=counterAddArray-1;
             if(counterAddArray==0)
             {
                xMutArray=0;
             }
        }
        else
        {
            //NSLog("Can't delete anymore");
            showArrayTextField.text = "Can't delete anymore";
        }

    }
    
    var octaveState = 0;
    
    @IBAction func octaveDownPressedDown(sender: UIButton) {

        if(octaveState <= -36)
        {
            NSLog("octave state is -36")
        }
        else
        {
            octaveState=octaveState-12;
        }
        NSLog("octaveState is: %d",octaveState);
        showOctaveState.text = String(octaveState);
    }
    
    @IBAction func octaveUpPressedDown(sender: UIButton) {
        if(octaveState>=36)
        {
        }
        else
        {
            octaveState=octaveState+12;
        }
        NSLog("octaveState is: %d",octaveState);
        showOctaveState.text = String(octaveState);
    }
    
    
    func receiveKeyboard(inputKeyboard: Int)
    {   //add buttons to put octave up or down
        let inputAfterOctaveSwitch = (inputKeyboard+octaveState);
        NSLog("input after octave switch %d",inputAfterOctaveSwitch);
        
        //xMutArray is 1 to lose the "List is Empty" line
        counterAddArray=counterAddArray+1;
        xMutArray=1;
        
        //add element to array
        mutArray.addObject(inputAfterOctaveSwitch);
        // display element in text field
        showArrayTextField.text = String(inputAfterOctaveSwitch);
    }
 
 
    @IBAction func cKeyPressed2(sender: UIButton) {
        //NSLog("I'm a C key!");
        receiveKeyboard(60);
    }
    
    @IBAction func cSharpKeyPressed(sender: UIButton) {
        //NSLog("I'm a C# key!")
        receiveKeyboard(61);
    }
    
    @IBAction func dKeyPressed(sender: UIButton) {
        //NSLog("I'm a D key!")
        receiveKeyboard(62);
    }
    
    @IBAction func dSharpKeyPressed(sender: UIButton) {
        //NSLog("I'm a D# key!")
        receiveKeyboard(63);
    }
    
    @IBAction func eKeyPressed(sender: UIButton) {
        //NSLog("I'm a E key!")
        receiveKeyboard(64);
    }
    
    @IBAction func fKeyPressed(sender: UIButton) {
        //NSLog("I'm a F key!")
        receiveKeyboard(65);
    }

    @IBAction func fSharpKeyPressed(sender: UIButton) {
        //NSLog("I'm a F# key!")
        receiveKeyboard(66);
    }
    
    @IBAction func gKeyPressed(sender: UIButton) {
        //NSLog("I'm a G key!")
        receiveKeyboard(67);
    }
    
    @IBAction func gSharpKeyPressed(sender: UIButton) {
        //NSLog("I'm a G# key!")
        receiveKeyboard(68);
    }
    
    @IBAction func aKeyPressed(sender: UIButton) {
        //NSLog("I'm a A key!")
        receiveKeyboard(69);
    }
    
    @IBAction func aSharpKeyPressed(sender: UIButton) {
        //NSLog("I'm a A# key!")
        receiveKeyboard(70);
    }
    
    @IBAction func bKeyPressed(sender: UIButton) {
        //NSLog("I'm a B key!")
        receiveKeyboard(71);
    }
    
    
    @IBOutlet weak var showArrayTextField: UITextField!
    
    @IBOutlet weak var showOctaveState: UITextField!
  
  
  //include voice
  var voice = Voice.sharedInstance;
  
  
  func playSound() {
    AudioKit.start()
    voice.start();
    
    //TODO's
    //rename Instrument.swift -> Voice
    //rename "AudioSystem group -> Audio
    
    //correcte output pakken: 
      //-sourceMixer ipv osc als output. Dit werkend krijgen met geluid.
      //-adsr werkend krijgen
    
    //AudioSysteem class of iets dergelijks toevoegen, 
      //- output op 'AudioSysteem object' level verbinden ipv instrument level'
      //-deze kan je vanuit je viewController de midi noten e.d. sturen
    
    //tap button connecten aan ViewController -> audioSysteem
    
    
  
  }
  
}

