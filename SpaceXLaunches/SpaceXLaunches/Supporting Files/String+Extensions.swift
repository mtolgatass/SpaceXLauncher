//
//  String+Extensions.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 31.01.2022.
//

import Foundation

extension String {
    static func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"

        guard let date: Date = dateFormatterGet.date(from: string) else { return "" }
        return dateFormatterPrint.string(from: date);
    }
}
