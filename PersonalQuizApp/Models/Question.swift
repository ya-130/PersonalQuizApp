//
//  Question.swift
//  PersonalQuizApp
//
//  Created by Egor Yakovin on 17.11.2022.
//

import Foundation

struct Question {
    let title: String
    let responseType: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [Question(title: "Что вы любите кушать?",
                  responseType: .single,
                  answers: [
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Мясо", animal: .dog),
                    Answer(title: "Комары", animal: .frog),
                    Answer(title: "Сыр", animal: .mouse)
                  ]),
         Question(title: "Как вы любите проводить время?",
                  responseType: .multiple,
                  answers: [
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Играть", animal: .dog),
                    Answer(title: "Прыгать", animal: .frog),
                    Answer(title: "Прятаться", animal: .mouse)
                  ]),
        Question(title: "Насколько вы любите находиться с людьми?",
                 responseType: .ranged,
                 answers: [
                    Answer(title: "Ненавижу", animal: .frog),
                    Answer(title: "Терплю", animal: .mouse),
                    Answer(title: "Люблю", animal: .cat),
                    Answer(title: "Обожаю", animal: .dog)
                 ])]
    }
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

struct Answer {
    let title: String
    let animal: Animal
}

enum Animal: Character {
    case cat = "🐱"
    case dog = "🐶"
    case frog = "🐸"
    case mouse = "🐭"
    
    var definition: String {
        switch self {
        case .cat:
            return "Вы кошка"
        case .dog:
            return "Вы собака"
        case .frog:
            return "Вы лягушка"
        case .mouse:
            return "Вы мышь"
        }
    }
}
