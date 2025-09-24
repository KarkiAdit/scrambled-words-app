//
//  ContentView.swift
//  ScrambledWords
//

import SwiftUI

struct GameView: View {
    @State private var guessedLetters: [Letter] = []
    @State private var showSuccess = false
    @State private var showFailure = false
    @State private var score = 0
    @State private var questions: [Question] = Question.generateQuestions()
    @State private var currentQuestionIndex = 0
    @State private var showFinalScore = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Spacer()
                        Image(questions[currentQuestionIndex].image)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                        HStack {
                            ForEach(guessedLetters) {
                                guessedLetter in
                                VStack {
                                    LetterView(letter: guessedLetter)
                                        .onTapGesture {
                                            if let index = guessedLetters.firstIndex(of: guessedLetter) {
                                                guessedLetters.remove(at: index)
                                                questions[currentQuestionIndex].scrambledLetters[guessedLetter.id].text = guessedLetter.text
                                            }
                                        }
                                    
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 25, height: 2)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    
                    .frame(width: proxy.size.width * 0.9, height: proxy.size.width * 0.9)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.border,
                                    lineWidth: 2)
                    }
                    Text("Score: \(score)")
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .padding(.top)
                    HStack {
                        ForEach(Array(questions[currentQuestionIndex].scrambledLetters.enumerated()), id: \.1) { index, letter in
                            LetterView(letter: letter)
                                .onTapGesture {
                                    if !letter.text.isEmpty {
                                        guessedLetters.append(letter)
                                        questions[currentQuestionIndex].scrambledLetters[index].text = ""
                                        if guessedLetters.count == questions[currentQuestionIndex].scrambledLetters.count {
                                            // Evaluate if right or wrong
                                            let guessedAnswer = guessedLetters.map {$0.text}.joined()
                                            if guessedAnswer == questions[currentQuestionIndex].answer{
                                                showSuccess = true
                                                score += 1
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                                    showSuccess = false
                                                    if currentQuestionIndex == questions.count - 1 {
                                                        showFinalScore = true
                                                    } else {
                                                        currentQuestionIndex += 1
                                                    }
                                                })
                                            } else {
                                                showFailure = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                                    showFailure = false
                                                    if currentQuestionIndex == questions.count - 1 {
                                                        showFinalScore = true
                                                    } else {
                                                        currentQuestionIndex += 1
                                                    }
                                                })
                                            }
                                            guessedLetters.removeAll()
                                        }
                                    }
                                }
                        }
                    }
                }
                if showFailure {
                    VStack {
                        Image("cross")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.7))
                }
                if showSuccess {
                    VStack {
                    Image("tick")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.7))}
            }
        }
        .sheet(isPresented: $showFinalScore) {
            // Restart the game again
            questions = Question.generateQuestions()
            currentQuestionIndex = 0
            score = 0
        } content: {
            ScoreView(score: score, questionCount: questions.count )
        }
    }
}

#Preview {
    GameView()
}

