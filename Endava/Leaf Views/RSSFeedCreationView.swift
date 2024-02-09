//
//  RSSFeedCreationView.swift
//  Endava
//
//  Created by Mladen Mikic on 09.02.2024.
//

import Foundation
import SwiftUI
import SwiftUICoordinator

import SwiftUI
import SwiftUICoordinator

struct RSSFeedCreationView<Coordinator: Routing>: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    @ObservedObject var viewModel: RSSFeedCreationView.ViewModel<Coordinator>
    
    @FocusState private var isTextFieldFocused: Bool
  
    // MARK: - Init.
    var body: some View {
        Text("RSSFeedCreationView")
    }
}
