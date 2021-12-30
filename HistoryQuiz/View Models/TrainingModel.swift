//
//  TrainingModel.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import Foundation

class TrainingModel: ObservableObject {
    let questionsModel: QuestionsModel = QuestionsModel()
//    @EnvironmentObject var questionsModel: QuestionsModel
    var swipedLeft = false
    var swipedRight = false
    
    enum SuccessState: String {
        case success = "Success"
        case tryBetter = "Try Better"
    }
    
    var answerState: SuccessState = .tryBetter
    
    func reorderDataOnSwipe() {
        if (self.swipedLeft) {
            self.questionsModel.pushFirstToTail()
            self.swipedLeft = false
        } else if (self.swipedRight) {
            self.questionsModel.popFirst()
            self.swipedRight = false
        }
    }
    
    func refreshData() {
        self.questionsModel.refresh()
    }
}
