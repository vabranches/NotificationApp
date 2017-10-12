//
//  ViewController.swift
//  NotificacoesApp
//
//  Created by Valter Abranches on 11/10/17.
//  Copyright © 2017 Valter Abranches. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tfMessage: UITextField!
    @IBOutlet weak var dpFireDate: UIDatePicker!
    @IBOutlet weak var lbMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceive(notification:)), name: NSNotification.Name("Received"), object: nil)

    }
    
    @objc func onReceive(notification : Notification){
        if let message = notification.object as? String {
            lbMessage.text = "\(message)"
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func fireNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Vim lembrar-lhe de:"
        content.body = tfMessage.text!
        //content.sound = UNNotificationSound(named: "arquivo-de-som.caf")
        content.categoryIdentifier = "Lembrete"
  
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let dateMatching = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: dpFireDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: content.categoryIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        dismiss(animated: true, completion: nil)
    }
    

}


