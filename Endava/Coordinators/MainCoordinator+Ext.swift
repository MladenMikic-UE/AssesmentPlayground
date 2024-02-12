//
//  MainCoordinator+Ext.swift
//  Endava
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
            
            let viewModel: RSSFeedSettingsView<MainCoordinator>.ViewModel = .init(coordinator: self, model: object as? RSSSource ?? RSSSource(title: "", url: ""), storageInteractor: storageInteractor)
            
            RSSFeedSettingsView(viewModel: viewModel,
                                theme: theme)
                .environmentObject(appViewConfiguration)
        case .webpage(let url):
            
            WebViewRepresentable(url: url)
        case .detail(let object):
            
            let viewModel: RSSArticleDetailView<MainCoordinator>.ViewModel = .init(model: (object as? RSSArticle) ?? RSSArticle(title: "", date: .now, link: ""),
                                                                                   storageInteractor: storageInteractor,
                                                                                   coordinator: self)
            RSSArticleDetailView(viewModel: viewModel, theme: theme)
                .environmentObject(appViewConfiguration)
        }
    }
}
