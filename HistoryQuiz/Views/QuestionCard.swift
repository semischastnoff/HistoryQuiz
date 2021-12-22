//
//  QuestionCard.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import SwiftUI

enum ButtonID: String, CaseIterable {
    case btn1 = "1"
    case btn2 = "2"
    case btn3 = "3"
    case btn4 = "4"
}

enum AnswerState: String {
    case correct = "Правильно"
    case incorrect = "Неправильно"
}

struct QuestionCard: View {
    @State var question: String = ""
    @State var variousAnswers: [String] = []
    @State var correctAnswerIndex: Int = 0
    @State var isClicked: [ButtonID : Bool] = [.btn1 : false, .btn2 : false, .btn3 : false, .btn4 : false]
    @EnvironmentObject var questionsModel: QuestionsModel
    @State private var answerState: AnswerState = .incorrect
    @State private var showAnswer: Bool = false
    @State private var currentColor: Color = .yellow
    @State private var index: Int = 0
    
    @State private var buttonWidth: CGFloat = 100
    @State private var buttonHeight: CGFloat = 30
    
    func animate(id: ButtonID) {
        self.isClicked[id]?.toggle()
        self.showAnswer = false
        self.currentColor = .yellow
        for currentID in ButtonID.allCases {
            if (id != currentID && self.isClicked[currentID] ?? false) {
                self.isClicked[currentID]? = false
            }
        }
    }
    
    func checkAnswer() {
        if (self.index == self.correctAnswerIndex) {
            self.answerState = .correct
            self.currentColor = .green
        } else {
            self.answerState = .incorrect
            self.currentColor = .red
        }
        self.showAnswer = true
    }
    
    var body: some View {
        GeometryReader { gp in
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text(self.question)
                        .fontWeight(.bold)
                        .foregroundStyle(.linearGradient(colors: [.purple, .primary], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                        .rotation3DEffect(self.showAnswer ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                        .fixedSize(horizontal: false, vertical: true)
                        .scaledToFit()
                        .padding(.top, 20)
                    
                    self.buttons
//                        .rotation3DEffect(self.showAnswer ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                }
                .padding(40)
                .frame(width: gp.size.width - 40, height: gp.size.width - 40)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//                .rotation3DEffect(self.showAnswer ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .animation(.spring(), value: 180)
                .buttonStyle(.plain)
                
                self.checkButton
                    .offset(y: 250)
            }
        }
    }
    
    var checkButton: some View {
        Button {
            withAnimation(.easeIn) {
                self.checkAnswer()
                if (self.questionsModel.insideQuizView) {
                    self.questionsModel.startTimer()
                }
            }
        } label: {
            Text("Проверить")
                .foregroundColor(.primary)
                .font(.title2)
                .scaledToFill()
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: .primary.opacity(0.3), radius: 10, x: 0, y: 10)
    }
    
    var buttons: some View {
        HStack(spacing: 50) {
            VStack(spacing: 20) {
                Button {
                    withAnimation(.easeIn) {
                        self.animate(id: .btn1)
                        self.index = 0
                    }
                } label: {
                    Text(self.variousAnswers[0])
                        .font(.footnote)
                        .frame(width: self.buttonWidth, height: self.buttonHeight, alignment: .center)
                        .padding(5)
                        .background(self.isClicked[.btn1] ?? false ? self.currentColor.opacity(0.5) : .purple.opacity(0.5), in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .scaledToFit()
                }
                .contextMenu {
                    Text(self.variousAnswers[0])
                }
                Button {
                    withAnimation(.easeIn) {
                        self.animate(id: .btn3)
                        self.index = 2
                    }
                } label: {
                    Text(self.variousAnswers[2])
                        .font(.footnote)
                        .frame(width: self.buttonWidth, height: self.buttonHeight, alignment: .center)
                        .padding(5)
                        .background(self.isClicked[.btn3] ?? false ? self.currentColor.opacity(0.5) : .purple.opacity(0.5), in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .scaledToFit()
                }
                .contextMenu {
                    Text(self.variousAnswers[2])
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 20) {
                Button {
                    withAnimation(.easeIn) {
                        self.animate(id: .btn2)
                        self.index = 1
                    }
                } label: {
                    Text(self.variousAnswers[1])
                        .font(.footnote)
                        .frame(width: self.buttonWidth, height: self.buttonHeight, alignment: .center)
                        .padding(5)
                        .background(self.isClicked[.btn2] ?? false ? self.currentColor.opacity(0.5) : .purple.opacity(0.5), in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .scaledToFit()
                }
                .contextMenu {
                    Text(self.variousAnswers[1])
                }
                Button {
                    withAnimation(.easeIn) {
                        self.animate(id: .btn4)
                        self.index = 3
                    }
                } label: {
                    Text(self.variousAnswers[3])
                        .font(.footnote)
                        .frame(width: self.buttonWidth, height: self.buttonHeight, alignment: .center)
                        .padding(5)
                        .background(self.isClicked[.btn4] ?? false ? self.currentColor.opacity(0.5) : .purple.opacity(0.5), in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .scaledToFit()
                }
                .contextMenu {
                    Text(self.variousAnswers[3])
                }
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct QuestionCard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
