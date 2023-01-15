//
//  LostInternetErrorView.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import SwiftUI

struct LostInternetErrorView: View {
    weak var conectionRetryable: ConnectionRetryable?
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image(Strings.imageLostConnection)
                .resizable()
                .scaledToFit()
            labelView
            buttonTryAgain
        }
        .padding([.top], 20.0)
        .padding([.trailing, .leading], 40.0)
    }
    
    @ViewBuilder
    var labelView: some View {
        Text(Strings.retryConectionMessage)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    var buttonTryAgain: some View {
        Button(action: {
            conectionRetryable?.tryAgain()
        }, label: {
            Text(Strings.retryConection)
                .font(.headline)
                .fontWeight(.bold)
        })
        .buttonStyle(GreenButton())
    }
}

struct LostInternetErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LostInternetErrorView()
    }
}
