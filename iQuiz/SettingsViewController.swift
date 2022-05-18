//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Jason Nguyen on 5/15/22.
//

import UIKit
import Network

class SettingsViewController: UIViewController {

    var rootVC : ViewController! = nil
    
    @IBOutlet weak var text_url: UITextField!
    let btn_back = UIButton()
    let btn_check = UIButton()
    let label_connected = UILabel()
    
    var myUrl : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "url_preference") != nil {
            myUrl = UserDefaults.standard.string(forKey: "url_preference")!
        } else {
            myUrl = "http://tednewardsandbox.site44.com/questions.json"
        }
        
        text_url.translatesAutoresizingMaskIntoConstraints = false
        text_url.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text_url.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        text_url.text = myUrl
        
        self.view.addSubview(btn_check)
        btn_check.translatesAutoresizingMaskIntoConstraints = false
        btn_check.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn_check.centerYAnchor.constraint(equalTo: text_url.bottomAnchor, constant: 20).isActive = true
        btn_check.setTitle("check now", for: .normal)
        btn_check.backgroundColor = UIColor.systemBlue
        btn_check.addTarget(self, action: #selector(checkNewData(_:)), for: .touchUpInside)
        
        self.view.addSubview(label_connected)
        label_connected.translatesAutoresizingMaskIntoConstraints = false
        label_connected.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_connected.centerYAnchor.constraint(equalTo: btn_check.bottomAnchor, constant: 20).isActive = true
        label_connected.text = "connection status"
        label_connected.backgroundColor = UIColor.gray
        
        self.view.addSubview(btn_back)
        btn_back.translatesAutoresizingMaskIntoConstraints = false
        btn_back.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        btn_back.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        btn_back.backgroundColor = UIColor.systemBlue
        btn_back.setTitle("back", for: .normal)
        btn_back.addTarget(self, action: #selector(handleDismiss(_:)), for: .touchUpInside)
    }
    
    @objc func handleDismiss(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func checkNewData(_ sender: UIButton) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    // do things here if connected to internet
                    self.label_connected.backgroundColor = UIColor.green
                    self.label_connected.text = "connected"
                    self.rootVC.getData(self.text_url.text!)
                    self.myUrl = self.text_url.text!
                    UserDefaults.standard.set(self.myUrl, forKey: "url_preference")
                } else {
                    // do things here if not connected to internet
                    self.label_connected.backgroundColor = UIColor.red
                    self.label_connected.text = "not connect"
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

}
