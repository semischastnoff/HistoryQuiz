//
//  TrainigView.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import SwiftUI

struct TrainingView: View {
    @EnvironmentObject var questionsModel: QuestionsModel
    @State private var showCard: Bool = false
    
    var body: some View {
        if (self.questionsModel.currnetIndex != self.questionsModel.data.count - 1) {
            VStack {
                Button {
                    withAnimation {
                        self.showCard.toggle()
                        self.questionsModel.currnetIndex = min(self.questionsModel.currnetIndex + 1, self.questionsModel.data.count - 1)
                    }
                } label: {
                    Text("Следующий вопрос")
                        .scaledToFill()
                        .foregroundColor(.primary)
                }
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 10)
                .offset(y: 150)
                
                if (self.showCard) {
                    let questionElement = self.questionsModel.data[self.questionsModel.currnetIndex]
                    QuestionCard(question: questionElement.question, variousAnswers: questionElement.variousAnswers, correctAnswerIndex: questionElement.correctAnswerIndex)
                        .transition(.asymmetric(insertion: .scale, removal: .slide))
                        .offset(y: -30)
                } else if (self.questionsModel.currnetIndex < self.questionsModel.data.count - 1) {
                    let questionElement = self.questionsModel.data[self.questionsModel.currnetIndex]
                    QuestionCard(question: questionElement.question, variousAnswers: questionElement.variousAnswers, correctAnswerIndex: questionElement.correctAnswerIndex)
                        .transition(.asymmetric(insertion: .scale, removal: .slide))
                        .offset(y: -30)
                }
            }
            .overlay(NavBar(title: "Тренировка"))
        } else {
            GeometryReader {gp in
                VStack {
                    Text("Вы ответили на все вопросы")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.linearGradient(colors: [.purple, .primary], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(40)
                        .frame(width: gp.size.width - 40, height: gp.size.width - 40)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    Button {
                        withAnimation(.easeIn) {
                            self.questionsModel.currnetIndex = 0
                            self.showCard = false
                        }
                    } label: {
                        Text("Заново")
                            .scaledToFill()
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 10)
                    .offset(y: -170)
                }
                .overlay(NavBar(title: "Тренировка"))
            }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
