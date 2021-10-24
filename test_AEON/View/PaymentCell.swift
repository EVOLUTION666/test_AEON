//
//  PaymentCell.swift
//  test_AEON
//
//  Created by Andrey on 23.10.2021.
//

import UIKit

class PaymentCell: UITableViewCell {
    
    var amountLabel: UILabel!
    var createdLabel: UILabel!
    var currencyLabel: UILabel!
    var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLabels()
        configureBackgroundView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabels() {
        amountLabel = UILabel()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.numberOfLines = 0
        amountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        addSubview(amountLabel)
        
        createdLabel = UILabel()
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.numberOfLines = 0
        addSubview(createdLabel)

        currencyLabel = UILabel()
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.numberOfLines = 0
        currencyLabel.font = UIFont.boldSystemFont(ofSize: 20)
        addSubview(currencyLabel)

        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
//            amountLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            amountLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            
            currencyLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
//            currencyLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
//            currencyLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            
            descriptionLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
//            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            
            createdLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            createdLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            createdLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
//            createdLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            
            
        ])
    }
    
    func configureBackgroundView() {
        backgroundView?.backgroundColor = .black
    }
    
    func set(payment: Payments) {
        amountLabel.text = "Потрачено: \(payment.amount ?? "") ₽"
        if let timeResult = payment.created {
            let date = Date(timeIntervalSince1970: Double(timeResult))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd:MM:YY hh:mm:ss"
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            print(localDate)
            createdLabel.text = localDate
        } else {
            print("error")
        }
        
        if let currency = payment.currency {
            // empty string
            currencyLabel.text = currency == "" ? "Валюта: Отсутствует" : "Валюта: \(currency)"
        } else {
            //nil
            currencyLabel.text = "Валюта: Отсутствует"
        }
        descriptionLabel.text = "Описание: \(payment.desc)"
    }

}
