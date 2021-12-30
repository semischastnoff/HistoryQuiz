//
//  QuizView.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import SwiftUI

struct QuizView: View {
    @StateObject var quizModel = QuizViewModel()
    @State private var didStartQuiz: Bool = false
    
    private static let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    var body: some View {
        if self.didStartQuiz {
            if self.quizModel.isCurrentIndexCorrect() {
                VStack {
                    Text("Осталось: \(Int(self.quizModel.questionTimeThreshold) - Int(-self.quizModel.startTime.timeIntervalSinceNow))")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(y: 160)
                    
                    if self.quizModel.didSolveQuestion {
                        let questionElement = self.quizModel.getElement()
                        QuestionCard(question: questionElement.question, variousAnswers: questionElement.variousAnswers, correctAnswerIndex: questionElement.correctAnswerIndex)
                            .transition(.asymmetric(insertion: .scale, removal: .slide))
                            .offset(y: -30)
                    } else if self.quizModel.isCurrentIndexCorrect() {
                        let questionElement = self.quizModel.getElement()
                        QuestionCard(question: questionElement.question, variousAnswers: questionElement.variousAnswers, correctAnswerIndex: questionElement.correctAnswerIndex)
                            .transition(.asymmetric(insertion: .scale, removal: .slide))
                            .offset(y: -30)
                    }
                }
                .overlay(NavBar(title: "Викторина"))
            } else {
                GeometryReader {gp in
                    VStack {
                        VStack(spacing: 30) {
                            Text("Вы ответили на \(self.quizModel.numberOfCorrectAnswers) из \(self.quizModel.questionsModel.data.count)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.linearGradient(colors: [.purple, .primary], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Text("\(self.quizModel.cheerText())")
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(40)
                        .frame(width: gp.size.width - 40, height: gp.size.width - 40)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                        Button {
                            withAnimation(.easeIn) {
                                self.didStartQuiz = false
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
                    .overlay(NavBar(title: "Викторина"))
                }
            }
        } else {
            Button {
                withAnimation(.easeIn) {
                    self.didStartQuiz = true
                    self.quizModel.currentIndex = 0
                    self.quizModel.didSolveQuestion = false
                    self.quizModel.numberOfCorrectAnswers = 0
                    self.quizModel.setTimer()
                }
            } label: {
                Text("Начать")
                    .foregroundColor(.primary)
                    .font(.title2)
                    .scaledToFill()
            }
            .padding(30)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(NavBar(title: "Викторина"))
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
