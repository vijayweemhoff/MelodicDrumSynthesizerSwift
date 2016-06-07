//
//  presetViewController.swift
//  melodic_drum_test1_SWIFT
//
//  Created by Vijay Weemhoff on 07-06-16.
//  Copyright © 2016 Vijay Weemhoff. All rights reserved.
//

import UIKit

class presetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var items = presetArray
    
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
        if let tempNames: NSArray = NSUserDefaults.standardUserDefaults().arrayForKey(presetArray[indexPath.row] as! String) {
            mutArray = tempNames.mutableCopy() as! NSMutableArray
        }
    }
    
}
