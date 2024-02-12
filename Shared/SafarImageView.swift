//
//  SafarImageView.swift
//  Shared
//
//  Created by Mladen Mikic on 10.02.2024.
//

import SwiftUI

public struct SafarImageView: View {

    private let theme: AppTheme
    
    public  init(theme: AppTheme) {
        self.theme = theme
    }
    
    public var body: some View {
        
        Image(systemName: "safari.fill")
            .resizable()
            .foregroundColor(theme.primaryFontColor)
            .frame(width: 16, height: 16)
    }
}

#Preview {
    SafarImageView(theme: .endava)
}
