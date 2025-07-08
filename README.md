# 🌦️ Clima - iOS Weather App

**Clima** is a beautifully designed iOS weather app that provides real-time weather updates based on your current location or a city of your choice.  
Built entirely in **Swift**, this app was developed as part of my iOS development journey.

---

# 📱 Features

- 🔍 Search for weather by city name
- 📍 Get weather based on device's location (CoreLocation)
- ☁️ Fetch live data using OpenWeatherMap API
- 🌡️ Displays temperature, city name & weather condition icon
- 🎨 Custom UI design using UIKit and Auto Layout
- 💡 Animated background transitions

---

# 🧠 Key Concepts Learned

- Delegates & Protocols  
- Extensions in Swift  
- Networking with `URLSession`  
- JSON parsing with `Codable`  
- CLLocationManager for GPS-based location  
- Handling asynchronous calls & closures  
- Error handling and optional unwrapping  
- UI/UX design using Storyboards & Stack Views

---

# 🛠 Tech Stack

- **Language:** Swift  
- **Frameworks:** UIKit, CoreLocation, Foundation  
- **API:** OpenWeatherMap

---

# 📦 How to Run

1. Clone the repo:  
   `git clone https://github.com/abhas3299/Weather-app-Clima---iOS-13.git`

2. Open the `.xcodeproj` in Xcode

3. Add your API key in the `WeatherManager.swift` file:
   ```swift
   let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=YOUR_API_KEY&units=metric"
