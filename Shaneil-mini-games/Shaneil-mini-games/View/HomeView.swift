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
                        Text("Your final score is \(homeData.score)")
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
                .disabled(homeData.displayPhotoData?.isEmpty ?? false)
                .opacity((homeData.displayPhotoData?.isEmpty ?? false) ? 0.6 : 1)
        }
        .padding()
    }
    func doSwipe(rightSwipe: Bool = false){

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
//                    .onTapGesture {
//                        
//                    }
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
    @State var score: Int = 0

    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    @State var endSwipe: Bool = false
    var body: some View {

        GeometryReader { proxy in
            let size = proxy.size
            let index = CGFloat(homeData.getIndex(model: homeViewModel))

            ZStack{
                VStack{
                    Image(homeViewModel.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
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
        .rotationEffect(.init(degrees: getRotation(angle: 12)))
        .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
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
                    let translation = value.translation.width

                    let checkingStatus = (translation > 0 ? translation : -translation)

                    withAnimation{
                        if checkingStatus > (width / 2){
                            offset = (translation > 0 ? width : -width) * 2
                        endSwipeActions()

                            if translation > 0{
                                rightSwipe()
                            }
                            else{
                                leftSwipe()
                            }

                        } else {
                            offset = .zero

                        }
                    }
                })
        )
    }
    func getRotation(angle: Double) -> Double{
        let rotation = (offset / (getRect().width - 50)) * angle
        return rotation
    }

    func endSwipeActions(){
        withAnimation(.none){endSwipe = true}
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let _ = homeData.displayPhotoData?.first{
             let _ = withAnimation{
                    homeData.displayPhotoData?.removeFirst()
                }
            }
        }
    }

    func leftSwipe(){
        if homeViewModel.answer {

        }
        else{
            homeData.score += 1
        }
        print("left swipe")
    }

    func rightSwipe(){
        if homeViewModel.answer {
            homeData.score += 1
        }
        else{

        }
        print("right swipe")
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
