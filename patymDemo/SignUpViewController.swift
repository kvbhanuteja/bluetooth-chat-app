//
//  SignUpViewController.swift
//  patymDemo
//
//  Created by Bhanuteja on 25/04/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var namefield: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmpassword: UITextField!
    
    @IBOutlet weak var phonenumber: UITextField!
    
    @IBOutlet weak var country: UITextField!
    
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var pincode: UITextField!
    
    @IBOutlet weak var emailId: UITextField!
    
    @IBOutlet weak var signUp: UIButton!
    var signUpObj = SignUp()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.namefield.delegate = self
        self.pincode.delegate = self
        self.phonenumber.delegate = self
        self.password.delegate = self
        self.confirmpassword.delegate = self
        self.country.delegate = self
        self.state.delegate = self
        self.emailId.delegate = self
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
    
    @IBAction func signUpAction(_ sender: Any) {
        if (namefield.text?.isEmpty)! || (password.text?.isEmpty)! || (confirmpassword.text?.isEmpty)! || (phonenumber.text?.isEmpty)! || (emailId.text?.isEmpty)! || (state.text?.isEmpty)! || (country.text?.isEmpty)! || (pincode.text?.isEmpty)!{
            showError(message: "All these fields are manditory")
        }else if !((namefield.text?.onlyCharacters)!) {
            showError(message: "Name should only contain alphabets")
            
        }else if password.text != confirmpassword.text {
            showError(message: "Password and confirm password are not matching")
        }else if !(isValidEmail(emailadd: emailId.text!)){
            showError(message: "Please enter Vaild email")
        }else if !((phonenumber.text?.onlyNumbers)!){
            showError(message: "Please enter Vaild phone number")
        }else if !((country.text?.onlyCharacters)!){
            showError(message: "Please enter Vaild country")
        }else if !((state.text?.onlyCharacters)!){
            showError(message: "Please enter Vaild state")
        }else if !((pincode.text?.isValidZipCode)!){
            showError(message: "Please enter Vaild pincode")
        }else{
            let managedobj = appDelegate?.managedObjectContext
            let entity = NSEntityDescription.entity(forEntityName: "SignUp", in: managedobj!)
            let details = NSManagedObject(entity: entity!, insertInto: managedobj!) as? SignUp
            details?.name = namefield.text
            details?.password = password.text
            details?.country = country.text
            details?.phoneNumber = phonenumber.text
            details?.emailId = emailId.text
            details?.state = state.text
            details?.pincode = pincode.text
            do{
                try managedobj?.save()
                let storybord = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storybord.instantiateViewController(withIdentifier: "login")
                self.present(viewController, animated: true, completion: nil)

            }
            catch{
                
            }
            }
    }
    
    
    
    @IBAction func cancelAction(_ sender: Any) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storybord.instantiateViewController(withIdentifier: "login")
        self.present(viewController, animated: true, completion: nil)

    }
    
    func showError(message : String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alert = UIAlertAction(title: "Ok", style: .cancel){
            (result : UIAlertAction) -> Void in
            //self.dismiss(animated: true, completion: nil)
          }
        alertController.addAction(alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(emailadd:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailadd)
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
extension String{
    
    var length : Int { return self.characters.count }
    var onlyCharacters :Bool{
        let character: CharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if let range = self.rangeOfCharacter(from: character) {
        print("start index: \(range.lowerBound), end index: \(range.upperBound)")
    }else{
    return false
    }
    return true
    }
    
    var onlyNumbers : Bool{
        let character: CharacterSet = CharacterSet(charactersIn: "1234567890")
        if let range = self.rangeOfCharacter(from: character) {
            print("start index: \(range.lowerBound), end index: \(range.upperBound)")
            if self.length == 10 {
                return true
            }else{
                return false
            }
        }
        return false
 
    }
    var removeDashFromZipCodeAndPhoneNumber : String
    {
        return self.replacingOccurrences(of: "-", with: "")
    }
    var isValidZipCode : Bool
    {
            let charcter  = CharacterSet.alphanumerics.inverted
        var isValidPostCode : Bool = true;
            if self.removeDashFromZipCodeAndPhoneNumber.rangeOfCharacter(from:charcter) != nil
            {
                isValidPostCode = false
            }
            else
            {
                isValidPostCode = true
            }
            
            if (self.length == 7 || self.length == 6) && isValidPostCode
            {
                return true;
            }
            return false;
            }

   
    
    
}
