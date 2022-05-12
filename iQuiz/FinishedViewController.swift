//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Jason Nguyen on 5/12/22.
//

import UIKit

class FinishedViewController: UIViewController {

    var totalQuestions : Int! = nil
    var correctAnswers : Int! = nil
    
    let label_subject = UILabel()
    let label_score = UILabel()
    let label_words = UILabel()
    let btn_submit = UIButton()
    let btn_back = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(btn_submit)
        btn_submit.translatesAutoresizingMaskIntoConstraints = false
        btn_submit.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        btn_submit.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        btn_submit.backgroundColor = UIColor.systemBlue
        btn_submit.setTitle("next", for: .normal)
        btn_submit.addTarget(self, action: #selector(handleSegue(_:)), for: .touchUpInside)
        
        self.view.addSubview(btn_back)
        btn_back.translatesAutoresizingMaskIntoConstraints = false
        btn_back.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        btn_back.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        btn_back.backgroundColor = UIColor.systemBlue
        btn_back.setTitle("back", for: .normal)
        btn_back.addTarget(self, action: #selector(handleDismiss(_:)), for: .touchUpInside)
        
        self.view.addSubview(label_subject)
        label_subject.translatesAutoresizingMaskIntoConstraints = false
        label_subject.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_subject.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        self.view.addSubview(label_score)
        label_score.translatesAutoresizingMaskIntoConstraints = false
        label_score.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_score.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.view.addSubview(label_words)
        label_words.translatesAutoresizingMaskIntoConstraints = false
        label_words.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_words.centerYAnchor.constraint(equalTo: label_score.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func handleSegue(_ sender: UIButton) {
        alert("Upload Score", "not implemented yet")
    }

    @objc func handleDismiss(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    func alert(_ title : String, _ message : String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}
