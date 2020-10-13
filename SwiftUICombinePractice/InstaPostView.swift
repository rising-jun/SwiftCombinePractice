//
//  ContentView.swift
//  SwiftUICombine
//
//  Created by 김동준 on 2020/09/22.
//
import SwiftUI

struct InstaPostView: View {
    @ObservedObject var viewModel = InstaPostViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .none
    }
    
    
    var body: some View {
        NavigationView{
                ZStack(){
                    ScrollView(.vertical){
                            ForEach(viewModel.postList, id: \.self) { (item) in
                                CardViewCell(viewModel: self.viewModel,tourInfo: item){
                                    print("hi")
                                }.onAppear {
                                    viewModel.fetchImage(for: item)
                                }

                        }
                        .padding(.bottom, 40)
                    }
                   
                
                .border(Color.gray,width: 0.5).edgesIgnoringSafeArea(.bottom)
                
                }
                .navigationBarTitle(Text("hello"),displayMode: .automatic)
        }
        .onAppear(perform: {
            viewModel.setPostList()
        })
    }
}

struct CardViewCell: View {
    @ObservedObject var viewModel: InstaPostViewModel
    @State var tourInfo: TourInfo
    @State var comment: String = ""
    @State var isToggle: Bool = false
    @State var action: () -> Void
    
    var body: some View{
        VStack(alignment: .leading){
            
            HStack(){
                Image("myImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30, alignment: .leading)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.red, lineWidth: 1))
                Text(tourInfo.galTitle ?? "none data")
                    .font(.system(size: 15))
            }.padding(.leading, 10)
            .frame(height: 50)
            
            viewModel.tourImage[tourInfo].map { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.top,-10)
            }
                
            
            HStack(){
                ZStack{
                    Button(action:{
                        isToggle = true
                        viewModel.giveHeart()
                    }){
                        Image("heartIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20, alignment: .center)
                        
                    }.opacity(isToggle ? 0 : 1)
                    
                    Button(action:{
                        isToggle = false
                        viewModel.canceledHeart()
                        
                    }){
                        Image("giveHeartIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20, alignment: .center)
                        
                    }.opacity(isToggle ? 1 : 0)
                }
                
                Image("comentIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20, alignment: .center)
                Image("dmIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20, alignment: .center)
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5))
            
            HStack{
                Text("Like")
                    .font(.system(size: 13))
                    .bold()
                   
                
                Text("10k")
                    .font(.system(size: 13))
                    .bold()
                    .padding(.leading,-3)
                    
            } .padding(EdgeInsets(top: 0, leading: 10, bottom: 2, trailing: 0))
            
            HStack{
                Text(tourInfo.galPhotographer!)
                    .font(.system(size: 13))
                    .bold()
                   
                
                Text(tourInfo.galPhotographyLocation!)
                    .font(.system(size: 13))
                    .padding(.leading,-2)
                    
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
            
            HStack{
                
                TextField("enter the comment", text: $comment)
                Button(action: self.action, label: {
                    Text("게시")
                })
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .overlay(Rectangle().frame(width: nil, height: 0.5, alignment: .top).foregroundColor(Color.gray), alignment: .top)
        }.background(Color.white)
        .border(Color.gray, width: 0.5)
        .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
        
    }

}
