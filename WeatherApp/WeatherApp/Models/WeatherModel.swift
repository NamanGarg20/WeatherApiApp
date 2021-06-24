//
//  weatherModel.swift
//  WeatherApp
//
//  Created by NAMAN GARG on 6/16/21.
//

import Foundation

// MARK: - Welcome
struct WeatherModel: Codable {

    let current: WeatherDetails?
    
    enum CodingKeys: String, CodingKey {
        case current
    }
}

// MARK: - Current
struct WeatherDetails: Codable {
    let dt, sunrise, sunset: Int?
    let temp, feelsLike: Double?
    let pressure, humidity: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let weather: [Weather]?
    let rain: Rain?
    

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, rain
     
    }
}

// MARK: - Rain
struct Rain: Codable {
    let speed: Double?

    enum CodingKeys: String, CodingKey {
        case speed = "1h"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main: String?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

