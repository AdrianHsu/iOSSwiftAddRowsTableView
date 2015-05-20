
//
//  CarListTableViewController.swift
//  iOSSwiftAddRowsTableView
//
//  Created by AdrianHsu on 2015/5/20.
//  Copyright (c) 2015年 AdrianHsu. All rights reserved.
//

import UIKit
import CoreData


class CarListViewController: UITableViewController {

    var cars = [Car]() //empty array of Strings
    var newCar: String = "" //string requires filling
    var tmpImage = UIImageView( image: UIImage(named: "car1.jpg"))
    var carImages: [UIImage] = [
        UIImage(named: "car1.jpg")!,
        UIImage(named: "car2.jpg")!,
        UIImage(named: "car3.jpg")!,
        UIImage(named: "car4.jpg")!,
        UIImage(named: "car5.jpg")!,
    ]

    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        tableView.reloadData()
    }
    @IBAction func done(segue:UIStoryboardSegue) {
        var carDetailVC = segue.sourceViewController as! CarDetailViewController
        var name = carDetailVC.name
        
        // save context into Sqlite using Core Data
        // get context
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext!
                
        // create entity
        var car = NSEntityDescription.insertNewObjectForEntityForName("Car", inManagedObjectContext: context) as! Car
        car.name = name
        appDelegate.saveContext()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        loadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didSave", name: NSManagedObjectContextDidSaveNotification, object: nil)
    }

    func loadData() {

        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext!
        var fetch = NSFetchRequest(entityName: "Car")
        var error: NSError?
        var request = context.executeFetchRequest(fetch, error: &error)
        
        if let result = request {
            self.cars = result as! [(Car)]
            self.tableView.reloadData()
        }
    }
    func didSave() {
        println("NSManagedObjectContextDidSaveNotification")
        loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //There is only one section in the Table View so we need to return a 1 in the numberOfSectionsTableView method.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    //The number of rows is equal to the number of items in the cars array so we use the count method of the array class
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return cars.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forIndexPath: indexPath) as! UITableViewCell

        //var car = self.cars[indexPath.row] as! Car

        cell.textLabel!.font = UIFont(name: "Avenir Next", size: 24)
        cell.textLabel!.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        
        cell.textLabel!.text = cars[indexPath.row].name
        
        if(cars[indexPath.row].name == "BMW")
        {
            cell.imageView?.image = carImages[0]
        }
        else if(cars[indexPath.row].name == "Audi")
        {
            cell.imageView?.image = carImages[1]
        }
        else if(cars[indexPath.row].name == "Volkswagen")
        {
            cell.imageView?.image = carImages[2]
        }
        else if(cars[indexPath.row].name == "Benz")
        {
            cell.imageView?.image = carImages[3]
        }
        else
        {
            cell.imageView?.image = carImages[4]
        }
        
        return cell
    }
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView,
    heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        //let tmp = self.tableView.frame.width * (tmpImage.image!.size.height  / tmpImage.image!.size.width )
            
        let tmp = self.tableView.frame.width * (tmpImage.image!.size.height  / tmpImage.image!.size.width ) / 2
        return tmp
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            var car = self.cars[indexPath.row] as Car
            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            var context = appDelegate.managedObjectContext!
            context.deleteObject(car)
            cars.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            appDelegate.saveContext()
            
        }
        /*else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }*/
    }


    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        var fromCar = cars[fromIndexPath.row] as Car
        var toCar = cars[toIndexPath.row] as Car
        cars.removeAtIndex(fromIndexPath.row)
        cars.insert(toCar, atIndex: fromIndexPath.row)
        cars.removeAtIndex(toIndexPath.row)
        cars.insert(fromCar, atIndex: toIndexPath.row)

        
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
