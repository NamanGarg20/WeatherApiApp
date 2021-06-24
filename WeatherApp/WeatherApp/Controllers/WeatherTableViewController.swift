//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by NAMAN GARG on 6/16/21.
//

import UIKit

protocol weatherDelegate {
    func getWeatherDetail(_ weatherDetail: WeatherDetails)
}

class WeatherTableViewController: UITableViewController {
    let weather = WeatherJson()
    var weatherArray = [WeatherDetails]()
    
    let newtitle = "Daily Weather"
    
    var weatherDetails: WeatherDetails?
    
    var delegate: weatherDelegate?
    
    func generateWeatherData(){
        for i in 0...3{
            let date = weather.generateDate(i)
            weather.getJson(date){ [self] result in
                self.weatherArray.append(result.current!)
                self.weatherDetails = result.current
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        generateWeatherData()
        navigationItem.title = newtitle
        let customButton = UIBarButtonItem()
        customButton.title = "Daily Weather"
        navigationItem.backBarButtonItem = customButton
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
            cell.temp.text = "\(weatherArray[indexPath.row].temp!) ºC"
            cell.humidity.text = "\(weatherArray[indexPath.row].humidity!) %"
            cell.weather.text = (weatherArray[indexPath.row].weather?.first?.weatherDescription!)
            let imageIcon = weatherArray[indexPath.row].weather?.first?.icon!
            
            if let url = URL(string: "https://openweathermap.org/img/w/\(imageIcon!).png"){
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        cell.imageView?.image = UIImage(data: data)
                    }
                }

                task.resume()
            }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherDetails = weatherArray[indexPath.row]
        delegate?.getWeatherDetail(weatherDetails!)
        if let detailVC = delegate as? WeatherDetailViewController,
           let navVC = detailVC.navigationController{
            splitViewController?.showDetailViewController(navVC, sender: nil)
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
