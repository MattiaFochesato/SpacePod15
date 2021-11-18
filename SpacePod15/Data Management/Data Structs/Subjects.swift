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
        Subject(name: "Geografia",emoji: "🌎", awards: []),
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
