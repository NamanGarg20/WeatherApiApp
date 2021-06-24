//
//  WeatherApp
//
//  Created by NAMAN GARG on 6/16/21.
//
import UIKit
import Foundation

class WeatherJson{
    //let key = "06626cf5cb77e4503a53367fda906e39"
    let key = "0d2bd24c1fcfca5a1ca3e833aa53ce62"
    
    let resourceApi = "https://api.openweathermap.org"
    
    func generateDate(_ index: Int) -> Int {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let day = DateComponents(year: now.year, month: now.month, day: now.day! - (3 - index))
        let date = Calendar.current.date(from: day)!
        
        let newDate = Int(date.timeIntervalSince1970)
        return newDate
        }

    func getJson(_ date: Int, _ completion : @escaping ((WeatherModel) -> Void)){
        let resourceString = "/data/2.5/onecall/timemachine?lat=39.9523&lon=-75.1638&dt=\(date)&appid=\(key)&units=metric"
        guard let resourceURL = URL(string: resourceApi + resourceString) else {
            fatalError()
        }
        URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
        if let data = data {
            do{
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completion(weather)
            }
            catch{
                print(error)
            }
               }
           }.resume()
    }
    
   
    

}
//extension Date {
//    func getFormattedDateString(format: String) -> String {
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = format
//        dateFormatter.timeZone = TimeZone.current
//        return dateFormatter.string(from: self)
//    }
// }
