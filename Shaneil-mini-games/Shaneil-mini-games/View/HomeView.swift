//
//  HomeView.swift
//  Shaneil-mini-games
//
//  Created by Bronson van den Broeck on 2023/03/03.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    @State var index = 0
    var body: some View {
        VStack {
            ZStack{
                if let model = homeData.displayPhotoData{
                    if model.isEmpty{
                        Text("Last")
                    } else {
                        ForEach(model.reversed()) { model in
                        CardView(homeViewModel: model, homeData: homeData)
                        }
                    }
                }
            }

            HStack {
                ButtonView()

            }.padding(.horizontal, 75)
                .padding(.vertical, 10)
                .padding(.top, 10)
        }
        .padding()
    }

}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct ButtonView: View {
    var body: some View {
        Image(systemName: "x.circle.fill")
            .resizable()
            .frame(width: 75, height: 75)
            .foregroundColor(.red)
        //            .onTapGesture {
        //                <#code#>
        //            }
        Spacer()
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .frame(width: 75, height: 75)
            .foregroundColor(.green)
    }
}

struct CardView: View {
    var homeViewModel: Model
    var homeData: HomeViewModel

    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false

    var body: some View {

        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(homeData.getIndex(model: homeViewModel))

            ZStack{
                VStack{
                    Image(homeViewModel.image)
                        .resizable()
                        .frame(width: 350, height: 550)
                    cardText.padding(.horizontal, 8)
                        .padding(.bottom)

                } .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    .shadow(color: .black, radius: 10, x: 2, y: 2)
                    .offset(x: 5, y: 8)
            }

        }
        .offset(x: offset)
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .updating($isDragging, body: { value, out, _ in
                    out = true
                })
                .onChanged({ value in
                    let translation = value.translation.width
                    offset = (isDragging ? translation : .zero)
                })
                .onEnded({ value in
                    let width = getRect().width - 50
                })
        )
    }
        var cardText: some View {
            VStack {
                Text(homeViewModel.question)
                    .font(.headline)

            }
        }
    }

extension View {
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}
