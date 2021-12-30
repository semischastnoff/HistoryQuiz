//
//  TrainingViewModel.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 25.12.2021.
//

import Foundation
import CoreGraphics

class TrainingViewModel: ObservableObject {
    let questionsModel: QuestionsModel = QuestionsModel.shared
    var trainingData: [QuestionElement]?
    
    var currentIndex: Int = 0
    
    func startTraining() {
        self.trainingData = self.questionsModel.data.shuffled()
        self.currentIndex = 0
    }
    
    func getCurrentElement(withOffset offset: Int) -> QuestionElement {
        return self.trainingData?[self.currentIndex + offset] ?? QuestionElement(question: "", variousAnswers: [], correctAnswerIndex: 0)
    }
    
    func isCurrentIndexCorrect() -> Bool {
        return self.currentIndex != self.trainingData?.count ?? 1 - 1
    }
    
    func nextCard() {
        if self.isCurrentIndexCorrect() {
            self.currentIndex += 1
        }
    }
    
    func swipeOffset() -> CGFloat {
        return self.questionsModel.currentTrainingAnswerState ? 500 : -500
    }
    
    func pushBackIfNeeded() {
        if !self.questionsModel.currentTrainingAnswerState {
            let currentElement = self.getCurrentElement(withOffset: -1)
            self.trainingData?.append(currentElement)
        }
    }
}
