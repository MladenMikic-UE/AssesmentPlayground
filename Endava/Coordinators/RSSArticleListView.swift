//
//  RSSArticleListView.swift
//  Endava
//
//  Created by Mladen Mikic on 12.02.2024.
//

import SwiftUI
import SwiftUICoordinator

struct RSSArticleListView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var appViewConfiguration: AppViewConfiguration
    
    // TODO: Refactor into VM.
    @Binding var articles: [RSSArticle]
    @State private var startAnimations: Bool
    private let showDetailAction: (RSSArticle) -> Void
    private let theme: AppTheme
    
    init(articles: Binding<[RSSArticle]>,
         theme: AppTheme,
         showDetailAction: @escaping (RSSArticle) -> Void) {
        
        self._articles = articles
        self.theme = theme
        self.showDetailAction = showDetailAction
        self.startAnimations = false
    }
    
    var body: some View {
        
        ScrollView {
            
            Spacer(minLength: appViewConfiguration.appPadding.top)
            
            buildScrollViewContent()
            
            Spacer(minLength: appViewConfiguration.appPadding.bottom)
        }
        .clipped()
        .onAppear {
            withAnimation {
                self.startAnimations = true
            }
        }
    }
    
    @ViewBuilder private func buildScrollViewContent() -> some View {
        
        HStack(spacing: .zero) {
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            if startAnimations {
                
                VStack(spacing: appViewConfiguration.appPadding.top) {
                 
                    ForEach(articles, id: \.self) { article in
                       
                        buildRSSArticleListItemView(article: article)
                    }
                }
            }
            
            Spacer().frame(width: appViewConfiguration.appPadding.right)
        }
    }
    
    @ViewBuilder private func buildRSSArticleListItemView(article: RSSArticle) -> some View {
     
         Button {
             withAnimation {
                 showDetailAction(article)
             }
         } label: {
             
             ZStack {
                 
                 VStack(spacing: .zero) {
                     
                     Spacer()
                                      
                     buildRSSArticleButtonTopPart(with: article, source: source(for: article))

                     buildRSSArticleButtonMidPart(with: article)
                     
                     buildRSSArticleButtonBottomPart(with: article)
                     
                     Spacer()
                 }
                 .frame(height: appViewConfiguration.hugeButtonSize.height)
                 
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
                 .frame(height: appViewConfiguration.hugeButtonSize.height)
             }
         }
         .compositingGroup()
         .frame(maxWidth: .infinity, alignment: .leading)
         .frame(height: appViewConfiguration.hugeButtonSize.height + 4)
         .overlay(
             RoundedRectangle(cornerRadius: appViewConfiguration.cornerRadius)
                 .stroke(Color.black, lineWidth: 2)
             )
          // The horizontal border is cut by 1-2 points. Hotfix.
         .padding(.horizontal, 2)
    }
    
    @ViewBuilder private func buildRSSArticleButtonTopPart(with article: RSSArticle, source: RSSSource?) -> some View {
        
        HStack(spacing: .zero) {
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            Asset.rssFeedIcon.swiftUIImage
                .resizable()
                .foregroundColor(theme.primaryFontColor)
                .frame(width: 16, height: 16)
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            HStack(spacing: .zero) {
                
                VStack(spacing: .zero) {
                    
                    Spacer()
                    
                    Text(source?.title ?? article.title)
                        .font(theme.miniFont)
                        .foregroundColor(theme.fontColor)
                        .frame(height: 16)
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            Spacer().frame(width: appViewConfiguration.appPadding.right * 2)
        }
        .frame(height: 18)
    }
    
    @ViewBuilder private func buildRSSArticleButtonMidPart(with article: RSSArticle) -> some View {
                
        HStack(spacing: .zero) {
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            Image(systemName: "doc.richtext.fill")
                .resizable()
                .foregroundColor(theme.primaryFontColor)
                .frame(width: 14, height: 18)
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            HStack(spacing: .zero) {
                
                VStack(spacing: .zero) {
                    
                    Spacer()
                    
                    Text(article.description ?? article.title)
                        .font(theme.miniFont.bold())
                        .foregroundColor(theme.fontColor)
                        .frame(height: 36, alignment: .leading)
                     
                    Spacer()
                }
                
                Spacer()
            }
                                                 
            Spacer().frame(width: appViewConfiguration.appPadding.right * 2)
        }
        .frame(height: 40)
    }
    
    @ViewBuilder private func buildRSSArticleButtonBottomPart(with article: RSSArticle) -> some View {
                
        HStack(spacing: .zero) {
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            Image(systemName: "calendar.circle.fill")
                .resizable()
                .foregroundColor(theme.primaryFontColor)
                .frame(width: 16, height: 16)
            
            Spacer().frame(width: appViewConfiguration.appPadding.left)
            
            HStack(spacing: .zero) {
                
                VStack(spacing: .zero) {
                    
                    Spacer()
                    
                    Text(article.date.getFormattedDate(format: "yyyy-MM-dd HH:mm"))
                        .font(theme.tinyFont)
                        .foregroundColor(theme.fontColor)
                        .frame(height: 16)
                     
                    Spacer()
                }
                
                Spacer()
            }
                                     
            Spacer().frame(width: appViewConfiguration.appPadding.right * 2)
        }
        .frame(height: 18)
    }
    
    // TODO: Refactor into VM.
    func source(for article: RSSArticle) -> RSSSource? {
        
        let sources: [RSSSource] = RSSSourceManager.shared.sources
        let source: RSSSource? = sources.first { source in
            source.articles?.contains(article) ?? false
        }
        return source
    }
}
