//
//  ImageViewBuilder.swift
//  Shared
//
//  Created by Mladen Mikic on 12.02.2024.
//

import SwiftUI

class ImageViewBuilder {
    
    @ViewBuilder static func buildChevronRightImageView(appVC: AppViewConfiguration) -> some View {
        
        Image(systemName: "chevron.right")
            .resizable()
            .frame(width: appVC.shevronRightSize.width,
                   height: appVC.shevronRightSize.height)
    }
}
