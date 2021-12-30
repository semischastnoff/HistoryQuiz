//
//  WelcomeView.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 27.12.2021.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var questionsModel = QuestionsModel.shared
    
    var body: some View {
        GeometryReader { gp in
            VStack(spacing: gp.size.height / 8) {
                Text("Выберите тему")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.purple, .primary], startPoint: .topLeading, endPoint: .bottomTrailing))
                VStack(spacing: 10) {
                    ForEach(QuestionsThemes.allCases, id: \.self) { item in
                        Button {
                            withAnimation(.spring()) {
                                self.questionsModel.changeTheme(newTheme: item)
                                self.questionsModel.showWelcomeScreen = false
                            }
                        } label: {
                            Text(item.rawValue)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.linearGradient(colors: [.purple, .primary], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: gp.size.width - 100, alignment: .center)
                                .padding()
                        }
                    }
                }
                .padding()
                .frame(width: gp.size.width - 40)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 10)
                .animation(.spring(), value: 180)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
