//
//  Subjects.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 18/11/21.
//

import Foundation

struct Subject: Hashable {
    public static let subjects: [Subject] = [
        Subject(name: "Letteratura",emoji: "📖", awards: [
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "testAward"),
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medLetteraturaBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medLetteraturaArgento"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medLetteraturaOro"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medLetteraturaOro"),//Clone to add fake awards
        ]),
        Subject(name: "Geography",emoji: "🌎", awards: [
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medGeografiaBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medGeografiaArgento"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medGeografiaOro"),
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medGeografiaOro"),//Clone to add fake awards
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medGeografiaOro"),//Clone to add fake awards
            
        ]),
        Subject(name: "Matematica",emoji: "🧮", awards: [
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medMatematicaBronzo"),
        ]),
        Subject(name: "Scienze",emoji: "🧪", awards: [
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medScienzeBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medScienzeArgento"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medScienzeOro"),
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medScienzeOro"),//Clone to add fake awards
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medScienzeOro"),//Clone to add fake awards
            
        ])
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
