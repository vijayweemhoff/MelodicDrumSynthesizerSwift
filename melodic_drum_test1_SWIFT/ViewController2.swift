//
//  ViewController2.swift
//  melodic_drum_test1_SWIFT
//
//  Created by Vijay Weemhoff on 26-05-16.
//  Copyright © 2016 Vijay Weemhoff. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("ViewController2 did load..")
        // Do any additional setup after loading the view.
    }
    
    var conductor = Conductor.sharedInstance

    @IBAction func chooseWave(sender: UISegmentedControl) {
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
