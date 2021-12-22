//
//  TabBar.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import SwiftUI

struct TabBar: View {
    @EnvironmentObject var questionsModel: QuestionsModel
    @State private var selectedTab: Tab = .questions
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            self.mainCard
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            self.currentTheme
            
            HStack {
                ForEach(Tab.allCases, id: \.self) {item in
                    Button (action: {
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.selectedTab = item
                            if (item == .quiz) {
                                self.questionsModel.insideQuizView = true
                            } else {
                                self.questionsModel.insideQuizView = false
                            }
                        }
                    }, label: {
                        VStack(spacing: 5) {
                            if (item.rawValue == "Вопросы") {
                                Image(systemName: "questionmark.circle.fill")
                            } else if (item.rawValue == "Тренировка") {
                                Image(systemName: "repeat")
                            } else if (item.rawValue == "Викторина") {
                                Image(systemName: "graduationcap.fill")
                            }
                            Text(item.rawValue)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .accentColor(self.selectedTab == item ? .purple : .primary)
                    })
                    if (item.rawValue != "Викторина") {
                        Spacer()
                    }
                }
            }
            .padding()
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 90, alignment: .top)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30))
            .background(
                HStack {
                    if (self.selectedTab == .quiz) {
                        Spacer(minLength: 10)
                    }
                    Circle().fill(.purple).frame(width: 90)
                    if (self.selectedTab == .questions) {
                        Spacer()
                    }
                }
                .padding(.horizontal)
            )
            .overlay(
                HStack {
                    if (self.selectedTab == .quiz) {
                        Spacer()
                    }
                    Rectangle()
                        .fill(.purple.opacity(0.6))
                        .frame(width: 40, height: 5)
                        .cornerRadius(3)
                        .frame(width: 90)
                        .frame(maxHeight: .infinity, alignment: .top)
                    if (self.selectedTab == .questions) {
                        Spacer()
                    }
                }
                .padding(.horizontal)
        )
        }
    }
    
    var mainCard: some View {
        Group {
            switch self.selectedTab {
            case .questions:
                QuestionView()
            case .training:
                TrainingView()
            case .quiz:
                QuizView()
            }
        }
    }
    
    var currentTheme: some View {
        Group {
            if (self.selectedTab == .questions) {
                VStack {
                    Text("Текущая тема:")
                    Text(self.questionsModel.currentTheme.rawValue)
                }
                .font(.title3)
                .foregroundColor(.primary)
                .padding()
                .padding(.horizontal)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 10)
                .offset(y: -620)
            }
        }
    }
}

enum Tab: String, CaseIterable {
    typealias RawValue = String
    
    case questions = "Вопросы"
    case training = "Тренировка"
    case quiz = "Викторина"
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
