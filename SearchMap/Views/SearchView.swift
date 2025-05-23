//  ContentView.swift
//  SearchMap
//
//  Created by Hậu Nguyễn on 22/5/25.
//

import SwiftUI
import heresdk

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    if viewModel.isLoading {
                        SpinningCircleView()
                    } else {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                    }
                    TextField("Enter keyword", text: $viewModel.query)
                        .foregroundColor(.primary)

                    if !viewModel.query.isEmpty {
                        Button(action: {
                            viewModel.query = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)

                List(viewModel.results) { place in
                    HStack {
                        Image(systemName: "location.circle")
                            .resizable()
                            .frame(width: 25, height: 25)

                        Text(place.name.highlighted(with: viewModel.query))

                        Spacer()

                        if let coordinates = place.coordinates {
                            Button(action: {
                                viewModel.openInGoogleMaps(destination: coordinates)
                            }) {
                                Image(systemName: "map.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                            .buttonStyle(PressableButtonStyle())
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listRowSeparator(.hidden)
                .listStyle(PlainListStyle())
            }
        }
        .preferredColorScheme(.light)
    }
}
