//
//  HomeScreenCell.swift
//  Finnhub
//
//  Created by Priyanka on 21/01/23.
//

import UIKit

class HomeScreenCell: UITableViewCell {
    
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var cellVM: CellVM? {
        didSet {
            guard let vm = cellVM, let trade = vm.trades else {
                return
            }
            DispatchQueue.main.async {
                self.symbol.text = trade.s
                self.value.text = vm.diffrenceAndPercentage
                self.value.textColor = vm.valueColor
                self.price.text = vm.getPrice()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
