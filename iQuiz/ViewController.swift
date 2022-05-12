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
        alert("Settings", "Settings go here")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView_quiz.delegate = self
        tableView_quiz.dataSource = self
        tableView_quiz.rowHeight = 75.0
        createFakeData()
        
//        var test : [String] = ["hi"]
//
//        let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")
//        let session = URLSession.shared.dataTask(with: url!) {
//            data, response, error in
//            if response != nil {
//                if (response! as! HTTPURLResponse).statusCode != 200 {
//                    print("something went wrong. error: \(error!)")
//                } else {
//                    do {
//                        let questions =  try JSONSerialization.jsonObject(with: data!) as! NSArray
//                        for i in 0..<questions.count {
//                            let temp = questions[i] as! NSDictionary
//                            //self.test.append(Question(temp["title"] as! String, temp["desc"] as! String))
//                            test.append(temp["title"] as! String)
//                        }
//                        print("sanity check")
//                    } catch {
//                        print("something went wrong")
//                    }
//                }
//            }
//        }
//        session.resume()
        
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
        
        // dunno where image is
        //cell.imageView?.image = curr.0
        cell.textLabel?.text = curr.title
        cell.detailTextLabel?.text = curr.desc
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "toQuestion", sender: item)
    }
    
    func alert(_ title : String, _ message : String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
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
        
        data.append(Subject(
            "Marvel Super Heroes",
            "Avengers, Assemble!",
            [
                Question(
                    "Who is Iron Man?",
                    "1",
                    [
                        "Tony Stark",
                        "Obadiah Stane",
                        "A rock hit by Megadeth",
                        "Nobody knows"
                    ]
                ),
                Question(
                    "Who founded the X-Men?",
                    "2",
                    [
                        "Tony Stark",
                        "Professor X",
                        "The X-Institute",
                        "Erik Lensherr"
                    ]
                ),
                Question(
                    "How did Spider-Man get his powers?",
                    "1",
                    [
                        "He was bitten by a radioactive spider",
                        "He ate a radioactive spider",
                        "He is a radioactive spider",
                        "He looked at a radioactive spider"
                    ]
                )
            ]
        ))
        
        data.append(Subject(
            "Mathematics",
            "Did you pass the third grade?",
            [
                Question(
                    "What is 2+2?",
                    "1",
                    [
                        "4",
                        "22",
                        "An irrational number",
                        "Nobody knows"
                    ]
                )
            ]
        ))
    }
}
