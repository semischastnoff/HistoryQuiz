//
//  NavBar.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import SwiftUI

struct NavBar: View {
    @State var title: String = ""
    @State var showMenu = false
    @EnvironmentObject var questionsModel: QuestionsModel
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.thinMaterial)
            
            HStack {
                Text(self.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom)
                .padding(.leading, 20)
                Menu {
                    ForEach(QuestionsThemes.allCases, id: \.self) {item in
                        Button {
                            withAnimation {
                                self.questionsModel.changeTheme(newTheme: item)
                            }
                        } label: {
                            Text(item.rawValue)
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
                .font(.largeTitle)
                .foregroundColor(.primary)
                .frame(width: 70, height: 70, alignment: .center)
                .offset(y: 20)
//                .padding(.bottom, 30)
//                .padding(.trailing, 20)
            }
        }
        .frame(height: 110)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
