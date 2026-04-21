//
//  CountryView.swift
//  birth_lottery
//
//  Created by shreya nallamothu on 4/20/26.
//

import SwiftUI
import Charts

struct CountryStat: Identifiable{
    let id = UUID()
    let label: String
    let displayValue: String
    let numericValue: Double
    let maxValue: Double
    
}

struct CountryView: View {
    let service = Service()

    @State var country: String
    @State var code: String
    @State var pop: String? = nil
    @State var life: String? = nil
    @State var mort: String? = nil
    @State var gini: String? = nil
    @State var gdp: String? = nil
    @State var water: String? = nil
    @State var lifeNum: Double = 0
    @State var mortNum: Double = 0
    @State var giniNum: Double = 0
    @State var gdpNum: Double = 0
    @State var waterNum: Double = 0
    let customColor = UIColor(
        red: 243/255.0,
        green: 238/255.0,
        blue: 229/255.0,
        alpha: 1.0
    )
    
    func color(for stat: CountryStat) -> Color {
        switch stat.label {
        case "Life Expectancy":
            return stat.numericValue > 79.0 ? .green : .red
        case "Child Mortality":
            return stat.numericValue < 3.7 ? .green : .red
        case "Gini Index":
            return stat.numericValue < 41.8 ? .green : .red
        case "Access to Drinking Water":
            return stat.numericValue > 99.0 ? .green : .red
        default:
            return .primary
        }
    }
    
    var stats: [CountryStat] {
        [
            CountryStat(label: "Life Expectancy",
                        displayValue: life ?? "Data not available",
                        numericValue: lifeNum,
                        maxValue: 100),
            CountryStat(label: "Child Mortality",
                        displayValue: mort ?? "Data not available",
                        numericValue: mortNum,
                        maxValue: 20),
                        CountryStat(label: "Gini Index",
                        displayValue: gini ?? "Data not available",
                        numericValue: giniNum,
                        maxValue: 100),
            CountryStat(label: "GDP Per Capita",
                        displayValue: gdp ?? "Data not available",
                        numericValue: gdpNum,
                        maxValue: 1000000),
            
            CountryStat(label: "Access to Drinking Water",
                        displayValue: water ?? "Data not available",
                        numericValue: waterNum,
                        maxValue: 100)
        ]
    }
    var body: some View{
        ScrollView{
            VStack {
                let info = countryInfo()
                let emoji = info.getFlag(country: country)
                Text(emoji).font(.system(size: 70))
                Text(country).font(.custom("PlayfairDisplay-SemiBoldItalic", size: 40))
                Text((pop ?? "Population data not found") + " people").bold().font(.system(size: 30))
                Spacer()
                Text("What would life look like if you were born here?")
                    .font(.system(size: 20))
                    .italic()
                    .foregroundStyle(.gray)
                ForEach(stats, id: \.id){
                    stat in
                    VStack(spacing: 10){
                        Text(stat.label).font(.system(size: 20)).padding(2)
                        Text(stat.displayValue).bold()
                        Chart {
                                    BarMark(
                                        x: .value("Value", stat.numericValue)
                                    )
                                                     
                                    .cornerRadius(6)
                                }
                        .foregroundStyle(color(for: stat))
                                .chartXScale(domain: 0...100)
                                .chartXAxis(.hidden)
                                .chartYAxis(.hidden)
                                .frame(height: 12)
                                .padding()
                    }.frame(width: 300, height: 70).padding(20)
                        .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.brown, lineWidth: 2)
                            )
                        .padding(4)
                }
                Link("Teach Me About Effective Altruism", destination: URL(string: "https://www.givingwhatwecan.org/")!).padding(20).background(.green).foregroundStyle(.white).cornerRadius(10).bold()
                HStack {
                    Text("Data collected in 2024, via World Bank").italic()
                }
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity)
            }
            .task(id: code){
                guard !code.isEmpty else {
                       print("❌ Skipping fetch — empty code")
                       return
                   }
                print("COUNTRY:", country)
                print("CODE:", code)
                if let popVal = try? await service.fetchPop(code: code, indicator: "SP.POP.TOTL") {
                    pop = popVal.formatted(.number)
                }
                
                if let lifeVal = try? await service.fetchLife(code: code, indicator: "SP.DYN.LE00.IN") {
                    lifeNum = lifeVal
                    life = String(format: "%.2f", lifeVal) + " years"
                }
                
                if let mortVal = try? await service.fetchLife(code: code, indicator: "SH.DYN.MORT") {
                    let calculatedMort = (mortVal / 10)
                    mortNum = calculatedMort
                    mort = String(format: "%.2f", calculatedMort) + "%"
                }
                
                if let giniVal = try? await service.fetchLife(code: code, indicator: "SI.POV.GINI") {
                    giniNum = giniVal
                    gini = "\(giniVal)"
                }
                
                if let gdpVal = try? await service.fetchLife(code: code, indicator: "NY.GDP.PCAP.CD") {
                    gdpNum = gdpVal
                    gdp = String(format: "$%.2f", gdpVal)
                }
                
                if let waterVal = try? await service.fetchLife(code: code, indicator: "SH.H2O.BASW.ZS") {
                    waterNum = waterVal
                    water = String(format: "%.2f", waterVal) + "%"
                }
            }

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(customColor))
    }
}

#Preview {
    CountryView(country: "India", code: "IND")
    
    
}
