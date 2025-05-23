//
//  SearchViewModel.swift
//  SearchMap
//
//  Created by Hậu Nguyễn on 23/5/25.
//

import SwiftUI
import Combine
import heresdk

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [PlaceItem] = []
    @Published var isLoading: Bool = false
    
    private let myLocation = GeoCoordinates(latitude: 21.028511, longitude: 105.804817)
    private var cancellables = Set<AnyCancellable>()

    init() {
        $query
            .handleEvents(receiveOutput: { [weak self] text in
                if !text.isEmpty {
                    self?.isLoading = true
                }
            })
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] in self?.fetchSuggestions(query: $0) }
            .store(in: &cancellables)
    }

    private func fetchSuggestions(query: String) {
        guard let searchEngine = try? SearchEngine() else { return }
        guard !query.isEmpty else {
            results = []
            isLoading = false
            return
        }
        isLoading = true
        let area = TextQuery.Area(areaCenter: myLocation)
        let textQuery = TextQuery(query, area: area)
        let options = SearchOptions(languageCode: LanguageCode.viVn, maxItems: 10)

        _ = searchEngine.suggestByText(textQuery, options: options) { [weak self] error, suggestions in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let suggestions = suggestions {
                    self?.results = suggestions.map {
                        PlaceItem(name: $0.title, coordinates: $0.place?.geoCoordinates)
                    }
                } else {
                    self?.results = []
                }
            }
        }
    }

    func openInGoogleMaps(destination: GeoCoordinates) {
        let lat = destination.latitude
        let lon = destination.longitude
        if let url = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(lat),\(lon)&travelmode=driving") {
            UIApplication.shared.open(url)
        }
    }
}
