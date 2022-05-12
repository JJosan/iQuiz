//
//  TempThings.swift
//  iQuiz
//
//  Created by Jason Nguyen on 5/12/22.
//

import Foundation

class Subject {
    var title : String
    var desc : String
    var questions : [Question]
    init(_ title : String, _ desc : String, _ questions : [Question]) {
        self.title = title
        self.desc = desc
        self.questions = questions
    }
}

class Question {
    var text : String
    var answer : String
    var answers : [String]
    init (_ text : String, _ answer : String, _ answers : [String]) {
        self.text = text
        self.answer = answer
        self.answers = answers
    }
}
