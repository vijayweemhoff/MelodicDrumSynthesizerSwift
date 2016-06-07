//
//  presetViewController.swift
//  melodic_drum_test1_SWIFT
//
//  Created by Vijay Weemhoff on 07-06-16.
//  Copyright © 2016 Vijay Weemhoff. All rights reserved.
//

import UIKit

func deleteFromPresetArray(){
    //delete from array
    presetArray.removeObjectAtIndex(indexDelete)
    
    //save the presetArray in NSDefault so it can be default.
    NSUserDefaults.standardUserDefaults().setObject(presetArray, forKey: "presets")
    NSUserDefaults.standardUserDefaults().synchronize()
}

var indexDelete = 0

class presetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var items = presetArray
    var copyPresetArray: NSMutableArray = [""]
    
    
    @IBOutlet var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        NSLog(String(mutArray))
        NSLog(String(presetArray))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loadAndGoBackPressed(sender: UIButton) {
        mutArray = copyPresetArray
    }
    
    @IBAction func AlertSure(){
        let alertController = UIAlertController(title: "Warning", message: "Are you sure you want to delete this preset?", preferredStyle:UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default){
            action -> Void in
            //NSLog("Pressed Yes")
            //delete from tableView
            //self.items.removeObjectAtIndex(indexDelete)
            
            //send data to other viewController
            deleteFromPresetArray()
            self.tableView!.reloadData()
        
            //NSUserDefaults.standarUserDefaults().removeObjectForKey(HIERWELKEJEWILTVERWIJDEREN)
            })
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deletePresetPressed(sender: UIButton) {
        AlertSure()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView!.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //NSLog("You selected cell #\(indexPath.row)!")
        NSLog("\(presetArray[indexPath.row])")
        //if you want to delete you need index
        indexDelete = indexPath.row
        NSLog("%d",indexDelete)
        
        //first copy the the preset array
        if let tempNames: NSArray = NSUserDefaults.standardUserDefaults().arrayForKey(presetArray[indexPath.row] as! String) {
            copyPresetArray = tempNames.mutableCopy() as! NSMutableArray
        }
    }
    
}
