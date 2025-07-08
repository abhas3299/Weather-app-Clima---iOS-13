
import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
        searchTextField.delegate = self

        setupSpinner()
    }

    func setupSpinner() {
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }

    @IBAction func locationPressed(_ sender: UIButton) {
        spinner.startAnimating()
        locationManager.requestLocation()
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        spinner.startAnimating()
        searchTextField.endEditing(true)
    }

    func updateBackground(for condition: String) {
        switch condition {
        case "sun.max":
            backgroundView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.4)
        case "cloud.bolt":
            backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        case "cloud.rain":
            backgroundView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.3)
        case "cloud.snow":
            backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        case "cloud.fog":
            backgroundView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        default:
            backgroundView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.3)
        }
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()

            UIView.animate(withDuration: 0.5) {
                self.temperatureLabel.alpha = 0
                self.cityLabel.alpha = 0
                self.conditionImageView.alpha = 0
            } completion: { _ in
                self.temperatureLabel.text = weather.temperatureString
                self.cityLabel.text = weather.cityName
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)

                self.updateBackground(for: weather.conditionName)

                UIView.animate(withDuration: 0.5) {
                    self.temperatureLabel.alpha = 1
                    self.cityLabel.alpha = 1
                    self.conditionImageView.alpha = 1
                }
            }
        }
    }

    func didFailWithError(error: any Error) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.showErrorAlert(message: "Failed to fetch weather data. Please try again.")
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        spinner.stopAnimating()
        showErrorAlert(message: "Location not found. Try again.")
    }
}
