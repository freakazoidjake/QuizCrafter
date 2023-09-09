import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
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
        let question = self.quizBrain.getQuestion()
        
        let buttons = self.stackView.subviews.filter { subview in
            subview is UIButton
        } as? [UIButton] ?? []
        
        UIView.animate(withDuration: loadImmediately ? 0.0 : 0.2) {
            buttons.forEach { button in
                button.backgroundColor = .clear
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: loadImmediately ? 0.0 : 0.2, repeats: false) { _ in
            self.questionLabel.text = question.text
            self.scoreLabel.text = self.quizBrain.getScore()
            
            let indicies = (0...buttons.count - 1).reversed()
            
            for i in indicies {
                let button = buttons[i] as UIButton
                if i > question.answers.count - 1 {
                    button.isHidden = true
                    continue
                }
                button.isHidden = false
                let answer = question.answers[i]
                
                button.setTitle(answer, for: .normal)
                
                button.sizeToFit()
                button.layoutIfNeeded()
            }

        }
        
        let progress = quizBrain.getProgress()
        self.progressBar.setProgress(progress, animated: !loadImmediately)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI(loadImmediately: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

