//
//  ViewController.swift
//  Finnhub
//
//  Created by Priyanka on 21/01/23.
//

import UIKit
import FinnhubSwift

class ViewController: UIViewController {

    let mainScreenVM = MainScreenVM()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainScreenVM.fetchData()
        mainScreenVM.whenDone = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainScreenVM.numberOfRows()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as! HomeScreenCell
        cell.cellVM = mainScreenVM.getModalAt(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            vc.symbol = mainScreenVM.getSymbolForDetails(at: indexPath.row)
            self.present(vc, animated: true)
        }
    }
}

