//
//  ObjectsListContainerView+buildList.swift
//  Endava
//
//  Created by Mladen Mikic on 10.02.2024.
//

import SwiftUI

extension ObjectsListContainerView {
    
    @ViewBuilder public func buildListView() -> some View {
        
        HStack(spacing: .zero) {
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            ScrollView {
             
                VStack(spacing: .zero) {
                    
                    Spacer().frame(height: appViewConfiguration.appPadding.top)
                    
                    ForEach(viewModel.models, id: \.self) { item in
                        
                        if let rssFeed: RSSSource = item as? RSSSource {
                            buildRSSFeedListItemView(model: rssFeed)
                            
                            Spacer().frame(height: appViewConfiguration.appPadding.top)
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
            
            Spacer().frame(width: appViewConfiguration.appPadding.right)
        }
    }
    
    @ViewBuilder private func buildRSSFeedListItemView(model: RSSSource) -> some View {
     
         Button {
             withAnimation {
                 viewModel.editObjectButtonTapped(with: model)
             }
         } label: {
             
             ZStack {
                 
                 VStack(spacing: .zero) {
                     
                     Spacer()
                                      
                     HStack(spacing: .zero) {
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left * 1.5)
                         
                         Asset.rssFeedIcon.swiftUIImage
                             .resizable()
                             .foregroundColor(theme.primaryFontColor)
                             .frame(width: 16, height: 16)
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left)
                         
                         VStack(spacing: .zero) {
                             
                             Spacer()
                             
                             Text(model.title)
                                 .font(theme.smallFont)
                                 .foregroundColor(theme.fontColor)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 .frame(height: 16)
                             
                             Spacer()
                         }
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.right * 1.5)
                     }
                     .frame(height: appViewConfiguration.regularButtonSize.height / 1.6)
                     
                     Spacer().frame(height: 2)
                     
                     HStack(spacing: .zero) {
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left * 1.5)
                         
                         Image(systemName: "safari.fill")
                             .resizable()
                             .foregroundColor(theme.primaryFontColor)
                             .frame(width: 16, height: 16)
                         
                         Spacer().frame(width: appViewConfiguration.appPadding.left)
                         
                         VStack(spacing: .zero) {
                             
                             Spacer()
                             
                             Text(model.cleanedUrl)
                                 .font(theme.smallFont)
                                 .foregroundColor(theme.fontColor)
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 .frame(height: 16)
                              
                             Spacer()
                         }
                                                  
                         Spacer().frame(width: appViewConfiguration.appPadding.right * 1.5)
                     }
                     .frame(height: appViewConfiguration.regularButtonSize.height / 1.6)
                     
                     Spacer()
                 }
              
                 HStack(spacing: .zero) {
                     
                     Spacer()
                     
                     VStack(spacing: .zero) {
                        
                         Spacer()
                         
                         Image(systemName: "chevron.right")
                             .resizable()
                             .frame(width: 10, height: 18, alignment: .center)
                             .foregroundColor(theme.fontColor)
                         
                         Spacer()
                     }
                     
                     Spacer().frame(width: appViewConfiguration.appPadding.right)
                 }
             }
         }
         .compositingGroup()
         .frame(maxWidth: .infinity, alignment: .leading)
         .frame(height: appViewConfiguration.bigButtonSize.height)
         .overlay(
             RoundedRectangle(cornerRadius: appViewConfiguration.bigButtonSize.width)
                 .stroke(Color.black, lineWidth: 2)
             )
          // The horizontal border is cut by 1-2 points. Hotfix.
         .padding(.horizontal, 2)
    }
}
