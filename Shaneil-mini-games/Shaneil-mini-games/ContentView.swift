//
//  ContentView.swift
//  Shaneil-mini-games
//
//  Created by Bronson van den Broeck on 2023/03/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {

            VStack(spacing: 16.0){

                Image("backgroundPlace")
                    .resizable()
                    .frame(width: 350, height: 550)
                cardText.padding(.horizontal, 8)
                    .padding(.bottom)



            } .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24.0))
                .shadow(color: .black, radius: 10, x: 2, y: 2)



            HStack {
                ExtractedView()

            }.padding(.horizontal, 75)
                .padding(.vertical, 10)
                .padding(.top, 10)
        }
        .padding()
    }
    var cardText: some View {
        VStack {
            Text("Blah")
                .font(.headline)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExtractedView: View {
    var body: some View {
        Image(systemName: "x.circle.fill")
            .resizable()
            .frame(width: 75, height: 75)
            .foregroundColor(.red)
        Spacer()
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .frame(width: 75, height: 75)
            .foregroundColor(.green)
    }
}
