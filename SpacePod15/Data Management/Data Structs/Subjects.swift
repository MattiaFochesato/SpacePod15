//
//  Subjects.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 18/11/21.
//

import Foundation

struct Subject: Hashable {
    public static let subjects: [Subject] = [
        Subject(name: "Italiano",emoji: "📖", awards: [
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "testAward")
        ]),
        Subject(name: "Geography",emoji: "🌎", awards: [
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medGeografiaBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medGeografiaArgento"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medGeografiaOro"),
            
        ]),
        Subject(name: "Matematica",emoji: "🧮", awards: []),
        Subject(name: "Storia",emoji: "🪖", awards: []),
        Subject(name: "Fisica",emoji: "⚡️", awards: []),
        Subject(name: "Chimica",emoji: "🧪", awards: [])
    ]
    
    let name: String
    let emoji: String
    let awards: [Award]
}

struct Award: Hashable {
    var name: String
    var description: String
    var imageName: String
}
