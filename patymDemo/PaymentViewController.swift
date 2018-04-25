//
//  PaymentViewController.swift
//  patymDemo
//
//  Created by Bhanuteja on 28/04/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var cardnumberfield: UITextField!
    @IBOutlet weak var amountfield: UITextField!
    @IBOutlet weak var cvvfield: UITextField!
    @IBOutlet weak var monthandyear: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet var textFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        return true
    }
    
    @IBAction func send(_ sender: Any) {
        // Initiate the card
//        var stripCard = StripCard()
//        
//        // Split the expiration date to extract Month & Year
//        if self.monthandyear.text?.isEmpty == false {
//            let expirationDate = self.monthandyear.text?.components(separatedBy: "/")
//            let expMonth = UInt((expirationDate?[0])!)
//            let expYear = UInt((expirationDate?[1])!)
//            
//            // Send the card info to Strip to get the token
//            stripCard.number = self.cardnumberfield.text
//            stripCard.cvc = self.cvvfield.text
//            stripCard.expMonth = expMonth
//            stripCard.expYear = expYear
//        }
//        
//        var underlyingError: NSError?
//        stripCard.validateCardReturningError(&underlyingError)
//        if underlyingError != nil {
//            self.indicator.stopAnimating()
//            self.handleError(error: underlyingError!)
//            return
//        }
//        
//        
//        STPAPIClient.sharedClient().createTokenWithCard(card, completion: { (token: STPToken?, error: NSError?) -> Void in
//            
//            if error != nil {
//                self.handleError(error: error!)
//                return
//            }
//            
//            self.postStripeToken(token!)
//        })
    }

//    func handleError(error: NSError) {
//        print(error)
//        UIAlertView(title: "Please Try Again",
//                    message: error.localizedDescription,
//                    delegate: nil,
//                    cancelButtonTitle: "OK").show()
//        
//    }
    
//    func postStripeToken(token: STPToken) {
//        
//        let URL = "http://localhost/donate/payment.php"
//        let params = ["stripeToken": token.tokenId,
//                      "amount": self.amountfield.text.toInt()!,
//                      "currency": "usd",
//                      "description": self.namefield.text]
//        
//        let manager = AFHTTPRequestOperationManager()
//        manager.POST(URL, parameters: params, success: { (operation, responseObject) -> Void in
//            
//            if let response = responseObject as? [String: String] {
//                UIAlertView(title: response["status"],
//                            message: response["message"],
//                            delegate: nil,
//                            cancelButtonTitle: "OK").show()
//            }
//            
//        }) { (operation, error) -> Void in
//            self.handleError(error!)
//        }
//    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
