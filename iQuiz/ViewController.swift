//
//  ViewController.swift
//  iQuiz
//
//  Created by Jason Nguyen on 5/3/22.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data : [Subject] = []
    
    var urlString = ""
    
    @IBOutlet weak var tableView_quiz: UITableView!

    @IBAction func toolbarItem_settings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "iQuiz Settings", preferredStyle: .alert)
               let confirmQuestions = UIAlertAction(title: "Enter", style: .default) { _ in
                   self.urlString = (alert.textFields?[0].text)!
                   UserDefaults.standard.set(self.urlString, forKey: "url_preferences")
                   self.getData(self.urlString)
                   self.tableView_quiz.reloadData()
               }
               alert.addTextField { (textField) in
                   textField.placeholder = "Enter new URL to get questions from"
               }
               let cancelQuestions = UIAlertAction(title: "Cancel", style: .default) { _ in
               }
               alert.addAction(confirmQuestions)
               alert.addAction(cancelQuestions)
               
               self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView_quiz.delegate = self
        tableView_quiz.dataSource = self
        tableView_quiz.rowHeight = 75.0
        if UserDefaults.standard.string(forKey: "url_preference") != nil {
            getData(UserDefaults.standard.string(forKey: "url_preference")!)
        } else {
            getData("http://tednewardsandbox.site44.com/questions.json")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toQuestion":
            let other = segue.destination as! QuestionViewController
            let subject = sender! as! Subject
            other.subject = subject
            other.label_subject.text = subject.title
            other.label_question.text = subject.questions[0].text
            other.questionNum = 0
            other.totalCorrect = 0
        default:
            print("something is wrong")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath)
        let curr = data[indexPath.row]
        cell.imageView?.image = UIImage(named: "nuggets")
        cell.textLabel?.text = curr.title
        cell.detailTextLabel?.text = curr.desc
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "toQuestion", sender: item)
    }
    
    func getData(_ yes : String) {
        guard let url = URL(string: yes) else {
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if response != nil {
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    // get from database
                    let archivePath = NSHomeDirectory() + "/Documents/questions.archive"
                    let archiveURL = URL(fileURLWithPath: archivePath)
                    let readQuestions = NSArray(contentsOf: archiveURL)
                    if readQuestions != nil {
                        let questions = readQuestions!
                        DispatchQueue.main.async {
                            print("no internet")
                            self.data = []
                            self.loadItems(questions)
                            self.tableView_quiz.reloadData()
                        }
                    } else {
                        DispatchQueue.main.async {
                            let noItems = UILabel()
                            self.view.addSubview(noItems)
                            noItems.translatesAutoresizingMaskIntoConstraints = false
                            noItems.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                            noItems.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                            noItems.text = "Nothing"
                            
                        }
                    }
                    
                } else {
                    do {
                        self.data = []
                        let questions =  try JSONSerialization.jsonObject(with: data!) as! NSArray
                        DispatchQueue.main.async {
                            print("yes internet")
                            self.loadItems(questions)
                            self.tableView_quiz.reloadData()
                            // writing
                            let archivePath = NSHomeDirectory() + "/Documents/questions.archive"
                            let nsQuestions = questions
                            nsQuestions.write(toFile: archivePath, atomically: true)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: "Can't Fetch", preferredStyle: .alert)
                               let cancelQuestions = UIAlertAction(title: "OK", style: .default) { _ in
                               }
                               alert.addAction(cancelQuestions)
                               
                               self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                }
            }
        }
        session.resume()
    }
    
    func loadItems(_ questions : NSArray){
        for i in 0..<questions.count {
            let object = questions[i] as! NSDictionary
            let objectQuestions = object["questions"]! as! NSArray
            var QuestionArray : [Question] = []
            for i in 0..<objectQuestions.count {
                let oneQuestion = objectQuestions[i] as! NSDictionary
                QuestionArray.append(
                    Question(
                        oneQuestion["text"] as! String,
                        oneQuestion["answer"] as! String,
                        oneQuestion["answers"] as! [String]
                    )
                )
            }
            
            self.data.append(Subject(
                object["title"]! as! String,
                object["desc"]! as! String,
                QuestionArray
            ))
        }
    }
    
}
