//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Jason Nguyen on 5/12/22.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var questionNum : Int! = nil
    var totalCorrect : Int! = nil
    var currentSelection : Int = 1
    
    @IBOutlet weak var tableView: UITableView!
    let label_subject = UILabel()
    let label_question = UILabel()
    let btn_submit = UIButton()
    let btn_back = UIButton()
    var subject : Subject! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(btn_submit)
        btn_submit.translatesAutoresizingMaskIntoConstraints = false
        btn_submit.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        btn_submit.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        btn_submit.backgroundColor = UIColor.lightGray
        btn_submit.setTitle("submit", for: .normal)
        btn_submit.isEnabled = false
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
        
        self.view.addSubview(label_question)
        label_question.translatesAutoresizingMaskIntoConstraints = false
        label_question.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_question.centerYAnchor.constraint(equalTo: label_subject.bottomAnchor, constant: 20).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: label_question.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: btn_submit.topAnchor).isActive = true
        tableView.rowHeight = 50.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toAnswer":
            let other = segue.destination as! AnswerViewController
            let test = sender as! QuestionViewController
            let subject = test.subject! as Subject
            let correct = Int(subject.questions[questionNum].answer)!
            other.subject = subject
            other.label_subject.text = subject.title
            other.label_question.text = subject.questions[questionNum].text
            other.questionNum = questionNum + 1
            other.label_correctAnswer.text = subject.questions[questionNum].answers[correct - 1]
            if correct == currentSelection {
                //other.totalCorrect = totalCorrect + 1
                other.totalCorrect = totalCorrect! + 1
                other.label_feedback.backgroundColor = UIColor.green
                other.label_feedback.text = "Correct"
            } else {
                other.totalCorrect = totalCorrect!
                other.label_feedback.backgroundColor = UIColor.red
                other.label_feedback.text = "Incorrect"
            }
            
        default:
            print("something is wrong")
        }
    }
    
    @objc func handleSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "toAnswer", sender: self)
    }
    
    // broken atm, will change to a segue later
    @objc func handleDismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subject.questions[questionNum].answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "answers", for: indexPath)
        let curr = subject.questions[questionNum].answers[indexPath.row]
        cell.textLabel?.text = curr
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        currentSelection = indexPath.row + 1
        btn_submit.backgroundColor = UIColor.systemBlue
        btn_submit.isEnabled = true
    }
    
}
