//
//  QuestionsModel.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import Foundation
import CoreData

class QuestionsModel: ObservableObject {
    static let shared = QuestionsModel()
    
    enum FetchState {
        case errorOccured
        case notFetching
        case fetchingData
        case sucessfullyFetched
    }
    
    @Published var fetchState: FetchState = .notFetching
    @Published var showWelcomeScreen: Bool = true
    
    @Published var data: [QuestionElement] = []
    
    @Published var currentTheme: QuestionsThemes = .peterTheFirst
    
    @Published var currentTrainingAnswerState: Bool = false
    
    @Published var currentQuizAnswerState: Bool = false
    @Published var didTapCheckButtonForQuiz: Bool = false
    
    private var themesToQuestionsDict: [QuestionsThemes : [QuestionElement]] = [
        .peterTheFirst : [],
        .historyOfStPetersburg : [],
        .interstingFacts : []
    ]
    
    init() {
        self.fetchData()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        // 2
        let container = NSPersistentContainer(name: "QuizStatistics")
        // 3
        container.loadPersistentStores { _, error in
        // 4
            if let error = error as NSError? {
                // You should add your own error handling code here.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        // 1
        let context = self.persistentContainer.viewContext
        // 2
        if context.hasChanges {
            do {
                // 3
                try context.save()
            } catch {
                // 4
                // The context couldn't be saved.
                // You should add your own error handling here.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func changeTheme(newTheme: QuestionsThemes) {
        self.currentTheme = newTheme
        self.data = self.themesToQuestionsDict[newTheme] ?? []
    }
    
    func fetchData() {
        guard let url = URL(string: "https://b10d7b33-51d0-4753-8343-e56cb613e4d7.mock.pstmn.io/peterTheFirst") else {
            self.fetchState = .errorOccured
            return
        }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared.dataTask(with: request) { data, _, _ in
            if let fetchedData = data {
                print(String(decoding: fetchedData, as: UTF8.self))
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(QuestionThemesDict.self, from: fetchedData)
                    for item in decodedData.peterTheFirst {
                        self.themesToQuestionsDict[.peterTheFirst]?.append(QuestionElement(question: item.question,
                                                                                           variousAnswers: item.variousAnswers,
                                                                                           correctAnswerIndex: item.correctAnswerIndex))
                    }
                    for item in decodedData.historyOfStPetersburg {
                        self.themesToQuestionsDict[.historyOfStPetersburg]?.append(QuestionElement(question: item.question,
                                                                                           variousAnswers: item.variousAnswers,
                                                                                           correctAnswerIndex: item.correctAnswerIndex))
                    }
                    for item in decodedData.interstingFacts {
                        self.themesToQuestionsDict[.interstingFacts]?.append(QuestionElement(question: item.question,
                                                                                           variousAnswers: item.variousAnswers,
                                                                                           correctAnswerIndex: item.correctAnswerIndex))
                    }
                    DispatchQueue.main.async {
                        self.data = self.themesToQuestionsDict[.peterTheFirst] ?? [QuestionElement(question: "", variousAnswers: [], correctAnswerIndex: 0)]
                        print(self.data)
                    }
                } catch {
                    print("Didn't manage to decode data")
                }
            }
        }
        session.resume()
    }
    
    func storeStatistics(date: Date, result: Double) {
        
    }
}

struct QuestionElement: Codable, Identifiable, Hashable {
    var id = UUID()
    var question: String
    var variousAnswers: [String]
    var correctAnswerIndex: Int
}

struct QuestionThemesDict: Codable {
    let peterTheFirst, historyOfStPetersburg, interstingFacts: [ThemeStruct]
}

struct ThemeStruct: Codable {
    let question: String
    let variousAnswers: [String]
    let correctAnswerIndex: Int
}

enum QuestionsThemes: String, CaseIterable {
    case peterTheFirst = "Петр I"
    case historyOfStPetersburg = "История Санкт-Петербурга"
    case interstingFacts = "Интересные факты"
}
