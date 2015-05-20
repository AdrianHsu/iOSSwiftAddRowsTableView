//
//  CarListTableViewController.swift
//  iOSSwiftAddRowsTableView
//
//  Created by AdrianHsu on 2015/5/20.
//  Copyright (c) 2015年 AdrianHsu. All rights reserved.
//

import UIKit

class CarListViewController: UITableViewController {

    var cars = [String]() //empty array of strings
    var newCar: String = "" //string requires filling
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        var carDetailVC = segue.sourceViewController as! CarDetailViewController
        
        newCar = carDetailVC.name
        cars.append(newCar)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cars = ["BMW","Audi","Volkswagen"]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return cars.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel!.text = cars[indexPath.row]
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            cars.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        var fromCar: String = cars[fromIndexPath.row]
        var toCar: String = cars[toIndexPath.row]
        
        cars.removeAtIndex(fromIndexPath.row)
        cars.insert(toCar, atIndex: fromIndexPath.row)
        cars.removeAtIndex(toIndexPath.row)
        cars.insert(fromCar, atIndex: toIndexPath.row)
        //println(fromIndexPath.row)
        
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
