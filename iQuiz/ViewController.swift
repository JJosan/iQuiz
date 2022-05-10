//
//  ViewController.swift
//  iQuiz
//
//  Created by Jason Nguyen on 5/3/22.
//

import UIKit

class QuizCell: UITableViewCell {
    
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let data : [(UIImage, String, String)] = [
        (UIImage(named: "math")!, "Mathematics", "Stuff about math"),
        (UIImage(named: "superhero")!, "Super Heroes", "Stuff about super heroes"),
        (UIImage(named: "science")!, "Science", "Stuff about Science")
    ]
    
    @IBOutlet weak var tableView_quiz: UITableView!

    @IBAction func toolbarItem_settings(_ sender: Any) {
        alert("Settings", "Settings go here")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView_quiz.delegate = self
        tableView_quiz.dataSource = self
        tableView_quiz.rowHeight = 75.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath)
        
        let curr = data[indexPath.row]
        
        cell.imageView?.image = curr.0
        cell.textLabel?.text = curr.1
        cell.detailTextLabel?.text = curr.2
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item = data[indexPath.row].1
        alert(item, "questions for \"\(item)\" will be here")
        //performSegue(withIdentifier: "DESTINATION", sender: item)
    }
    
    func alert(_ title : String, _ message : String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}
