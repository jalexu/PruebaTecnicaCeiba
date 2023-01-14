//
//  UsersView.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import SwiftUI
import Resolver
import RappleProgressHUD

struct UsersView<ViewModelType>: View where ViewModelType: UserViewModelType {
    
    @State var searchText = ""
    @State var searchUserEmpty = false
    
    @ObservedObject var viewModel: ViewModelType
    
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(searchText.isEmpty ? Color("green-app") : Color(.gray))
                    })
                    .alert(isPresented: $searchUserEmpty) {
                        Alert(title: Text(Constants.MessagesError.title),
                              message: Text(Constants.MessagesError.listEmpty),
                              dismissButton: .default(Text(Constants.MessagesError.okButton)))
                    }
                    
                    ZStack(alignment: .leading) {
                        if searchText .isEmpty {
                            Text(Constants.TextDescription.searchUser)
                                .foregroundColor(Color("green-app"))
                                .italic()
                                .font(.caption)
                        }
                        
                        TextField("", text: $searchText ).foregroundColor(.black)
                    }
                    
                }//:Button search
                .padding([.top, .leading], 10.0)
                
                Divider()
                    .frame(height: 1)
                    .background(Color("green-app"))
                    .padding([.leading, .trailing], 15)
                List{
                    ForEach(viewModel.state.users.filter({ searchText.isEmpty ? true : $0.name.contains(searchText)}), id: \.self) { user in
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.white))
                                .frame(maxWidth: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(Color("light-gray"), lineWidth: 1.5)
                                        .shadow(color: .gray, radius: 0))
                            
                            UserCellView(user: user)
                                .padding([.top, .leading, .trailing])
                        }
                        
                    }
                    .padding([.top, .bottom], 5.0)
                }//: LIST
                .onAppear(){
                    viewModel.getUserService()
                }
                .padding(.top, 2.0)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        
    }
}
