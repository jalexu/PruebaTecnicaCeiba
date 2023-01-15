//
//  UsersView.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import SwiftUI
import Resolver
import RappleProgressHUD

struct UsersView<ViewModelType>: View where ViewModelType: UserViewModelType & ErrorHandlerType & ConnectionRetryable{
    
    @State var searchText = ""
    @State var searchUserEmpty = false
    @State var isSearching = false
    
    @ObservedObject var viewModel: ViewModelType
    
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    var listView: some View {
        List {
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
                    NavigationLink(
                        destination: UserPublishingView(viewModel: viewModel.getUserPublishingViewModel(user: user)),
                        label: {
                            EmptyView()
                        })
                    .navigationBarTitle(Text("List"))
                    .opacity(0)
                }
            }
            .padding([.top, .bottom], 5.0)
        }
    }
    
    @ViewBuilder
    var emptyView: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(Strings.userDoesnotExistMessage)
                .foregroundColor(Color("light-gray"))
                .font(.system(size: 28, weight: .semibold))
            Spacer()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(searchText.isEmpty ? Color("green-app") : Color(.gray))
                    
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text(Constants.TextDescription.searchUser)
                                .foregroundColor(Color("green-app"))
                                .italic()
                                .font(.caption)
                        }
                        
                        TextField("", text: $searchText ).foregroundColor(.black)
                    }
                    .alert(isPresented: $searchUserEmpty) {
                        Alert(title: Text(Constants.MessagesError.title),
                              message: Text(Constants.MessagesError.listEmpty),
                              dismissButton: .default(Text(Constants.MessagesError.okButton)))
                    }
                    .sheet(isPresented: $viewModel.state.showConnectionError) {
                        LostInternetErrorView(conectionRetryable: viewModel.self)
                    }
                }
                .padding([.top, .leading], 10.0)
                
                Divider()
                    .frame(height: 1)
                    .background(Color("green-app"))
                    .padding([.leading, .trailing], 15)
                
                if viewModel.state.users.filter({ searchText.isEmpty ? true : $0.name.contains(searchText)}).isEmpty {
                    emptyView
                } else {
                    listView
                        .padding(.top, 2.0)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                viewModel.getUserService()
            }
        }
    }
}
