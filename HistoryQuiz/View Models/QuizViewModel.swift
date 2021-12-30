//
//  QuizViewModel.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 25.12.2021.
//

import Foundation

class QuizViewModel: ObservableObject {
    let questionsModel = QuestionsModel.shared
    
    @Published var startTime: Date = .now
    private var timer: Timer!
    let questionTimeThreshold: TimeInterval = 10
    
    @Published var currentIndex: Int = 0
    
    @Published var didSolveQuestion: Bool = false
    
    @Published var numberOfCorrectAnswers: Int = 0
    
    func setTimer() {
        if self.timer != nil {
            self.timer.invalidate()
        }
        self.startTime = .now
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer(sender:)), userInfo: nil, repeats: true)
    }
    
    @objc func decreaseTimer(sender: Timer) {
        if -self.startTime.timeIntervalSinceNow > self.questionTimeThreshold {
            sender.invalidate()
            self.startTime = .now
            self.didSolveQuestion.toggle()
            if self.currentIndex == self.questionsModel.data.count - 1 {
                self.nextCard()
            }
            self.nextCard()
        } else {
            self.objectWillChange.send()
        }
    }
    
    func nextCard() {
        if self.currentIndex != self.questionsModel.data.count - 1 {
            self.currentIndex += 1
            self.questionsModel.didTapCheckButtonForQuiz = false
            if self.questionsModel.currentQuizAnswerState {
                self.numberOfCorrectAnswers += 1
            }
            self.setTimer()
        }
    }
    
    func getElement() -> QuestionElement {
        return self.questionsModel.data[self.currentIndex]
    }
    
    func isCurrentIndexCorrect() -> Bool {
        return self.currentIndex != self.questionsModel.data.count - 1
    }
    
    func cheerText() -> String {
        let percentage: Double = Double(self.numberOfCorrectAnswers) / Double(self.questionsModel.data.count)
        self.questionsModel.storeStatistics(date: Date.now, result: percentage)
        if percentage <= 0.2 {
            return "Лучше подучить тему и вернуться к викторине позже"
        } else if percentage > 0.2 && percentage <= 0.5 {
            return "Немного повторения не помешает"
        } else if percentage > 0.5 && percentage <= 0.8 {
            return "Уже хорошо, но можно лучше"
        } else {
            return "Отличная работа"
        }
    }
}
