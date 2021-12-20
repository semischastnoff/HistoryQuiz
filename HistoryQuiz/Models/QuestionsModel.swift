//
//  QuestionsModel.swift
//  HistoryQuiz
//
//  Created by Данила Семисчастнов on 17.12.2021.
//

import Foundation

class QuestionsModel: ObservableObject {
    @Published var data: [QuestionElement] = [
        QuestionElement(question: "В каком возрасте Петр вступил на русский престол?", variousAnswers: ["20", "5", "10", "19"], correctAnswerIndex: 2),
        QuestionElement(question: "Он был последним русским царем, но первым:", variousAnswers: ["императором", "королем", "шейхом", "фараоном"], correctAnswerIndex: 0),
        QuestionElement(question: "Петр Алексеевич был инициатором открытия первого учебного заведения для девочек. Какое название присвоено этому заведению?", variousAnswers: ["Смольный монастырь", "Институт благородных девиц", "юнкерское училище", "Новодевичий монастырь"], correctAnswerIndex: 1),
        QuestionElement(question: "Основателем какого города стал Петр Первый?", variousAnswers: ["Москва", "Санкт-Петербург", "Елец", "Тула"], correctAnswerIndex: 1),
        QuestionElement(question: "За что Петр получил титул Великий?", variousAnswers: ["за победу в войне", "за выдающиеся умственные способности", "за многочисленные преобразования в России и придания государству статуса ведущей европейской державы", "за реформы в образовании"], correctAnswerIndex: 2),
        QuestionElement(question: "Куда выводит «окно», прорубленное Петром?", variousAnswers: ["Европу", "Америку", "Азию", "Северный полюс"], correctAnswerIndex: 0),
        QuestionElement(question: "Петр Первый, вернувшись из заграницы организовал музей редкостей, получивший название:", variousAnswers: ["Эрмитаж", "Музей восковых фигур", "Русский музей", "Кунсткамера"], correctAnswerIndex: 3),
        QuestionElement(question: "История развития какого города, кроме Санкт-Петербурга, тесно связан с именем Петра?", variousAnswers: ["Венеция", "Липецк", "Воронеж", "Муромск"], correctAnswerIndex: 1),
        QuestionElement(question: "Какой псевдоним взял государь для путешествия заграницей?", variousAnswers: ["Михайлов", "Романов", "Белкин", "Иван Иванович"], correctAnswerIndex: 0),
        QuestionElement(question: "Сколькими ремеслами овладел Петр Алексеевич?", variousAnswers: ["1", "20", "15", "14"], correctAnswerIndex: 3)
    ]
    
    @Published var currnetIndex: Int = 0
    
    @Published var didSolveQuestion: Bool = false
    
    @Published var time: Int = 10
    
    @Published var insideQuizView: Bool = false
    
    var timer: Timer!
    
    func startTimer() {
        if (self.timer != nil) {
            self.timer.invalidate()
        }
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer(sender:)), userInfo: nil, repeats: true)
        self.currnetIndex += 1
    }
    
    @objc func decreaseTimer(sender: Timer) {
        if (self.time == 0) {
            sender.invalidate()
            self.time = 10
            self.didSolveQuestion.toggle()
            if (self.currnetIndex == self.data.count - 1) {

                self.currnetIndex += 1

            }
            self.startTimer()
        } else {
            self.time -= 1
        }
    }
    
    private var themesToQuestionsDict: [QuestionsThemes : [QuestionElement]] = [
        .peterTheFirst : [
            QuestionElement(question: "В каком возрасте Петр вступил на русский престол?", variousAnswers: ["20", "5", "10", "19"], correctAnswerIndex: 2),
            QuestionElement(question: "Он был последним русским царем, но первым:", variousAnswers: ["императором", "королем", "шейхом", "фараоном"], correctAnswerIndex: 0),
            QuestionElement(question: "Петр Алексеевич был инициатором открытия первого учебного заведения для девочек. Какое название присвоено этому заведению?", variousAnswers: ["Смольный монастырь", "Институт благородных девиц", "юнкерское училище", "Новодевичий монастырь"], correctAnswerIndex: 1),
            QuestionElement(question: "Основателем какого города стал Петр Первый?", variousAnswers: ["Москва", "Санкт-Петербург", "Елец", "Тула"], correctAnswerIndex: 1),
            QuestionElement(question: "За что Петр получил титул Великий?", variousAnswers: ["за победу в войне", "за выдающиеся умственные способности", "за многочисленные преобразования в России и придания государству статуса ведущей европейской державы", "за реформы в образовании"], correctAnswerIndex: 2),
            QuestionElement(question: "Куда выводит «окно», прорубленное Петром?", variousAnswers: ["Европу", "Америку", "Азию", "Северный полюс"], correctAnswerIndex: 0),
            QuestionElement(question: "Петр Первый, вернувшись из заграницы организовал музей редкостей, получивший название:", variousAnswers: ["Эрмитаж", "Музей восковых фигур", "Русский музей", "Кунсткамера"], correctAnswerIndex: 3),
            QuestionElement(question: "История развития какого города, кроме Санкт-Петербурга, тесно связан с именем Петра?", variousAnswers: ["Венеция", "Липецк", "Воронеж", "Муромск"], correctAnswerIndex: 1),
            QuestionElement(question: "Какой псевдоним взял государь для путешествия заграницей?", variousAnswers: ["Михайлов", "Романов", "Белкин", "Иван Иванович"], correctAnswerIndex: 0),
            QuestionElement(question: "Сколькими ремеслами овладел Петр Алексеевич?", variousAnswers: ["1", "20", "15", "14"], correctAnswerIndex: 3)
        ],
        .historyOfStPetersburg : [
            QuestionElement(question: "На месте, где Петра I впервые назвали императором России, сейчас стоит", variousAnswers: ["Ростральная колонна", "Памятный знак на Троицкой площади", "Памятник Суворову", "Эрмитаж"], correctAnswerIndex: 1),
            QuestionElement(question: "Какое здание Петербурга называлось \" красные хоромы \"", variousAnswers: ["Первая палатка, разбитая на заячьем острове", "Меньшиковский дворец", "Петергоф", "Домик Петра I"], correctAnswerIndex: 3),
            QuestionElement(question: "Какой собор - правопреемник церкви, в котором венчали Петра I и Екатерину I?", variousAnswers: ["Василия Блаженого", "Казанский", "Исаакиевский", "Спас на Крови"], correctAnswerIndex: 2),
            QuestionElement(question: "Когда Адмиралтейство только построили, что было в каре его зданий?", variousAnswers: ["Гавань", "Канал к верфи", "Жилые дома", "4"], correctAnswerIndex: 1),
            QuestionElement(question: "Куда делать ограда Собственного сада Зимнего дворца после революции?", variousAnswers: ["Ей оградили школу", "За нее купили у Америки 24 паравоза", "Поставили уцелевшие фрагменты у Сада им. 9 января", "4"], correctAnswerIndex: 2),
            QuestionElement(question: "skldfj", variousAnswers: ["1", "2", "3", "4"], correctAnswerIndex: 0),
            QuestionElement(question: "skldfj", variousAnswers: ["1", "2", "3", "4"], correctAnswerIndex: 0),
            QuestionElement(question: "skldfj", variousAnswers: ["1", "2", "3", "4"], correctAnswerIndex: 0),
            QuestionElement(question: "skldfj", variousAnswers: ["1", "2", "3", "4"], correctAnswerIndex: 0),
            QuestionElement(question: "skldfj", variousAnswers: ["1", "2", "3", "4"], correctAnswerIndex: 0)
        ],
        .interstingFacts : [
            QuestionElement(question: "В Петербурге в 3 раза больше мостов, чем в ...", variousAnswers: ["Амстердаме", "Венеции", "Риме", "Москве"], correctAnswerIndex: 1),
            QuestionElement(question: "Петербург является самым ... городом в мире с населением более миллиона человек.", variousAnswers: ["Северным", "Ветренным", "Морозным", "Молодым"], correctAnswerIndex: 0),
            QuestionElement(question: "Что в Петербурге является самым глубоким в мире?", variousAnswers: ["Дельта реки", "Каналы", "Метро", "4"], correctAnswerIndex: 2),
            QuestionElement(question: "Сколько фонтанов находится в Петергофе под Санкт-Петербургом?", variousAnswers: ["47", "78", "176", "23"], correctAnswerIndex: 2),
            QuestionElement(question: "Сколько островов в Петербурге, имеющих официальные названия?", variousAnswers: ["52", "35", "15", "14"], correctAnswerIndex: 1),
            QuestionElement(question: "Чем являлась Петропавловская крепость до 1924 года в связи с тем, что она никогда не использовалась как крепость?", variousAnswers: ["Царскими палатами", "Фабрикой", "Училищем", "Тюрьмой"], correctAnswerIndex: 3),
            QuestionElement(question: "Что в Петербурге является самым длинным в мире?", variousAnswers: ["Комплекс рек и каналов", "Улицы и проспекты", "Кольцевая дорога", "Трамвайные рельсы"], correctAnswerIndex: 3),
            QuestionElement(question: "Эта особенность памятника Николаю Первому, расположенная на Исаакиевской площади, является уникальной во всём мире.", variousAnswers: ["Памятник полностью сделан из титана", "На постаменте памятника расположены памятники кого-то ещё", "Скульптура памятника расположена на двух точках опоры", "4"], correctAnswerIndex: 2),
            QuestionElement(question: "Такова ещё одна особенность фонтанов Петергофа под Петербургом:", variousAnswers: ["Все фонтаны были созданы не более, чем за месяц", "Фонтаны Петергофа — самые высокие в мире", "Все фонтаны работают без помощи насосов", "4"], correctAnswerIndex: 2),
            QuestionElement(question: "Что располагалось на месте Санкт-Петербурга до его образования?", variousAnswers: ["Тундра", "Болото", "Пустырь", "Лес"], correctAnswerIndex: 1)
        ],
        
    ]
    
    func changeTheme(newTheme: QuestionsThemes) {
        self.data = self.themesToQuestionsDict[newTheme] ?? []
    }
}

struct QuestionElement: Identifiable, Hashable {
    var id = UUID()
    var question: String
    var variousAnswers: [String]
    var correctAnswerIndex: Int
}

enum QuestionsThemes: String, CaseIterable {
    case peterTheFirst = "Петр I"
    case historyOfStPetersburg = "История Санкт-Петербурга"
    case interstingFacts = "Интересные факты"
}
