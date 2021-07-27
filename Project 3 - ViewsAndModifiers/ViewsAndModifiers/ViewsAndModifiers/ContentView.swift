//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Karthigeyan Vijayakumar on 7/25/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Color.blue
//            .frame(width: 300, height: 200)
//            .watermarked(with: "VK")
        Text("My Title")
            .caption()
            
    }
}

struct Caption: ViewModifier {
    func body(content: Content) -> some View {
        content
          .font(.largeTitle)
          .padding([.leading,.trailing], 5)
          .background(Color(.secondarySystemBackground))
          .foregroundColor(Color.blue)
          .cornerRadius(5.0)
    }
}

extension View {
    func caption() -> some View {
        self.modifier(Caption())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
