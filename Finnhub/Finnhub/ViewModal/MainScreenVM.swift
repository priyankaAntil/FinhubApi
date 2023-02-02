//
//  MainScreenVM.swift
//  Finnhub
//
//  Created by Priyanka on 21/01/23.
//

import Foundation

import FinnhubSwift
 
class MainScreenVM {
    
    var whenDone:(() -> Void)? = nil
    
    private var cellVM = [CellVM]()
    
    var uniqueTrades = [Trade]()
    
    func numberOfRows() -> Int {
        return self.uniqueTrades.count
    }
    
    func getModalAt(index : Int) -> CellVM {
       return cellVM[index]
    }
    
    func getSymbolForDetails(at:Int) -> String  {
        return self.uniqueTrades[at].s
    }

    func fetchData()  {
        FinnhubLiveClient.shared.subscribe(symbols: Constants.inputArray)
        FinnhubLiveClient.shared.receiveMessage { result in
            switch result {
            case let .success(success):
            switch success {
              case let .trades(trades):
                if self.uniqueTrades.count != Constants.inputArray.count {
                    for item in trades.data {
                        self.uniqueTrades.appendIfUnique(item, check: { $0.s })
                        self.cellVM.append(CellVM())
                    }
                }
                for (index,item) in self.uniqueTrades.enumerated() {
                    if let row = trades.data.firstIndex(where: {$0.s == item.s}) {
                        self.cellVM[index].trades = trades.data[row]
                        self.uniqueTrades[index] = trades.data[row]
                        self.whenDone!()
                    }
                }
            case .news(_): break
            case .ping(_): break
            case .empty:
                  print("Empty data")
              }
            case let .failure(failure):
                switch failure {
                case .networkFailure:
                    print(failure)
                case .invalidData:
                    print("Invalid data")
                case .unknownFailure:
                    print("Unknown failure")
                }
            }
        }
    }
}
