//
//  MainCoordinator+Ext.swift
//  AssesmentPlayground
//
//  Created by Mladen Mikic on 05.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

// MARK: - RouterViewFactory

extension MainCoordinator: RouterViewFactory {
    
    @ViewBuilder public func view(for route: MainRoute) -> some View {
        
        switch route {
        case .main:
            
            let viewModel: MainCoordinatorView<MainCoordinator>.ViewModel = .init(storageInteractor: storageInteractor, coordinator: self)
            
            MainCoordinatorView<MainCoordinator>(theme: theme,
                                                 viewModel: viewModel)
            .environmentObject(appViewConfiguration)
        case .addNewObject:
            
            let viewModel: AddNewObjectView<MainCoordinator>.ViewModel = .init(storageInteractor: storageInteractor, coordinator: self)
    
            AddNewObjectView<MainCoordinator>(theme: theme, viewModel: viewModel)
                .environmentObject(appViewConfiguration)
        case .edit(let object):
            
            let viewModel: AddNewObjectView<MainCoordinator>.ViewModel = .init(storageInteractor: storageInteractor,
                                                                               oldModel: object,
                                                                               coordinator: self)
    
            AddNewObjectView<MainCoordinator>(theme: theme, viewModel: viewModel)
                .environmentObject(appViewConfiguration)
        case .webpage(let url):
            
            WebViewRepresentable(url: url)
        case .detail(_):
            
            EmptyView()
        }
    }
}
