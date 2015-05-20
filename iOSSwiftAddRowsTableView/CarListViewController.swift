
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

    var cars = [String]() //empty array of strings
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
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext!)
        
        var Users = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        Users.setValue(1, forKey:"id")
        Users.setValue("leoyeh", forKey:"name")
        let fetchRequest = NSFetchRequest(entityName: "User")
        let fetchedResults = managedContext?.executeFetchRequest(fetchRequest, error: nil) as! [NSManagedObject]?
        if let results = fetchedResults {
            for var n = 0; n < results.count; n++ {
                println(results[n].valueForKey("id") as! IntegerLiteralType)
                println(results[n].valueForKey("name") as! String)
            }
        }

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


        
        cell.textLabel!.font = UIFont(name: "Avenir Next", size: 24)
        cell.textLabel!.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.4)
        if(cars[indexPath.row] == "BMW")
        {
            cell.textLabel!.text = cars[indexPath.row]
            cell.imageView?.image = carImages[0]
        }
        else if(cars[indexPath.row] == "Audi")
        {
            cell.textLabel!.text = cars[indexPath.row]
            cell.imageView?.image = carImages[1]
        }
        else if(cars[indexPath.row] == "Volkswagen")
        {
            cell.textLabel!.text = cars[indexPath.row]
            cell.imageView?.image = carImages[2]
        }
        else if(cars[indexPath.row] == "Benz")
        {
            cell.textLabel!.text = cars[indexPath.row]
            cell.imageView?.image = carImages[3]
        }
        else
        {
            cell.textLabel!.text = cars[indexPath.row]
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
        return tmp;
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
