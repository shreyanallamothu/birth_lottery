import SwiftUI

struct Metadata: Decodable {
    let page: Int
}

struct DataPoint: Decodable {
    let date: String
    let value: Double?
}

struct Response: Decodable {
    let data: [DataPoint]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        _ = try? container.decode(Metadata.self)
        data = try container.decode([DataPoint].self)
    }
}

class Service {
    static let weights: [String: Double] = [
        "India": 18.024,
        "China": 17.9099,
        "United States": 4.2282,
        "Indonesia": 3.4962,
        "Pakistan": 3.0292,
        "Nigeria": 2.8146,
        "Brazil": 2.7262,
        "Bangladesh": 2.1835,
        "Russia": 1.8175,
        "Mexico": 1.6282,
        "Ethiopia": 1.5903,
        "Japan": 1.5651,
        "Philippines": 1.4767,
        "Egypt": 1.3253,
        "DR Congo": 1.2874,
        "Vietnam": 1.2369,
        "Iran": 1.1233,
        "Turkey": 1.0728,
        "Germany": 1.0602,
        "Thailand": 0.9087,
        "United Kingdom": 0.8583,
        "France": 0.8583,
        "Tanzania": 0.8204,
        "South Africa": 0.7573,
        "Kenya": 0.6942,
        "Myanmar": 0.6816,
        "South Korea": 0.6563,
        "Colombia": 0.6563,
        "Uganda": 0.6058,
        "Spain": 0.5932,
        "Sudan": 0.5806,
        "Argentina": 0.5806,
        "Algeria": 0.568,
        "Ukraine": 0.5553,
        "Afghanistan": 0.5301,
        "Iraq": 0.5301,
        "Poland": 0.5175,
        "Canada": 0.4796,
        "Morocco": 0.467,
        "Saudi Arabia": 0.4544,
        "Angola": 0.4544,
        "Uzbekistan": 0.4418,
        "Yemen": 0.4291,
        "Peru": 0.4165,
        "Malaysia": 0.4165,
        "Ghana": 0.4165,
        "Mozambique": 0.4165,
        "Nepal": 0.3786,
        "Venezuela": 0.366,
        "Madagascar": 0.3534,
        "Cameroon": 0.3534,
        "Ivory Coast": 0.3408,
        "Australia": 0.3282,
        "North Korea": 0.3282,
        "Niger": 0.3282,
        "Taiwan": 0.2903,
        "Mali": 0.2903,
        "Syria": 0.2777,
        "Burkina Faso": 0.2777,
        "Sri Lanka": 0.2777,
        "Malawi": 0.2524,
        "Zambia": 0.2524,
        "Romania": 0.2398,
        "Chile": 0.2398,
        "Kazakhstan": 0.2398,
        "Chad": 0.2272,
        "Ecuador": 0.2272,
        "Guatemala": 0.2272,
        "Somalia": 0.2272,
        "Netherlands": 0.2272,
        "Senegal": 0.2146,
        "Cambodia": 0.2146,
        "Zimbabwe": 0.2019,
        "Rwanda": 0.1767,
        "Guinea": 0.1767,
        "Burundi": 0.1767,
        "Benin": 0.1641,
        "Bolivia": 0.1515,
        "Tunisia": 0.1515,
        "Belgium": 0.1515,
        "Haiti": 0.1515,
        "South Sudan": 0.1388,
        "Cuba": 0.1388,
        "Czechia": 0.1388,
        "Dominican Republic": 0.1388,
        "Jordan": 0.1262,
        "Greece": 0.1262,
        "Sweden": 0.1262,
        "Portugal": 0.1262,
        "Azerbaijan": 0.1262,
        "Hungary": 0.1262,
        "Tajikistan": 0.1262,
        "United Arab Emirates": 0.1262,
        "Honduras": 0.1262,
        "Papua New Guinea": 0.1262,
        "Israel": 0.1136,
        "Togo": 0.1136,
        "Austria": 0.1136,
        "Belarus": 0.1136,
        "Switzerland": 0.1136,
        "Sierra Leone": 0.101,
        "Laos": 0.101,
        "Serbia": 0.0884,
        "Libya": 0.0884,
        "Kyrgyzstan": 0.0884,
        "Nicaragua": 0.0884,
        "Bulgaria": 0.0884,
        "El Salvador": 0.0757,
        "Turkmenistan": 0.0757,
        "Denmark": 0.0757,
        "Finland": 0.0757,
        "Congo": 0.0757,
        "Singapore": 0.0757,
        "Slovakia": 0.0757,
        "Norway": 0.0631,
        "Palestine": 0.0631,
        "Costa Rica": 0.0631,
        "New Zealand": 0.0631,
        "Ireland": 0.0631,
        "Oman": 0.0631,
        "Liberia": 0.0631,
        "Central African Republic": 0.0631,
        "Mauritania": 0.0631,
        "Kuwait": 0.0631,
        "Panama": 0.0505,
        "Croatia": 0.0505,
        "Georgia": 0.0505,
        "Eritrea": 0.0379,
        "Moldova": 0.0379,
        "Puerto Rico": 0.0379,
        "Bosnia and Herzegovina": 0.0379,
        "Albania": 0.0379,
        "Armenia": 0.0379,
        "Lithuania": 0.0379,
        "Jamaica": 0.0379,
        "Qatar": 0.0379,
        "Namibia": 0.0379,
        "Gambia": 0.0379,
        "Botswana": 0.0379,
        "Gabon": 0.0252,
        "Lesotho": 0.0252,
        "Slovenia": 0.0252,
        "North Macedonia": 0.0252,
        "Latvia": 0.0252,
        "Kosovo": 0.0252,
        "Guinea-Bissau": 0.0252,
        "Equatorial Guinea": 0.0252,
        "Bahrain": 0.0252,
        "Sao Tome and Principe": 0.0126,
        "Trinidad and Tobago": 0.0126,
        "Estonia": 0.0126,
        "Timor-Leste": 0.0126,
        "Mauritius": 0.0126,
        "Cyprus": 0.0126,
        "Eswatini": 0.0126,
        "Djibouti": 0.0126,
        "Fiji": 0.0126,
        "Comoros": 0.0126,
        "Guyana": 0.0126,
        "Bhutan": 0.0126,
        "Solomon Islands": 0.0126,
        "Montenegro": 0.0126,
        "Luxembourg": 0.0126,
        "Suriname": 0.0126,
        "Cape Verde": 0.0126,
        "Malta": 0.0126,
        "Brunei": 0.0126,
        "Belize": 0.0126,
        "Bahamas": 0.0126,
        "Maldives": 0.0126,
        "Iceland": 0.0126,
        "Vanuatu": 0.0126,
        "Barbados": 0.0126,
        "Samoa": 0.0126,
        "Saint Lucia": 0.0126,
        "Kiribati": 0.0126,
        "Micronesia": 0.0126,
        "Grenada": 0.0126,
        "Tonga": 0.0126,
        "Seychelles": 0.0126,
        "Antigua and Barbuda": 0.0126,
        "Andorra": 0.0126,
        "Dominica": 0.0126,
        "Saint Kitts and Nevis": 0.0126,
        "Marshall Islands": 0.0126,
        "Liechtenstein": 0.0126,
        "Monaco": 0.0126,
        "San Marino": 0.0126,
        "Palau": 0.0126,
        "Tuvalu": 0.0126,
        "Nauru": 0.0126,
        "Vatican City": 0.0126,
    ]

    func fetchPop(code: String, indicator: String) async throws -> Double? {

        let url = URL(string:
            "https://api.worldbank.org/v2/country/\(code)/indicator/\(indicator)?format=json&date=2024&per_page=1"
        )!
        print("got to url")
        
        let (data, _) = try await URLSession.shared.data(from: url)

        let info = try JSONDecoder().decode(Response.self, from: data)
        print("Indicator:", indicator, "Value:", info.data.first?.value as Any)

        return info.data.first?.value
    }
    func fetchLife(code: String, indicator: String) async throws -> Double? {

        let url = URL(string:
            "https://api.worldbank.org/v2/country/\(code)/indicator/\(indicator)?format=json&date=2024&per_page=1"
        )!
    
        print("got to url")

        let (data, _) = try await URLSession.shared.data(from: url)

        print("got to data")
        let info = try JSONDecoder().decode(Response.self, from: data)
        print("got to info")
        print("Indicator:", indicator, "Value:", info.data.first?.value as Any)
        
        return info.data.first?.value
    }
}
