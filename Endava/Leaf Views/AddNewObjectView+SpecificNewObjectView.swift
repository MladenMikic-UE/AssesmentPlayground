//
//  AddNewObjectView+SpecificNewObjectView.swift
//  Endava
//
//  Created by Mladen Mikic on 09.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

public extension AddNewObjectView {
    
    @ViewBuilder func buildTargetSpecificCreateNewObjectView() -> some View {
                
        RSSFeedCreationView<MainCoordinator>(viewModel: .init(storageInteractor: viewModel.storageInteractor,
                                                              coordinator: coordinator as? MainCoordinator),
                                             theme: theme)
    }
}
