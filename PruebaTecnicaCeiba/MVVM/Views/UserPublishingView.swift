//
//  UserPublishingView.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import SwiftUI

struct UserPublishingView<ViewModelType>: View where ViewModelType: UserPublishingViewModelType & ErrorHandlerType & ConnectionRetryable {
    
    @ObservedObject var viewModel: ViewModelType
    
    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(viewModel.state.listUserPublishig, id: \.self) { publishing in
                    UserPublishingCellView(publishing: publishing)
                }
            }
            .navigationBarTitle("Publicaciones", displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear() {
                viewModel.getUserPublishing()
            }
            .alert(isPresented: $viewModel.state.alert) {
                Alert(
                    title: Text(Constants.MessagesError.title),
                    message: Text(Constants.MessagesError.message),
                    dismissButton: .cancel(Text(Constants.MessagesError.okButton)))
            }
            .sheet(isPresented: $viewModel.state.showConnectionError) {
                LostInternetErrorView(conectionRetryable: viewModel.self)
            }
        }
    }
}
