//
//  AccountClient.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 26.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class AccountClient: RestClient<Account> {
    convenience init() {
        self.init(client: Client(), path: "/api/accounts")
    }
}
