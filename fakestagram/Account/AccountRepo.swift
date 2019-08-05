//
//  AccountRepo.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class AccountRepo {
    static let shared = AccountRepo()
    private let client = AccountClient()
    
    typealias accountResponse = (Account) -> Void
    
    func loadOrCreate(success: accountResponse?) {
        if let account = load() {
            success?(account)
            return
        }
        
        let newAccount = Account.initialize()
        
        create(newAccount) { account in
            success?(account)
            AccountStorage.shared.item = account
            AccountStorage.shared.save()
           
        }
    }
    
    func load() -> Account? {
        return AccountStorage.shared.item
    }
    
    func create(_ account: Account, success: @escaping (Account) -> Void) {
        client.create(codable: account, success: success)
    }
}
