//
//  ResultViewController.swift
//  PersonalQuizApp
//
//  Created by Egor Yakovin on 18.11.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    var test: [Answer]!

    @IBOutlet weak var animalDescriptionLabel: UILabel!
    @IBOutlet weak var animalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }
    
    private func updateResult() {
        var frequencyOfAnimal: [Animal: Int] = [:]
        let animals = test.map {$0.animal}
        
        for animal in animals {
            if let countOfAnimals = frequencyOfAnimal[animal] {
                frequencyOfAnimal.updateValue(countOfAnimals + 1, forKey: animal)
            } else {
                frequencyOfAnimal[animal] = 1
            }
        }
        let sortedFrequencyOfAnimal = frequencyOfAnimal.sorted { $0.value > $1.value }
        guard let mostPopularAnimal = sortedFrequencyOfAnimal.first?.key else { return }
        
        updateUI(with: mostPopularAnimal)
    }
    
    private func updateUI(with animal: Animal?) {
        animalLabel.text = "Вы - \(animal?.rawValue ?? "!")"
        animalDescriptionLabel.text = animal?.definition ?? ""
    }
}
