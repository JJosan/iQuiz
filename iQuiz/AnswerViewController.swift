//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Jason Nguyen on 5/12/22.
//

import UIKit

class AnswerViewController: UIViewController {

    var questionNum : Int! = nil
    var totalCorrect : Int! = nil
    
    let label_subject = UILabel()
    let label_question = UILabel()
    let label_correctAnswer = UILabel()
    let label_feedback = UILabel()
    let btn_submit = UIButton()
    var subject : Subject! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(btn_submit)
        btn_submit.translatesAutoresizingMaskIntoConstraints = false
        btn_submit.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        btn_submit.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        btn_submit.backgroundColor = UIColor.systemBlue
        btn_submit.setTitle("next", for: .normal)
        btn_submit.addTarget(self, action: #selector(handleSegue(_:)), for: .touchUpInside)
        
        self.view.addSubview(label_subject)
        label_subject.translatesAutoresizingMaskIntoConstraints = false
        label_subject.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_subject.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        self.view.addSubview(label_question)
        label_question.translatesAutoresizingMaskIntoConstraints = false
        label_question.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_question.centerYAnchor.constraint(equalTo: label_subject.bottomAnchor, constant: 20).isActive = true
        
        self.view.addSubview(label_correctAnswer)
        label_correctAnswer.translatesAutoresizingMaskIntoConstraints = false
        label_correctAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_correctAnswer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.view.addSubview(label_feedback)
        label_feedback.translatesAutoresizingMaskIntoConstraints = false
        label_feedback.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_feedback.centerYAnchor.constraint(equalTo: label_correctAnswer.bottomAnchor, constant: 20).isActive = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "backToQuestion":
            let other = segue.destination as! QuestionViewController
            let test = sender as! AnswerViewController
            let subject = test.subject! as Subject
            other.subject = subject
            other.label_subject.text = subject.title
            other.label_question.text = subject.questions[questionNum].text
            other.questionNum = questionNum
            other.totalCorrect = totalCorrect
        case "toFinished":
            print("done")
        default:
            print("something is wrong")
        }
    }
    
    @objc func handleSegue(_ sender: UIButton) {
        
        if subject.questions.count == questionNum {
            performSegue(withIdentifier: "toFinished", sender: self)
        } else {
            performSegue(withIdentifier: "backToQuestion", sender: self)
        }
    }
    
}
