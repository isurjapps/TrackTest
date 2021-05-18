//
//  CountryListScreenViewModel.swift
//  CarTrack
//
//  Created by Prashant Singh on 11/5/21.
//

import Foundation

final class CountryListScreenViewModel {
    
    var countryListWithFlag = [String]()
    
    func loadCountries() {
        for code in NSLocale.isoCountryCodes as [String] {
                    let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                    let name = NSLocale(localeIdentifier: "en").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                    countryListWithFlag.append(name + "  " + countryFlag(country: code))
            }
        
        func countryFlag(country: String) -> String {
                let base: UInt32 = 127397
                var s = ""
                for v in country.unicodeScalars {
                    s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
                }
                return String(s)
        }
    }
}

