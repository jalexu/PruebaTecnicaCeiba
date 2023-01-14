//
//  UserPublishingCellView.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import SwiftUI

struct UserPublishingCellView: View {
    var publishing: UserPublishig
    
    var body: some View {
            
            VStack(alignment: .leading, spacing: 6) {
                Text(publishing.title)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(Color("green-app"))
                
                Text(publishing.body)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
            
    }
}

struct UserPublishingCellView_Previews: PreviewProvider {
    static let publishing: UserPublishig = Constants.PreviewsMocks.userPusblishing
    static var previews: some View {
        UserPublishingCellView(publishing: publishing)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
