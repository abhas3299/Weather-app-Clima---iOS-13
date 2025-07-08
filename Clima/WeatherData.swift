
import Foundation

// Codable is a type alias for both the Encodable and Decodable protocols.
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    
}

struct Weather: Codable {
    let id: Int
}
