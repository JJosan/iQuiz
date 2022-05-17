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
    
    @IBOutlet weak var tableView_quiz: UITableView!

    @IBAction func toolbarItem_settings(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView_quiz.delegate = self
        tableView_quiz.dataSource = self
        tableView_quiz.rowHeight = 75.0
        //getData("http://tednewardsandbox.site44.com/questions.json")
        createFakeData()
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
        case "toSettings":
            let other = segue.destination as! SettingsViewController
            other.rootVC = self
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
                    print("something went wrong. error: \(error!)")
                } else {
                    do {
                        self.data = []
                        let questions =  try JSONSerialization.jsonObject(with: data!) as! NSArray
                        DispatchQueue.main.async {
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
                            self.tableView_quiz.reloadData()
                        }
                    } catch {
                        print("something went wrong")
                    }
                }
            }
        }
        session.resume()
    }
    
    func createFakeData() {
        data.append(Subject(
            "Science!",
            "Because SCIENCE!",
            [
                Question(
                    "What is fire?",
                    "1",
                    [
                        "One of the four classical elements",
                        "A magical reaction given to us by God",
                        "A band that hasn't yet been discovered",
                        "Fire! Fire! Fire! heh-heh"
                    ]
                )
            ]
        ))
    }
    
}
