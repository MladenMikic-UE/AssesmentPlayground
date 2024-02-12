//
//  MainCoordinatorView+build.swift
//  Endava
//
//  Created by Mladen Mikic on 11.02.2024.
//

import SwiftUI

extension MainCoordinatorView {
    
    @ViewBuilder public func buildFilledContentView() -> some View {
        
        if self.viewState.startAnimations {
            
            MainCoordinatorTabView<MainCoordinator>(theme: theme, 
                                                    viewModel: .init(storageInteractor: viewModel.storageInteractor,
                                                                     coordinator: viewModel.coordinator as? MainCoordinator, 
                                                                     timeline: RSSTimeLine.init()))
                .transition(.popUpWithOpacityTransitionSequence)
        }
    }
}
