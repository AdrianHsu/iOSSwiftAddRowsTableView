//
//  CarDetailViewController.swift
//  iOSSwiftAddRowsTableView
//
//  Created by AdrianHsu on 2015/5/20.
//  Copyright (c) 2015年 AdrianHsu. All rights reserved.
//

import UIKit


class CarDetailViewController: UIViewController {
    @IBOutlet weak var carName: UITextField!
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "doneSegue" {
            name = carName.text
        }
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
