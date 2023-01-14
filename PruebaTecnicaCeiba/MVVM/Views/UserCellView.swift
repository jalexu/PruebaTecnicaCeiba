//
//  UserCellView.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import SwiftUI

struct UserCellView: View {
    //MARK: -PROPERTIES
    @State var user: UserModel
    @State var showPublishingView = false
    
    //MARK: -BODY
    @ViewBuilder
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: .leading, spacing: 5){
                Text(user.name)
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("green-app"))
                
                HStack(alignment: .center, spacing: 3){
                    
                    Image(systemName: "phone.fill")
                        .foregroundColor(Color("green-app"))
                    
                    Text(user.phone)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                
                HStack(alignment: .center, spacing: 3){
                    
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color("green-app"))
                    
                    Text(user.email)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                
            }
            
            HStack(alignment: .center, spacing: 2){
                EmptyView()
                Spacer()
                Button(action: {
                    showPublishingView = true
                }, label: {
                    Text("VER PUBLICACIONES")
                        .font(.footnote)
                        .foregroundColor(Color("green-app"))
                        .frame(width: 175, alignment: .center)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color("green-app"), lineWidth: 1.5)
                                .shadow(color: .green, radius: 5))
                })
            }
            
//            NavigationLink(
//                destination: UserPublishingView(
//                    viewModel: UserPublishingViewModel(input: UserPublishingViewModel.InputDependences(user: user))),
//                isActive: $showPublishingView,
//                label: {
//                    EmptyView()
//                })
        }
        
    }
}

struct UserCellView_Previews: PreviewProvider {
    static let user: UserModel = Constants.PreviewsMocks.user
    
    static var previews: some View {
        UserCellView(user: user)
            .previewLayout(.sizeThatFits)
            .padding([.top, .leading, .trailing])
    }
}
