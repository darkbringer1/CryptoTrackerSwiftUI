//
//  GlobalCryptoDataResponseModel.swift
//  CryptoTracker
//
//  Created by Doğukaan Kılıçarslan on 29.11.2022.
//

import Foundation

// MARK: - GlobalCryptoData
struct GlobalCryptoData: Codable {
    var data: MarketData?
}

// MARK: - MarketData
struct MarketData: Codable {
    var activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int?
    var markets: Int?
    var totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    var marketCapChangePercentage24HUsd: Double?
    var updatedAt: Int?
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    mutating func getDominance(for coin: String) -> String {
        if let item = marketCapPercentage.first(where: { $0.key == coin }) {
            return item.value.asPercentString()
        }
        return ""
    }
    
    mutating func getMarketCapPercentage(for coin: String) -> Double {
        if let item = marketCapPercentage.first(where: { $0.key == coin }) {
            return item.value
        }
        return 0
    }
        
    mutating func getVolume(for coin: String) -> String {
        if let item = totalVolume.first(where: { $0.key == coin }) {
            return "\(item.value.formattedWithAbbreviations())"
        }
        return ""
    }
    
    mutating func getMarketCap(for coin: String) -> String {
        if let item = totalMarketCap.first(where: { $0.key == coin }) {
            return "\(item.value.formattedWithAbbreviations())"
        }
        return ""
    }
}


// JSON DATA
/*
 {
 "data": {
 "active_cryptocurrencies": 12966,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 612,
 "total_market_cap": {
 "btc": 52013105.7118576,
 "eth": 700701458.6528809,
 "ltc": 11542408850.534924,
 "bch": 8178731620.669195,
 "bnb": 3079300449.171282,
 "eos": 853738185336.3785,
 "xrp": 2305299631933.019,
 "xlm": 10451021754262.281,
 "link": 129801034367.3001,
 "dot": 168654880393.12146,
 "yfi": 126741190.72878173,
 "usd": 894801756619.956,
 "aed": 3286696332240.76,
 "ars": 152052154761469.3,
 "aud": 1316465452004.2756,
 "bdt": 92542256172884.27,
 "bhd": 336828435640.93677,
 "bmd": 894801756619.956,
 "brl": 4686971601175.329,
 "cad": 1228339111400.0466,
 "chf": 836730017417.0762,
 "clp": 766215527381351.9,
 "cny": 6225762182034.663,
 "czk": 20618111556212.67,
 "dkk": 6319090005250.14,
 "eur": 848837579985.9048,
 "gbp": 730003432697.9913,
 "hkd": 6966971217130.789,
 "huf": 355612114115903.06,
 "idr": 13961591808541186,
 "ils": 3066328134827.427,
 "inr": 73768485837769.08,
 "jpy": 122207539002737.11,
 "krw": 1167063087106709,
 "kwd": 274508177697.6268,
 "lkr": 329069160418803.2,
 "mmk": 1880394822230245.5,
 "mxn": 17696494340672.86,
 "myr": 3940259535275.9775,
 "ngn": 397118308761119.75,
 "nok": 8952849495685.305,
 "nzd": 1395293907555.4675,
 "php": 49549646378028.31,
 "pkr": 201202106616841.62,
 "pln": 3984149561438.188,
 "rub": 55938533604699.98,
 "sar": 3364546769471.966,
 "sek": 9261332401280.041,
 "sgd": 1213351181976.658,
 "thb": 30982293386139.13,
 "try": 16691453007637.334,
 "twd": 27478198703515.273,
 "uah": 32902387629150.426,
 "vef": 89596499890.35617,
 "vnd": 21296281807554956,
 "zar": 15528738657067.797,
 "xdr": 675608433913.0602,
 "xag": 38109114673.47781,
 "xau": 497849801.348211,
 "bits": 52013105711857.6,
 "sats": 5201310571185760
 },
 "total_volume": {
 "btc": 1588508.3647726346,
 "eth": 21399801.32016492,
 "ltc": 352511405.68828744,
 "bch": 249782884.81054184,
 "bnb": 94043500.27192438,
 "eos": 26073625678.988758,
 "xrp": 70405096917.68013,
 "xlm": 319179853805.2247,
 "link": 3964193755.1441116,
 "dot": 5150811215.70338,
 "yfi": 3870744.4763871487,
 "usd": 27327729343.41442,
 "aed": 100377482651.29549,
 "ars": 4643755000102.472,
 "aud": 40205566536.01705,
 "bdt": 2826290528389.763,
 "bhd": 10286922501.282803,
 "bmd": 27327729343.41442,
 "brl": 143142646300.80475,
 "cad": 37514140456.17221,
 "chf": 25554187036.75613,
 "clp": 23400636393578.74,
 "cny": 190138142452.67438,
 "czk": 629688272303.8889,
 "dkk": 192988424623.19296,
 "eur": 25923958542.50199,
 "gbp": 22294699447.049835,
 "hkd": 212775067054.29126,
 "huf": 10860586195659.764,
 "idr": 426394560945295.6,
 "ils": 93647318779.51686,
 "inr": 2252929433959.8237,
 "jpy": 3732284301951.8047,
 "krw": 35642737550735.1,
 "kwd": 8383628135.702022,
 "lkr": 10049950041625.924,
 "mmk": 57428274341767.19,
 "mxn": 540460503224.7068,
 "myr": 120337656163.72545,
 "ngn": 12128207816815.467,
 "nok": 273424863172.59857,
 "nzd": 42613030180.254486,
 "php": 1513272985063.8445,
 "pkr": 6144821098384.547,
 "pln": 121678081288.01997,
 "rub": 1708393054559.0085,
 "sar": 102755077087.36058,
 "sek": 282846097863.74084,
 "sgd": 37056400989.66988,
 "thb": 946215987877.4943,
 "try": 509765997626.1839,
 "twd": 839199042088.1113,
 "uah": 1004856703989.9314,
 "vef": 2736325539.1560855,
 "vnd": 650399958373263.2,
 "zar": 474256072840.0578,
 "xdr": 20633446780.26355,
 "xag": 1163872962.4848824,
 "xau": 15204602.052088913,
 "bits": 1588508364772.6345,
 "sats": 158850836477263.47
 },
 "market_cap_percentage": {
 "btc": 36.97284836489903,
 "eth": 17.191204456261598,
 "usdt": 7.366506883169633,
 "bnb": 5.303903153600917,
 "usdc": 4.794197398306081,
 "busd": 2.4769276407494623,
 "xrp": 2.1864229039062195,
 "doge": 1.4841846652175963,
 "ada": 1.2297057792054906,
 "matic": 0.9112683559810325
 },
 "market_cap_change_percentage_24h_usd": 0.2765647866721769,
 "updated_at": 1670772599
 }
 }
 */
