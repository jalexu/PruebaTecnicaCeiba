//
//  GreenButton.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import SwiftUI

struct GreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color("green-app"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
            .clipShape(Rectangle())
    }
}
