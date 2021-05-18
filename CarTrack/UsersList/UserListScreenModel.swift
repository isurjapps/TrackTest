//
//  UserListScreenModel.swift
//  CarTrack
//
//  Created by Prashant Singh on 12/5/21.
//

import Foundation

struct UsersList: Codable {
    let id: Int
    let name, username, email: String
    let address: Address?
    let phone, website: String
    let company: Company?
}

struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: GeoLoc?
}

struct GeoLoc: Codable {
    let lat, lng: String
}

struct Company: Codable {
    let name, catchPhrase, bs: String
}
