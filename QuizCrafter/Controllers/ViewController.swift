import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {

        let userAnswer = sender.currentTitle
        let isCorrect = quizBrain.checkAnswer(userAnswer)
        
        if isCorrect {
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
        }
        
        quizBrain.nextQuestion()
        
        updateUI()
    }
    
    
    private func updateUI(loadImmediately: Bool = false) {
        Timer.scheduledTimer(withTimeInterval: loadImmediately ? 0.0 : 0.2, repeats: false) { _ in
            self.questionLabel.text = self.quizBrain.getQuestionText()
            self.scoreLabel.text = self.quizBrain.getScore()
        }
        
        let progress = quizBrain.getProgress()
        self.progressBar.setProgress(progress, animated: !loadImmediately)
        
        UIView.animate(withDuration: loadImmediately ? 0 : 0.2) {
            self.trueButton.backgroundColor = .clear
            self.falseButton.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI(loadImmediately: true)
    }


}

