//  Created by Lucas Real Dias on 01/04/23.

import SwiftUI

struct ContentView: View {
    
    @State private var correctAnwser = Int.random(in: 0..<3)
    @State private var counter = 0
    @State private var score = 0
    @State private var titleDescription = ""
    
    @State private var showMessage = false
    @State private var showFinalMessage = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.title).bold()
                
                Spacer()
                
                Text(countries[correctAnwser])
                    .font(.system(size: 65)).fontWeight(.ultraLight)
                
                ForEach(0..<3) { number in
                    Button {
                        tappedButton(number)
                    } label: {
                        Image(countries[number])
                            .cornerRadius(20)
                            .shadow(color: .white, radius: 3)
                    }
                    .padding(10)
                }
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white).bold()
                    .font(.system(size: 30))
                
                Text("Counter: \(counter)")
                    .foregroundColor(.white).fontWeight(.light)
                    .font(.system(size: 30))
                
                Spacer()
                Spacer()
            }
            
            .alert(titleDescription, isPresented: $showMessage) {
                Button("Ok", action: askQuestion)
            } message: {
                Text("Score: \(score)")
            }
            
            .alert(titleDescription, isPresented: $showFinalMessage) {
                Button("Restart", action: reset)
            } message: {
                Text("Final score: \(score)")
            }
        }
    }
    
    func tappedButton(_ number: Int) {
        if counter == 7 {
            score += 1
            showFinalMessage = true
        } else {
            if correctAnwser == number {
                score += 1
                titleDescription = "Correct"
            } else if correctAnwser != number && score != 0 {
                score -= 1
                titleDescription = "Wrong"
            }
            showMessage = true
        }
        counter += 1
    }
    
    func askQuestion() {
        correctAnwser = Int.random(in: 0..<3)
        countries.shuffle()
    }
    
    func reset() {
        counter = 0
        score = 0
        correctAnwser = Int.random(in: 0..<3)
        countries.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
