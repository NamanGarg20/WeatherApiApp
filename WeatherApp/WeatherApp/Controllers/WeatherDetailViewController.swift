//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by NAMAN GARG on 6/16/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temp: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var rain: UILabel!
    
    @IBOutlet var feelsLike: UILabel!
    
    @IBOutlet var windSpeed: UILabel!
    
    @IBOutlet var windDeg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWeather()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Weather Details"
        let customButton = UIBarButtonItem()
        customButton.title = "Daily Weather"
        navigationItem.backBarButtonItem = customButton
    }
    var weather: WeatherDetails? {
        didSet{
            configureWeather()
        }
    }
    
    func configureWeather(){
        if let new_weather = weather{
            temp.text = " Temp: \(String(describing: new_weather.temp!)) ºC"
            humidity.text = "Humidity: \(String(describing: new_weather.humidity!)) %"
            pressure.text = "Pressure: \(String(describing: new_weather.pressure!))"
            if let f = new_weather.rain?.speed{
                rain.text = "Rain: chance of rain \(f) %"
            }
            else{
                rain.text = "Rain: No chance of rain"
            }
            feelsLike.text = "Feels Like: \(String(describing: new_weather.feelsLike!)) ºC"
            windSpeed.text = "Wind Speed: \(new_weather.windSpeed!)"
            weatherDescription.text = (new_weather.weather?.first?.weatherDescription!)!
            windDeg.text = "Wind Degree: \(new_weather.windDeg!) º"
            let imageIcon = new_weather.weather?.first?.icon
            getImage(imageIcon)
        }
    }
    
    func getImage(_ imageIcon: String?){
        if let url = URL(string: "https://openweathermap.org/img/w/\(imageIcon!).png"){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.weatherIcon.image = UIImage(data: data)
                                    }
            }
            task.resume()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WeatherDetailViewController: weatherDelegate{
    
    func getWeatherDetail(_ weatherDetail: WeatherDetails) {
        weather = weatherDetail
    }
}
