//
//  ViewController.swift
//  melodic_drum_test1_SWIFT
//
//  Created by Vijay Weemhoff on 10-05-16.
//  Copyright © 2016 Vijay Weemhoff. All rights reserved.
//

import UIKit
import Foundation
import AudioKit

var mutArray : NSMutableArray = ["List is empty"]
var velocityArray : NSArray = [20.0,40.0,60.0,80.0,100.0,120.0]

class ViewController: UIViewController {

    @IBOutlet weak var octaveDown: UIButton!
    @IBOutlet weak var octaveUp: UIButton!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    let numberOfButtons = 36
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //NSLog("ViewController did load..")
        
        //set Preset Control values
        setDefaultValues()
        
        //set up scrollable keyBoard
        setupKeyboard()
        
        tapButton.layer.cornerRadius = 4
        octaveDown.layer.cornerRadius = 4
        octaveUp.layer.cornerRadius = 4
        
        //NSLog("%@",velocityArray.count)
    
    }
    
    func setupKeyboard()
    {
        for index in 0..<self.numberOfButtons {
            var buttonHeight=0
            var buttonWidth=0
            var buttonX=0
            var plusIndexBlack=0
            var minIndexWhite=0
            
            if(index>=12&&index<24)
            {
                plusIndexBlack=420
                minIndexWhite=300
            }
            
            if(index>=24)
            {
                plusIndexBlack=840
                minIndexWhite=600
            }
            
            switch(index%12){
            case 0:
                buttonX = (index * 60)-minIndexWhite
                buttonHeight=191
                buttonWidth=60
            case 1:
                buttonX = (index * 60)-minIndexWhite
                buttonHeight=191
                buttonWidth=60
            case 2:
                buttonX = (index * 60)-minIndexWhite
                buttonHeight=191
                buttonWidth=60
            case 3:
                buttonX = (index * 60)-minIndexWhite
                buttonHeight = 191
                buttonWidth=60
            case 4:
                buttonX = (index * 60)-minIndexWhite
                buttonHeight=191
                buttonWidth=60
            case 5:
                buttonX = (index * 60)-minIndexWhite
                buttonHeight=191
                buttonWidth=60
            case 6:
                buttonX = (index * 60)-minIndexWhite
                buttonHeight = 191
                buttonWidth=60
            case 7:
                buttonX = 40 + plusIndexBlack
                buttonHeight = 126
                buttonWidth=40
            case 8:
                buttonX = 100 + plusIndexBlack
                buttonHeight = 126
                buttonWidth=40
            case 9:
                buttonX = 220 + plusIndexBlack
                buttonHeight=126
                buttonWidth=40
            case 10:
                buttonX = 280 + plusIndexBlack
                buttonHeight = 126
                buttonWidth=40
            case 11:
                buttonX = 340 + plusIndexBlack
                buttonHeight=126
                buttonWidth=40
            default: break
            }
            let frame1 = CGRect(x: 0  +  buttonX, y: 0, width: buttonWidth, height: buttonHeight)
            let button = UIButton(frame: frame1)
            button.setTitle("", forState: .Normal)
            
            switch(index%12){
            case 0:
                button.backgroundColor = UIColor.whiteColor()
            case 1:
                button.backgroundColor = UIColor.whiteColor()
            case 2:
                button.backgroundColor = UIColor.whiteColor()
            case 3:
                button.backgroundColor = UIColor.whiteColor()
            case 4:
                button.backgroundColor = UIColor.whiteColor()
            case 5:
                button.backgroundColor = UIColor.whiteColor()
            case 6:
                button.backgroundColor = UIColor.whiteColor()
            case 7:
                button.backgroundColor = UIColor.blackColor()
            case 8:
                button.backgroundColor = UIColor.blackColor()
            case 9:
                button.backgroundColor = UIColor.blackColor()
            case 10:
                button.backgroundColor = UIColor.blackColor()
            case 11:
                button.backgroundColor = UIColor.blackColor()
            default: break
            }
            button.layer.cornerRadius = 4
            button.layer.borderWidth=1
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.addTarget(self, action: #selector(buttonAction), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = index
            
            self.scrollView.addSubview(button)
            
        }
        //set width off scrollView
        self.scrollView.contentSize.width = CGFloat(1260)
    }
    
    
    func buttonAction(sender:UIButton!)
    {
        let buttonTag:UIButton = sender
        var key="C"
        var plusOctave=0
        
        if(buttonTag.tag>=12&&buttonTag.tag<24)
        {
            plusOctave=12
        }
        if(buttonTag.tag>=24)
        {
            plusOctave=24
        }
        
        switch(buttonTag.tag%12) {
        case 0:
            key="C"
            receiveKeyboard(48+plusOctave)
        case 1:
            key="D"
            receiveKeyboard(50+plusOctave)
        case 2:
            key="E"
            receiveKeyboard(52+plusOctave)
        case 3:
            key="F"
            receiveKeyboard(53+plusOctave)
        case 4:
            key="G"
            receiveKeyboard(55+plusOctave)
        case 5:
            key="A"
            receiveKeyboard(57+plusOctave)
        case 6:
            key="B"
            receiveKeyboard(59+plusOctave)
        case 7:
            key="C#"
            receiveKeyboard(49+plusOctave)
        case 8:
            key="D#"
            receiveKeyboard(51+plusOctave)
        case 9:
            key="F#"
            receiveKeyboard(54+plusOctave)
        case 10:
            key="G#"
            receiveKeyboard(56+plusOctave)
        case 11:
            key="A#"
            receiveKeyboard(58+plusOctave)
        default: break
        }
        //NSLog("key: %@",key)
        //NSLog("tag %d",buttonTag.tag)
        
        // display element in text field
        showArrayTextField.text = key;
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var conductor = Conductor.sharedInstance
    
    func setDefaultValues() {
        
        // Set Preset Values
        conductor.masterVolume.volume = 25.0 // Master Volume
        conductor.core.offset1 = 0 // VCO1 Semitones
        conductor.core.offset2 = 0 // VCO2 Semitones
        conductor.core.detune = 0.0 // VCO2 Detune (Hz)
        conductor.core.vcoBalance = 0.5 // VCO1/VCO2 Mix
        conductor.core.subOscMix = 0.0 // SubOsc Mix
        conductor.core.fmOscMix = 0.0 // FM Mix
        conductor.core.fmMod = 0.0 // FM Modulation Amt
        conductor.core.morph = 0.0 // Morphing between waveforms
        conductor.core.noiseMix = 0.0 // Noise Mix
        conductor.reverb.feedback = 0.88 // Amt
        conductor.reverbMixer.balance = 0.4 // Dry/Wet
        conductor.midiBendRange = 2.0 // MIDI bend range in +/- semitones

        // ADSR
        conductor.core.attackDuration = 0.1
        conductor.core.decayDuration = 0.1
        conductor.core.sustainLevel = 0.001
        conductor.core.releaseDuration = 0
    }
    
    var counterKeyPressed=0;
    var midiNote = 0;
    var lastMidiNote = 0;
    
    var xVelocityArray=0;
    var velocity=0;
    var velocity2=0.0;
    var timer = NSTimer()
    
    var showArray=0
    func loopInList(){
        if(showArray>=mutArray.count-1){
            showArray=0
        }
        
        showArray=showArray+1
    }

    @IBAction func tapButtonPressedDown(sender: UIButton) {

        if(mutArray.count==1){
            showArrayTextField.text = "List is empty"
        }
        
        var stringForTextField = ""
        
        //Frequency wordt alleen aangepast wanneer er iets in de array gedaan is.
        if(mutArray.count>1)
        {
            //firing loopInList changes Int: showArray
            loopInList()
            showArrayTextField.text = String(mutArray[showArray])
            
            switch(Int(mutArray[showArray] as! NSNumber)%12)
            {
            case 0:
                stringForTextField="C"
            case 1:
                stringForTextField="C#"
            case 2:
                stringForTextField="D"
            case 3:
                stringForTextField="D#"
            case 4:
                stringForTextField="E"
            case 5:
                stringForTextField="F"
            case 6:
                stringForTextField="F#"
            case 7:
                stringForTextField="G"
            case 8:
                stringForTextField="G#"
            case 9:
                stringForTextField="A"
            case 10:
                stringForTextField="A#"
            case 11:
                stringForTextField="B"
            default: break
            }
            showArrayTextField.text = stringForTextField;
            
            //preparing for launching a note in AudioKit
            
            midiNote = Int(mutArray[showArray] as! NSNumber);
            
            counterKeyPressed=counterKeyPressed+1;
            //voice.receivedMIDINoteOn(avAudioNode, note: Double(mutArray[xMutArray] as! NSNumber), velocity: 80)
            /// Sustain Level
            
            
            if(counterKeyPressed>0)
            {
                conductor.core.stopNote(lastMidiNote)
                NSLog("killing the last note")
            }
            
            
            if(xVelocityArray>5)
            {
                xVelocityArray=0;
            }
            
            velocity = Int(velocityArray[xVelocityArray] as! NSNumber);
            velocity2 = Double(velocityArray[xVelocityArray] as! NSNumber);
            xVelocityArray=xVelocityArray+1;
            NSLog("veloctiy is: %d",velocity)
            
            
            //initialize adsr
            conductor.core.attackDuration = 0.1
            conductor.core.decayDuration = 0.1
            conductor.core.sustainLevel = 0.8
            conductor.core.releaseDuration = (velocity2/63.5)-0.2
            
            let release = (velocity2/63.5)-0.2
            NSLog("release: %f",release)
            
            let velocityTime = velocity2/90.0
            NSLog("velocityNSTimer: %f",velocityTime)
            
            //first kill last timer, then start new for note-off
            timer.invalidate()
            timer = NSTimer.scheduledTimerWithTimeInterval(velocityTime, target: self, selector: #selector(ViewController.noteOFF), userInfo: nil, repeats: false)

            //play the Note
            conductor.core.playNote(midiNote,velocity: velocity)
            
            //save midi note for killing it
            lastMidiNote=midiNote;
            
        }

    }
    
    func noteOFF()
    {
        conductor.core.stopNote(midiNote)
        NSLog("timer done")
    }
    
    
    @IBAction func addToArrayPressedDown(sender: UIButton) {
        //create a random MIDI value to simulate not yet existing keyboard
        let randomMIDI = Int(arc4random_uniform(126)+1);
        mutArray.addObject(randomMIDI);
        NSLog("array is: %@",mutArray);
    }
    
    
    @IBAction func clearListButtonPressedTouchUpInside(sender: UIButton) {
        mutArray.removeAllObjects();
        mutArray.addObject("List is empty");
    }
    
    @IBAction func deleteLastObjectPressedTouchUpInside(sender: UIButton) {
        //NSLog("Delete last object is pressed");
        if(mutArray.count>1){
            mutArray.removeLastObject();
        }
        else{
            showArrayTextField.text = "Can't delete anymore"
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
    
    var previewTimer = NSTimer()
    var lastInputKeyboard = 0
    
    func previewNoteOFF()
    {
        conductor.core.stopNote(lastInputKeyboard)
    }
    
    func receiveKeyboard(inputKeyboard: Int)
    {   //add buttons to put octave up or down
        let inputAfterOctaveSwitch = (inputKeyboard+octaveState);
        NSLog("input after octave switch %d",inputAfterOctaveSwitch);
        
        //add element to array
        mutArray.addObject(inputAfterOctaveSwitch);
        
        //stop last sound
        conductor.core.stopNote(lastInputKeyboard)
        
        //play sound
        conductor.core.releaseDuration = 0.1
        
        //first kill last timer, then start new for note-off
        previewTimer.invalidate()
        previewTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(ViewController.previewNoteOFF), userInfo: nil, repeats: false)
        
        //play the Note
        conductor.core.playNote(inputAfterOctaveSwitch,velocity: 80)
        
        lastInputKeyboard=inputAfterOctaveSwitch
    }
    
    @IBOutlet weak var showArrayTextField: UITextField!
    
    @IBOutlet weak var showOctaveState: UITextField!
  
    @IBAction func chooseWave(sender: AnyObject) {
        let index = sender.selectedSegmentIndex
        
        switch String(index)
        {
        case "0" :
            conductor.core.waveform1 = Double(index)
        case "1" :
            conductor.core.waveform1 = Double(index)
        case "2" :
            conductor.core.waveform1 = Double(index)
        case "3" :
            conductor.core.waveform1 = Double(index)
            
        default:
            break
        }

        
    }
    
    
} //closing UIViewController

