
import Foundation

struct Question {
    init(q: String, a: String) {
        text = q
        answer = a
    }
    let text: String
    let answer: String
}
