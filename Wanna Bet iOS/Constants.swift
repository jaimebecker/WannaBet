//
//  Constants.swift
//  WannaBetiOS
//
//  Created by Jaime Becker on 2/4/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

struct K{
    struct Segues{
        static let mainToBet = "MainToBet"
        static let loginToMain = "LoginToMain"
        static let registerToMain = "RegisterToMain"
        static let mainToAddBet = "mainToAddBet"
    }
    
    struct FStore{
        static let collectionName = "bets"
        static let userField = "user"
        static let betTitleField = "betTitle"
        static let betQuestionField = "betQuestion"
        static let betUserChoiceField = "usersChoice"
    }
    
    struct Table{
        static let cell = "ReusableCell"
    }
}
