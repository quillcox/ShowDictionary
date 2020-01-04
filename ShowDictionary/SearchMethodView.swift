//
//  SearchMethodView.swift
//  ShowDictionary
//
//  Created by Curtis Wilcox on 12/20/19.
//  Copyright © 2019 wilcoxcurtis. All rights reserved.
//

import SwiftUI

struct SearchMethodView: View {
    @ObservedObject private(set) var show: Show
    @State private var shouldSpin: Bool = true
            
    var body: some View {
        ZStack {
            List((self.show.episodes?.isEmpty ?? true) ? [] : show.getAvailableSearchMethods()) { method in
                NavigationLink(destination: self.getDestination(method)) {
                    VStack(alignment: .leading) {
                        Text(method.toString(seasonType: self.show.typeOfSeasons))
                            .strikethrough([SearchMethod.keyword, SearchMethod.episodeNumber, SearchMethod.singleAirdate, SearchMethod.rangeAirdates, SearchMethod.disc].contains(method), color: Color(UIColor.label))
                        SubText(method.desc(seasonType: self.show.typeOfSeasons))
                    }
                }
            }
            .navigationBarTitle(self.show.name)
            .lineLimit(nil)
            .onAppear {
                EpisodeObserver(self.show.filename).getEpisodes() { (episodes, hasFaves) in
                    self.show.episodes = episodes
                    self.show.hasFavoritedEpisodes = hasFaves
                    self.shouldSpin = false
                }
            }
            ActivityIndicator(shouldAnimate: self.$shouldSpin)
        }
    }
    
    func getDestination(_ method: SearchMethod) -> some View {
        switch method {
        case .character:
            return AnyView(CharacterView(show: self.show))
        case .companion:
            return AnyView(CompanionView(show: self.show))
        case .description:
            return AnyView(DescriptionView(show: self.show))
        case .director:
            return AnyView(DirectorView(show: self.show))
        case .disc:
            return AnyView(DescriptionView(show: self.show))
        case .doctor:
            return AnyView(DoctorView(show: self.show))
        case .episodeNumber:
            return AnyView(DescriptionView(show: self.show))
        case .favorite:
            return AnyView(
                EpisodeChooserView(navTitle: NSLocalizedString("Favorite Episodes", comment: ""), show: self.show, episodes: self.show.episodes.filter { $0.isFavorite })
            )
        case .keyword:
            return AnyView(DescriptionView(show: self.show))
        /*case .name:
            return AnyView(DescriptionView(show: self.show))*/
        case .random:
            return AnyView(EpisodeView(show: self.show))
        case .rangeAirdates:
            return AnyView(DescriptionView(show: self.show))
        case .season:
            return AnyView(SeasonView(show: self.show))
        case .showAll:
            return AnyView(EpisodeChooserView(navTitle: NSLocalizedString("Episodes", comment: "navigation bar title"), show: self.show, episodes: self.show.episodes))
        case .singleAirdate:
            return AnyView(DescriptionView(show: self.show))
        case .writer:
            return AnyView(WriterView(show: self.show))
        }
    }
}

//#if DEBUG
//struct SearchMethodView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchMethodView(show: Show(name: "test"))
//    }
//}
//#endif
//
