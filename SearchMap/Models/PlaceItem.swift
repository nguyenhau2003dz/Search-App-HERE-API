//
//  PlaceItem.swift
//  SearchMap
//
//  Created by Hậu Nguyễn on 23/5/25.
//
import Foundation
import heresdk

struct PlaceItem: Identifiable {
    let id = UUID()
    let name: String
    let coordinates: GeoCoordinates?
}

