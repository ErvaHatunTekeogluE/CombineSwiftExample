//
//  ViewController.swift
//  CombineExample
//
//  Created by Erva Hatun Tekeoğlu on 19.09.2023.
//

import Combine
import UIKit

class MyCustomTableCell: UITableViewCell {
   
}
class ViewController: UIViewController, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MyCustomTableCell.self , forCellReuseIdentifier: "cell")
        return table
    }()
    
    var observers: [AnyCancellable] = []
    
    private var models = [Earthquake]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        APICaller.shared.fetchEarthquakes()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("\(error)")
                }
            }, receiveValue: { [weak self] value in
                self?.models = value.results
                self?.tableView.reloadData()
            }).store(in: &observers)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomTableCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = """
            timestamp: \(models[indexPath.row].timestamp)
            latitude: \(models[indexPath.row].latitude)
            longitude: \(models[indexPath.row].longitude)
            depth: \(models[indexPath.row].depth)
            size: \(models[indexPath.row].size)
            Quality: \(models[indexPath.row].quality)
             \(models[indexPath.row].humanReadableLocation)
            """
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    

}

