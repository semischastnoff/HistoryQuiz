//
//  TrainigView.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import SwiftUI

struct TrainingView: View {
    @StateObject var trainingModel: TrainingViewModel = TrainingViewModel()
    @State private var showCard: Bool = false
    @State private var didStartTraining: Bool = false
    
    var body: some View {
        if self.didStartTraining {
            if self.trainingModel.isCurrentIndexCorrect() {
                self.mainTrainingCard
            } else {
                self.finishCard
            }
        } else {
            self.beforeBeginningView
        }
    }
    
    var beforeBeginningView: some View {
        Button {
            withAnimation(.easeIn) {
                self.didStartTraining.toggle()
                self.trainingModel.startTraining()
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
        .overlay(NavBar(title: "Тренировка"))
    }
    
    var mainTrainingCard: some View {
        VStack {
            Button {
                withAnimation {
                    self.showCard.toggle()
                    self.trainingModel.nextCard()
                    self.trainingModel.pushBackIfNeeded()
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
            
            if self.showCard {
                let questionElement = self.trainingModel.getCurrentElement(withOffset: 0)
                QuestionCard(question: questionElement.question, variousAnswers: questionElement.variousAnswers, correctAnswerIndex: questionElement.correctAnswerIndex)
                    .transition(.asymmetric(insertion: .scale, removal: .offset(x: self.trainingModel.swipeOffset())))
                    .offset(y: -30)
            } else if self.trainingModel.isCurrentIndexCorrect() {
                let questionElement = self.trainingModel.getCurrentElement(withOffset: 0)
                QuestionCard(question: questionElement.question, variousAnswers: questionElement.variousAnswers, correctAnswerIndex: questionElement.correctAnswerIndex)
                    .transition(.asymmetric(insertion: .scale, removal: .offset(x: self.trainingModel.swipeOffset())))
                    .offset(y: -30)
            }
        }
        .overlay(NavBar(title: "Тренировка"))
    }
    
    var finishCard: some View {
        GeometryReader {gp in
            VStack {
                Text("Вы ответили правильно на все вопросы")
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
                        self.trainingModel.startTraining()
                        self.showCard = false
                        self.didStartTraining = false
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

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
