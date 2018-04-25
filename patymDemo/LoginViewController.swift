//
//  LoginViewController.swift
//  patymDemo
//
//  Created by Bhanuteja on 25/04/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var userNametext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNametext.delegate = self
        passwordtext.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if (userNametext.text?.isEmpty)!{
        showAlert(message: "Please enter user name")
        }else if (passwordtext.text?.isEmpty)!{
            showAlert(message: "Please enter password")
        }else if !((userNametext.text?.isEmpty)!) && !((passwordtext.text?.isEmpty)!){
        let managedObj = appDelegate?.managedObjectContext
        let predName = NSPredicate(format: "name = %@ ", userNametext.text!)
        let predpassword = NSPredicate(format: "password = %@", passwordtext.text!)
        let pred = NSPredicate(format: "name = %@ AND password = %@", userNametext.text!, passwordtext.text!)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SignUp")
        fetch.predicate = predName
        fetch.fetchLimit = 1
        do{
        let details = try managedObj?.fetch(fetch) as? [SignUp]
            
            if details?.count == 0 {
                showAlert(message: "Please enter correct username")
            }else{
               
                fetch.predicate = predpassword
                do{
                    let details = try managedObj?.fetch(fetch) as? [SignUp]
                    if details?.count == 0 {
                        showAlert(message: "Please enter correct password")
                    }else{
                        
                        fetch.predicate = pred
                        do{
                            let details = try managedObj?.fetch(fetch) as? [SignUp]
                            if details?.count == 0 {
                                showAlert(message: "Please enter correct username and password")
                            }else{
                                UserDefaults.standard.set(true, forKey: "afterLogin")
                                let storybord = UIStoryboard(name: "Main", bundle: nil)
                                let viewController = storybord.instantiateViewController(withIdentifier: "homenav")
                                self.present(viewController, animated: true, completion: nil)
                            }
                        }
                        catch{
                            
                        }
                    }

            }
                catch{
                    
                }
        }
        }catch{
            
        }
        
        }  //if userNametext.text ==
    
    }

    @IBAction func signUpButtonAction(_ sender: Any) {
    let storybord = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storybord.instantiateViewController(withIdentifier: "signUp")
        self.present(viewController, animated: true, completion: nil)
    
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel) {
            (result : UIAlertAction) -> Void in
            
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
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
