//
//  QuestionViewController.swift
//  PersonalQuizApp
//
//  Created by Egor Yakovin on 17.11.2022.
//

import UIKit

class QuestionViewController: UIViewController {
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var chosenAnswers: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }

    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionTitle: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleAnswerButton: [UIButton]!
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let currentIndex = singleAnswerButton.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[currentIndex]
        chosenAnswers.append(currentAnswer)
        questionIndex += 1
        updateUI()
    }
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleAnswerTitle: [UILabel]!
    @IBOutlet var multipleAnswerSwitches: [UISwitch]!
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        for (answer, multipleSwitch) in zip(currentAnswers, multipleAnswerSwitches) {
            if multipleSwitch.isOn {
                chosenAnswers.append(answer)
            }
        }
        questionIndex += 1

        updateUI()
    }
    
    

    @IBOutlet weak var rangedAnswerSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedAnswerSlider.maximumValue = answerCount
            rangedAnswerSlider.value = answerCount / 2
        }
    }
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBAction func rangedAnswerButtonPressed() {
        let currentIndex = lrintf(rangedAnswerSlider.value)
        let currentAnswer = currentAnswers[currentIndex]
        chosenAnswers.append(currentAnswer)
        print("asd \(currentAnswer)")
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
   
    
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        var currentQuestion = questions[questionIndex]
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        questionTitle.text = currentQuestion.title
        let currentProgress = Float(questionIndex) / Float(questions.count)
        progressView.setProgress(currentProgress, animated: true)
        
        switch currentQuestion.responseType {
        case .single:
            singleStackView.isHidden = false
            for (button, answer) in zip(singleAnswerButton, currentQuestion.answers) {
                button.setTitle(answer.title, for: .normal)
            }
        case .multiple:
            multipleStackView.isHidden = false
            for (label, answer) in zip(multipleAnswerTitle, currentQuestion.answers) {
                label.text = answer.title
            }
        case .ranged:
            rangedStackView.isHidden = false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.test = chosenAnswers
    }
    
    
}
