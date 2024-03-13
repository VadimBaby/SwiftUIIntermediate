//
//  aboutSounds.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 23.04.2023.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instanse = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption){
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error: \(error)")
        }
    }
}

struct aboutSounds: View {
    var body: some View {
        VStack(spacing: 40){
            Button("Play Sound 1") {
                SoundManager.instanse.playSound(sound: .badum)
            }
            
            Button("Play Sound 2") {
                SoundManager.instanse.playSound(sound: .tada)
            }
        }
    }
}

struct aboutSounds_Previews: PreviewProvider {
    static var previews: some View {
        aboutSounds()
    }
}
