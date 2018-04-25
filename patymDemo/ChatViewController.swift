//
//  ChatViewController.swift
//  patymDemo
//
//  Created by Bhanuteja on 28/04/17.
//  Copyright © 2017 Bhanuteja. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChatViewController: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sendbuttonBackView: UIView!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var messagetextfield: UITextField!
    var messagesArray: [Dictionary<String, String>] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
        override func viewDidLoad() {
        super.viewDidLoad()
        messagetextfield.delegate = self
            tableview.delegate = self
            tableview.dataSource = self
            tableview.tableFooterView = UIView()
            appDelegate.mpcManager.browser.stopBrowsingForPeers()
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleMPCReceivedDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }

    func keyboardHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]) as? CGRect{
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    func keyboardShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]) as? CGRect{
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       appDelegate.mpcManager.browser.startBrowsingForPeers()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        appDelegate.mpcManager.browser.startBrowsingForPeers()
    }
    @IBAction func endChat(_ sender: Any) {
        let messageDictionary: [String: String] = ["message": "_end_chat_"]
        if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID){
            self.dismiss(animated: true, completion: { () -> Void in
                self.appDelegate.mpcManager.session.disconnect()
            })
        }
  
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       sendMessageMethod(textField: textField)
        return true
    }
    
    func sendMessageMethod(textField:UITextField){
        textField.resignFirstResponder()
        if(!textField.text!.isEmpty){
            let messageDictionary: [String: String] = ["message": textField.text!]
            
            if appDelegate.mpcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mpcManager.session.connectedPeers[0] as MCPeerID){
                
                let dictionary: [String: String] = ["sender": "self", "message": textField.text!]
                messagesArray.append(dictionary)
                
                self.updateTableview()
            }
            else{
                print("Could not send data")
            }
            
            textField.text = ""
        }
    }
   
    @IBAction func sendMessage(_ sender: Any) {
        sendMessageMethod(textField: messagetextfield)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selfCell = tableView.dequeueReusableCell(withIdentifier: "SelfChatCell") as? SelfTableViewCell
        let receiverCell = tableView.dequeueReusableCell(withIdentifier: "RecivedChatCell") as? ReceiverTableViewCell
        let currentMessage = messagesArray[indexPath.row] as Dictionary<String, String>
        
        if let sender = currentMessage["sender"] {
                if sender == "self"{
                if let message = currentMessage["message"] {
                    selfCell?.messageLabel?.text = message
                }
                return  selfCell!
            }
            else{
                if let message = currentMessage["message"] {
                    receiverCell?.messageLabel?.text = message
                }
                return receiverCell!
            }
        }
        return cell
        }
    
    func updateTableview(){
        tableview.reloadData()
        
        if self.tableview.contentSize.height > self.tableview.frame.size.height {
            tableview.scrollToRow(at: IndexPath(row: messagesArray.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? Data
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! Dictionary<String, String>
        
        // Check if there's an entry with the "message" key.
        if let message = dataDictionary["message"] {
            // Make sure that the message is other than "_end_chat_".
            if !message.contains("end chat"){
                // Create a new dictionary and set the sender and the received message to it.
                let messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
                
                // Add this dictionary to the messagesArray array.
                messagesArray.append(messageDictionary)
                
                // Reload the tableview data and scroll to the bottom using the main thread.
                OperationQueue.main.addOperation({ () -> Void in
                    self.updateTableview()
                })
            }
            else{
                // In this case an "_end_chat_" message was received.
                // Show an alert view to the user.
                let alert = UIAlertController(title: "", message: "\(fromPeer.displayName) ended this chat.", preferredStyle: UIAlertControllerStyle.alert)
                
                let doneAction: UIAlertAction = UIAlertAction(title: "Okay", style: .default) { (alertAction) -> Void in
                    self.appDelegate.mpcManager.session.disconnect()
                    self.dismiss(animated: true, completion: nil)
                }
                
                alert.addAction(doneAction)
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.present(alert, animated: true, completion: nil)
                })
            }
        }
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
