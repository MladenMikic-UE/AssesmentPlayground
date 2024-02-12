//
//  IndicatorBuilder.swift
//  AssessmentPlayground
//
//  Created by Mladen Mikic on 03.02.2024.
//

import SwiftUI

struct IndicatorBuilder {
    
    enum IndicatorIntent {
        case web
        case disk
    }
    
    @ViewBuilder static func build(intent: IndicatorIntent,
                                   theme: AppTheme,
                                   viewConfiguration: AppViewConfiguration) -> some View {
        ZStack {
            
            CircularProgressBar(color: theme.primaryFontColor, size: viewConfiguration.bigButtonSize)
            
            buildIndictorImage(intent: intent, theme: theme, viewConfiguration: viewConfiguration)
                .frame(width: viewConfiguration.indicatorSize.width, height: viewConfiguration.indicatorSize.height)
        }
    }
    
    @ViewBuilder static func buildIndictorImage(intent: IndicatorIntent,
                                                theme: AppTheme,
                                                viewConfiguration: AppViewConfiguration) -> some View {
        switch intent {
        case .disk:
            Image(systemName: "externaldrive.fill")
                .resizable()
                .foregroundColor(theme.fontColor)
                .frame(width: viewConfiguration.indicatorSize.width / 1.6)
                .frame(height: viewConfiguration.indicatorSize.width / 2.6)
        case .web:
            Image(systemName: "globe")
                .resizable()
                .foregroundColor(theme.fontColor)
                .frame(maxWidth: viewConfiguration.indicatorSize.width / 2)
                .frame(maxHeight: viewConfiguration.indicatorSize.height / 2)
                .aspectRatio(contentMode: .fit)
        }
    }
}
