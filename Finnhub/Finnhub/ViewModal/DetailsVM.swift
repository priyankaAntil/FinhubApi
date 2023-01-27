//
//  DetailsVM.swift
//  Finnhub
//
//  Created by Priyanka on 21/01/23.
//

import Foundation
import FinnhubSwift

class DetailsVM {
    
    var whenDone: ((CompanyProfile)->Void)?

    var svgUrlRemote: URL {
        let path = (companyProfile?.logo)!
        return URL(string: path)!
    }
    
    var companyProfile: CompanyProfile? {
        didSet {
            guard let data = companyProfile else {return}
            whenDone?(data)
        }
    }
    
    func fetchData(for symbol:String) {
        
        FinnhubClient.companyProfile2(symbol: symbol) { result in
             switch result {
             case let .success(data):
                 self.companyProfile = data
             case .failure(.invalidData):
                 print("Invalid data")
             case let .failure(.networkFailure(error)):
                 print(error)
             }
         }
    }
}
