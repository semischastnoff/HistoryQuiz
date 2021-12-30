//
//  QuestionView.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import SwiftUI

struct QuestionView: View {
    @StateObject var questionsModel: QuestionsModel = QuestionsModel.shared
    
    var body: some View {
        TabView {
            ForEach(self.questionsModel.data, id: \.self) {item in
                QuestionCard(question: item.question, variousAnswers: item.variousAnswers, correctAnswerIndex: item.correctAnswerIndex)
            }
        }
        .tabViewStyle(.page)
        .overlay(NavBar(title: "Вопросы"))
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
