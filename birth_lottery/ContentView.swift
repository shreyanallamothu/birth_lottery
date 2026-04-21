import SwiftUI
import UIKit

struct ContentView: View {
    @State private var navigate = false
    @State private var country = ""
    @State private var code = ""
    @State private var myCountry = "United States"
    let countries = [
        "Afghanistan","Albania","Algeria","Andorra","Angola","Antigua and Barbuda",
        "Argentina","Armenia","Australia","Austria","Azerbaijan",
        "Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize",
        "Benin","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Brazil","Brunei",
        "Bulgaria","Burkina Faso","Burundi",
        "Cabo Verde","Cambodia","Cameroon","Canada","Central African Republic","Chad","Chile","China","Colombia","Comoros",
        "Congo (Congo-Brazzaville)","Costa Rica","Croatia","Cuba","Cyprus","Czechia",
        "Denmark","Djibouti","Dominica","Dominican Republic",
        "Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Eswatini","Ethiopia",
        "Fiji","Finland","France",
        "Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana",
        "Haiti","Honduras","Hungary",
        "Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy",
        "Jamaica","Japan","Jordan",
        "Kazakhstan","Kenya","Kiribati","Kuwait","Kyrgyzstan",
        "Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg",
        "Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Myanmar",
        "Namibia","Nauru","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","North Korea","North Macedonia","Norway",
        "Oman",
        "Pakistan","Palau","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal",
        "Qatar",
        "Romania","Russia","Rwanda",
        "Saint Kitts and Nevis","Saint Lucia","Saint Vincent and the Grenadines","Samoa","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Korea","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Sweden","Switzerland","Syria",
        "Taiwan","Tajikistan","Tanzania","Thailand","Timor-Leste","Togo","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Tuvalu",
        "Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan",
        "Vanuatu","Vatican City","Venezuela","Vietnam",
        "Yemen",
        "Zambia","Zimbabwe"
        ]

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Text("If you were born again, how would your life be different?")
                    .font(.custom("PlayfairDisplay-Regular", size: 40))
                    .foregroundColor(.brown)
                    .padding(7)

                Text("How much of your life comes down to geographic luck? If you were one of the 251 people born this minute, where would you land? What opportunities would you get?")
                    .italic()
                    .foregroundStyle(.gray)
                    .padding(7)
                
                Spacer()
                Text("I am from...").foregroundStyle(.gray)
                Picker("Select Country", selection: $myCountry) {
                    ForEach(countries, id: \.self) { country in
                        Text(country)
                            .tag(country)
                    }
                }
                .pickerStyle(.menu)

                Button("Draw Your Country") {
                    let info = countryInfo()
                    let newCountry = info.getCountry()
                    country = newCountry
                    code = info.getCode(country: newCountry)
                    navigate = true
                }
                .padding(25)
                .background(.red)
                .foregroundStyle(.white)
                .bold()
                .cornerRadius(10)
                .padding(10)
                
                NavigationLink(
                    destination: CountryView(country: country, code: code),
                    isActive: $navigate
                ) {
                    EmptyView()
                }

                Spacer()

                HStack {
                    Text("With data from")
                    Image("World-Bank")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .foregroundStyle(.gray)
            }
            .padding(25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
