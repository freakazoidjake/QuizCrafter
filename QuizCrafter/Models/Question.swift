
import Foundation

struct Question {
    // FIXME For True/False only
    init(q: String, a: String) {
        text = q
        answers = ["True", "False"]
        correctAnswer = a
    }
    
    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answers = a
        self.correctAnswer = correctAnswer
    }
    
    let text: String
    let answers: [String]
    let correctAnswer: String
}
