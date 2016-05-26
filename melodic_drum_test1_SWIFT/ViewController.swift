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
var velocityArray : NSArray = [20,40,60,80,100,120]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("ViewController did load..")
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
        //conductor.filterSection.lfoAmplitude = 0.0 // LFO Amp (Hz)
        //conductor.filterSection.lfoRate = 1.4 // LFO Rate
        //conductor.filterSection.resonance = 0.5 // Filter Q/Rez
        //conductor.multiDelay.time = 0.5 // Delay (seconds)
        //conductor.multiDelay.mix = 0.5 // Dry/Wet
        conductor.reverb.feedback = 0.88 // Amt
        conductor.reverbMixer.balance = 0.4 // Dry/Wet
        conductor.midiBendRange = 2.0 // MIDI bend range in +/- semitones
        
        //cutoffKnob.value = 0.36 // Cutoff Knob Position
        //crushAmtKnob.value = 0.0 // Crusher Knob Position
        
        // ADSR
        conductor.core.attackDuration = 0.1
        conductor.core.decayDuration = 0.1
        conductor.core.sustainLevel = 0.001
        conductor.core.releaseDuration = 0
        
        // Update Knob & Slider UI Values
        //setupKnobValues()
        //setupSliderValues()
        
        // Update Toggle Presets
        //displayModeToggled(plotToggle)
        /*
        vco1Toggled(vco1Toggle)
        vco2Toggled(vco2Toggle)
        filterToggled(filterToggle)
        delayToggled(delayToggle)
        reverbToggled(reverbToggle) */
    }


    var xMutArray = 0;
    var counterAddArray=0;
    var countPlus=0;
    
    var counterKeyPressed=0;
    var midiNote = 0;
    var lastMidiNote = 0;
    
    var xVelocityArray=0;
    var velocity=0;

    @IBAction func tapButtonPressedDown(sender: UIButton) {
        //NSLog("tap!");
        
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
        let stringForTextField = String(mutArray[xMutArray]);
        
        showArrayTextField.text = stringForTextField;
        
        //initialize adsr
        conductor.core.attackDuration = 0.1
        conductor.core.decayDuration = 0.1
        conductor.core.sustainLevel = 0.001
        conductor.core.releaseDuration = 0.001

        //Frequency wordt alleen aangepast wanneer er iets in de array gedaan is.
        if(counterAddArray>=1)
        {
            midiNote = Int(mutArray[xMutArray] as! NSNumber);
            
            counterKeyPressed=counterKeyPressed+1;
            //voice.receivedMIDINoteOn(avAudioNode, note: Double(mutArray[xMutArray] as! NSNumber), velocity: 80)
            /// Sustain Level
            
            
            if(counterKeyPressed>0)
            {
                conductor.core.stopNote(lastMidiNote)
                //NSLog("killing the last note")
            }
            
            
            if(xVelocityArray>5)
            {
                xVelocityArray=0;
            }
            
            velocity = Int(velocityArray[xVelocityArray] as! NSNumber);
            xVelocityArray=xVelocityArray+1;
            NSLog("veloctiy is: %d",velocity)
            
            conductor.core.playNote(midiNote,velocity: velocity)
            
            //save midi note for killing it
            lastMidiNote=midiNote;
            
        }
        

    }
    
    @IBAction func addToArrayPressedDown(sender: UIButton) {
        //xMutArray is 1 to lose the "List is Empty" line
        xMutArray=0;
        
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
        counterKeyPressed=0;
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
                counterKeyPressed=0;
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
        xMutArray=0;
        
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
  
    func receiveChooseWave(wave: Int)
    {
        NSLog("he! een wave-int: %d",wave)
    }
    /*
    //TODO's
    //rename Instrument.swift -> Voice
    //rename "AudioSystem group -> Audio
    
    //correcte output pakken: 
      //-sourceMixer ipv osc als output. Dit werkend krijgen met geluid.
      //-adsr werkend krijgen
    */
  
    
    
} //closing UIViewController

