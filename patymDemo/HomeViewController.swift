//
//  HomeViewController.swift
//  patymDemo
//
//  Created by Bhanuteja on 28/04/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,iCarouselDelegate,iCarouselDataSource {

    @IBOutlet var backView: iCarousel!
    var number = [Int]()
    override func awakeFromNib() {
        super.awakeFromNib()
        number = [1,2,3,4,5]
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeViewController")
        if UserDefaults.standard.bool(forKey: "afterLogin") == false{
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storybord.instantiateViewController(withIdentifier: "login")
        self.present(viewController, animated: true, completion: nil)
        }
 
        backView.type = .timeMachine
        // Do any additional setup after loading the view.
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return number.count
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        tempView.backgroundColor = UIColor.red
        let buttons = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        if index == 0{
            buttons.setTitle("Bar code scanner", for: .normal)
            buttons.tag = index
            buttons.addTarget(self, action: #selector(HomeViewController.buttonsAction(_:)), for: .touchUpInside)
        }else if index == 1{
            buttons.setTitle("Chat with buddy", for: .normal)
            buttons.tag = index
            buttons.addTarget(self, action: #selector(HomeViewController.buttonsAction(_:)), for: .touchUpInside)
        }else if index == 2{
            buttons.setTitle("Pay", for: .normal)
            buttons.tag = index
            buttons.addTarget(self, action: #selector(HomeViewController.buttonsAction(_:)), for: .touchUpInside)
        }else if index == 3{
            buttons.setTitle("Edit info", for: .normal)
            buttons.tag = index
            buttons.addTarget(self, action: #selector(HomeViewController.buttonsAction(_:)), for: .touchUpInside)
        }else if index == 4{
            buttons.setTitle("Location Details", for: .normal)
            buttons.tag = index
            buttons.addTarget(self, action: #selector(HomeViewController.buttonsAction(_:)), for: .touchUpInside)
        }
        buttons.backgroundColor = UIColor.green
        tempView.addSubview(buttons)
        return tempView
        
    }
    func buttonsAction(_ sender:UIButton){
        print(sender.tag)
        if sender.tag == 0{
            let storyBoard = UIStoryboard(name: "BarcodeScanner", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "barcode")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }else if sender.tag == 1{
            let storyBoard = UIStoryboard(name: "Chat", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "firstChat")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }else if sender.tag == 2{
            let storyBoard = UIStoryboard(name: "pay", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "pay")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }else if sender.tag == 3{
            let storyBoard = UIStoryboard(name: "EditInfo", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "editinfo")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }else if sender.tag == 4{
            let storyBoard = UIStoryboard(name: "GeoLocation", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "location")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
    }
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
        if option == .spacing{
            backView.type = .coverFlow
            return value * 1.0
        }
        return value
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
