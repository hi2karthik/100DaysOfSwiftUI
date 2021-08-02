//
//  ContentView.swift
//  Shared
//
//  Created by Karthigeyan Vijayakumar on 7/27/21.
//

import SwiftUI

struct ContentView: View {
    enum Moves: String {
        case Rock = "🪨"
        case Paper = "📄"
        case Scissors = "✂️"
        
        var winningMove: Moves {
            switch self {
            case .Rock:
                return .Paper
            case .Paper:
                return .Scissors
            case .Scissors:
                return .Rock
            }
        }
        
        var loosingMove: Moves {
            switch self {
            case .Rock:
                return .Scissors
            case .Paper:
                return .Rock
            case .Scissors:
                return .Paper
            }
        }
    }
    
    private let MAX_ROUNDS = 10
    
    @State private var possibleMoves = [Moves.Rock, Moves.Paper, Moves.Scissors]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var userScore = 0
    @State private var userRound = 1
    @State private var showingScore = false
    
    var body: some View {
        return ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
            VStack {
                Divider()
                Text("Rock! Paper! Scissors!")
                    .font(.largeTitle)
                Divider()
                VStack(spacing: 30) {
                    Spacer()
                    HStack {
                    Text("My Choice : ")
                    Text("\(possibleMoves[appChoice].rawValue)")
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2)

                    }
                    shouldWin ? Text("Your choice, to win?") : Text("Your choice, to loose?")
                    HStack(spacing: 30) {
                        ForEach(0..<3) { number in
                            Button(action: {
                                self.tapped(number)
                            }) {
                                Text(self.possibleMoves[number].rawValue)
                            }
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2)
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .roundMarked(with: "Round \(userRound)/\(MAX_ROUNDS)")
                .scoreMarked(with: "Score: \(userScore)")
                Spacer()
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Game Complete"), message: Text("Your score was : \(userScore)"), dismissButton: .default(Text("Restart Game")) {
                self.resetGame()
            })
        }
    }
    
    func tapped(_ number: Int) {
        let appAnswer = possibleMoves[appChoice]
        let userAnswer = possibleMoves[number]
        
        if shouldWin {
            if appAnswer.winningMove == userAnswer {
                userScore += 1
            } else {
                if (userScore > 0) {
                    userScore -= 1
                }
            }
        } else {
            if appAnswer.loosingMove == userAnswer {
                userScore += 1
            } else {
                if (userScore > 0) {
                    userScore -= 1
                }
            }
        }
        self.nextRound()
    }
    
    func nextRound() {
        if userRound == MAX_ROUNDS {
            showingScore = true
        } else {
            userRound += 1
            appChoice = Int.random(in: 0...2)
            shouldWin = Bool.random()
        }
    }
    
    func resetGame() {
        userRound = 1
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ScoreMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
            content
        }
    }
}

struct RoundMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
            content
        }
    }
}

extension View {
    func roundMarked(with text: String) -> some View {
        self.modifier(RoundMark(text: text))
    }
    
    func scoreMarked(with text: String) -> some View {
        self.modifier(ScoreMark(text: text))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
