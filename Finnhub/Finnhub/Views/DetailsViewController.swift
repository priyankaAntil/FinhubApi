//
//  DetailsViewController.swift
//  Finnhub
//
//  Created by Priyanka on 21/01/23.
//

import UIKit
import FinnhubSwift
import WebKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companySymbol: UILabel!
    @IBOutlet weak var companyCountry: UILabel!
    
    @IBOutlet weak var companyUrl: UILabel!
    @IBOutlet weak var companyIndustry: UILabel!
    @IBOutlet weak var companyPhone: UILabel!
    @IBOutlet weak var companyIPO: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var logoWV: WKWebView!
    @IBOutlet weak var companyCapaital: UILabel!
    let detailVM = DetailsVM()
    var symbol: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let symbol = symbol {
            detailVM.fetchData(for: symbol)
            detailVM.whenDone = { data in
                self.updateUI(with: data)
            }
        }
    }
    
    private func updateUI(with companyData: CompanyProfile) {
        DispatchQueue.main.async { [weak self] in
            self?.companyName.text = companyData.name
            self?.companySymbol.text = self?.symbol!
            self?.companyCountry.text = companyData.country
            self?.companyCapaital.text = String(describing: companyData.marketCapitalization)
            self?.currency.text = companyData.currency
            self?.companyUrl.text = companyData.weburl
            self?.companyIPO.text = companyData.ipo
            self?.companyIndustry.text = companyData.finnhubIndustry
            var svgUrlRemote: URL {
                let path = companyData.logo
                return URL(string: path)!
            }
            let request = URLRequest(url: svgUrlRemote)
            self?.logoWV.load(request)
        }
    }
}
