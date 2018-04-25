//
//  NavigationViewController.swift
//  patymDemo
//
//  Created by Bhanuteja on 01/05/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(colorLiteralRed: 67.0/255.0, green: 54.0/255.0, blue: 37.0/255.0, alpha: 1) //UIColor(red: 52.0 / 255.0, green: 64.0 / 255.0, blue: 72.0 / 255.0, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        //    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
        //                                              [UIColor colorWithRed:164.0/255.0 green:215.0/255.0 blue:51.0/255.0 alpha:1.0],
        //                                              NSForegroundColorAttributeName, nil];
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white   ]
        self.navigationBar.isTranslucent = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
