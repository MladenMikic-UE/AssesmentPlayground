//
//  ChevronRightImageView.swift
//  Shared
//
//  Created by Mladen Mikic on 10.02.2024.
//

import SwiftUI


public struct ChevronRightImageView: View {

    private let theme: AppTheme
    
    public  init(theme: AppTheme) {
        self.theme = theme
    }
    
    public var body: some View {
        
        Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 16, alignment: .center)
            .foregroundColor(theme.fontColor)
    }
}

#Preview {
    ChevronRightImageView(theme: .endava)
}
