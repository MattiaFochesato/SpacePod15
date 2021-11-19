//
//  ScaleButtonStyle.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 19/11/21.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
