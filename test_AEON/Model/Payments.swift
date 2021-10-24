//
//  Payments.swift
//  test_AEON
//
//  Created by Andrey on 22.10.2021.
//

import Foundation

struct PaymentsResponse: Codable {
    let response: [Payments]
}

struct Payments: Codable {
    let amount: String?
    let created: Int?
    let currency: String?
    let desc: String
}

extension Payments {
    
    enum Key: String, CodingKey {
        case amount = "amount"
        case created = "created"
        case currency = "currency"
        case desc = "desc"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        self.created = try? container.decode(Int.self, forKey: .created)
        self.currency = try? container.decode(String.self, forKey: .currency)
        self.desc = try container.decode(String.self, forKey: .desc)
        
        if let amount = try? container.decode(Double.self, forKey: .amount) {
            self.amount = String(amount)
        } else {
            self.amount = try? container.decode(String.self, forKey: .amount)
        }
    }
}
