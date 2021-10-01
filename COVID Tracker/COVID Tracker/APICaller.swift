//
//  APICaller.swift
//  COVID Tracker
//
//  Created by MACBOOK PRO on 01/10/2021.
//

import Foundation

// MARK: co loi tai url api json

class APICaller {
    static let shared = APICaller()
    private init() {}
    
    private struct Constants {
        static let allStateUrl = URL(string: "https://static.pipezero.com/covid/data.json")
//        static let covidStateData = "https://static.pipezero.com/covid/data.json" // link covid vn
    }
    
    enum DataScope {
        case national
        case state(State)
    }
    
    public func getCovidData(
        for scope: DataScope,
        completion: @escaping (Result<[DayData],Error>) -> Void
    ) {
        // MARK: !
        let urlString: String
        switch scope {
        case .national:
            urlString = "https://static.pipezero.com/covid/data.json"
        case .state(let state):
            urlString = "https://static.pipezero.com/covid/data.json"
        }
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { locations, _, error in
            guard let locations = locations,error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(CovidDateData.self, from: locations)
                
                result.overview.forEach { model in
                    print(model.date)
                }
                
            }
            catch {
                //complesion(.failure(error))
            }
        }
        task.resume()
        // MARK: !
    }
    
    public func getStateList(
        complesion: @escaping (Result<[State],Error>) -> Void
    ) {
        guard let url = Constants.allStateUrl else { return }
        let task = URLSession.shared.dataTask(with: url) { locations, _, error in
            guard let locations = locations,error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(StateListResponse.self, from: locations) // decode file json
                let states = result.locations
                complesion(.success(states))
            }
            catch {
                complesion(.failure(error))
            }
        }
        task.resume()
    }
}
// MARK: models
//
struct StateListResponse: Codable {
    let locations: [State] // lay info locations trong link json
}

struct State: Codable {
    let name: String
    let death: Int
    let treating: Int
    let cases: Int
    let recovered: Int
    let casesToday: Int
}

struct CovidDateData:Codable {
    let overview: [CovidCases] // show phan overview trong link json
}

struct CovidCases:Codable { // thanh phan trong overview
    let date: Date // !
    let death: Int
    let treating: Int
    let cases: Int
    let recovered: Int
    let avgCases7day: Int
    let avgRecovered7day: Int
    let avgDeath7day: Int
}

struct DayData {
    let date: Date // !
}
