//
//  ContentView.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 16.12.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var questionsModel = QuestionsModel.shared
    
    var body: some View {
        if self.questionsModel.showWelcomeScreen {
            WelcomeView()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .background(AngularGradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3), .red.opacity(0.3), .cyan.opacity(0.3), .blue.opacity(0.3)], center: .center))
                .ignoresSafeArea()
                .transition(.opacity)
        } else {
            Group {
                TabBar()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .background(AngularGradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3), .red.opacity(0.3), .cyan.opacity(0.3), .blue.opacity(0.3)], center: .center))
            .ignoresSafeArea()
            .transition(.opacity)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
