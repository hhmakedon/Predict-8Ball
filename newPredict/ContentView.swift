//
//  ContentView.swift
//  Predict
//
//  Created by Havee Makedon on 6/25/25.
//

import SwiftUI
import AVFAudio
import UIKit

struct ContentView: View {
    let notificationGenerator = UINotificationFeedbackGenerator()
    @State private var prediction = "Magic 8Ball"
    @State private var audioPlayer: AVAudioPlayer!
    private let choicesArray = ["It is certain.", "It is decidedly so.", "Without a doubt.", "Yes - definitely.", "You may rely on it.", "As I see it, yes.", "Most likely.", "Outlook good.", "Yes.", "Signs point to yes.", "Reply hazy try again.", "Ask again later.", "Better not tell you now.", "Cannot predict now.", "Concentrate and ask again.", "Don't count on it.", "My reply is no.", "My sources say no.", "Outlook not so good.", "Very doubtful."]
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 ERROR: Could not read file named \(soundName).")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) when trying to create audioPlayer.")
        }
    }
    
    var body: some View {
        ZStack {
            // White background that fills the entire safe‑area and beyond
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                ZStack {
                    Image("predict-ball-image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                    Circle()
                        .foregroundStyle(.indigo)
                        .frame(width: 140, height: 140)
                        .offset(y: -20)
                    Text(prediction)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.4)
                        .multilineTextAlignment(.center)
                        .frame(width: 90, height: 100)
                        .offset(y: -20)
                        .foregroundStyle(.white)
                        .animation(.default, value: prediction)
                }
                Spacer()
                Button {
                    playSound(soundName: "wand")
                    notificationGenerator.notificationOccurred(.success)
                    var newPrediction = choicesArray.randomElement() ?? "Problem Loading"
                    while(newPrediction == prediction) {
                        print("I would have repeated \(prediction)")
                        newPrediction = choicesArray.randomElement() ?? "Problem Loading"
                    }
                    prediction = newPrediction
                } label: {
                    Text("Hit Me!")
                }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
                .font(.title2)
            }
            .padding()
        }
        // Ensures the app always runs in Light Mode so the background stays white
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
