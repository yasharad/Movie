//
//  PersistManager.swift
//  Movie
//
//  Created by Yashar on 6/19/19.
//  Copyright © 2019 Yashar Azabdaftari. All rights reserved.
//

import Foundation
//private enum PersistKey {
//    static let favoriteComics = "FavoriteComic"
//}
//class PersistManager {
//    static let shared = PersistManager()
//    private init() {}
//
//}
//extension PersistManager {
//
//    @discardableResult
//    func saveFavoriteComic(comicModel: ComicModel)-> Bool {
//        var isSaved = true
//        var comicModelsArray = loadFavoriteComics()
//        if comicModelsArray == nil {
//            comicModelsArray = [ComicModel]()
//
//        }
//
//        if let index = comicModelsArray?.firstIndex(where: {$0.id == comicModel.id}) {
//            comicModelsArray?.remove(at: index)
//            isSaved = false
//        }else {
//            comicModelsArray?.append(comicModel)
//        }
//        if let encoded = try? JSONEncoder().encode(comicModelsArray) {
//            UserDefaults.standard.set(encoded, forKey: PersistKey.favoriteComics)
//        }
//        return isSaved
//    }
//     func loadFavoriteComics()-> [ComicModel]? {
//        if let data = UserDefaults.standard.data(forKey: PersistKey.favoriteComics),
//            let comicModels = try? JSONDecoder().decode([ComicModel].self, from: data) {
//            return comicModels
//        }
//        return nil
//    }
//
//
//}
//extension UserDefaults {
//    static var testDefaults: UserDefaults = UserDefaults(suiteName: "testDefaults")!
//    static func dropTestDefaults() {
//        UserDefaults().removePersistentDomain(forName: "testDefaults")
//    }
//}
