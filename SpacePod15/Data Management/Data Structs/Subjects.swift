//
//  Subjects.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 18/11/21.
//

import Foundation

struct Subject: Hashable {
    public static let subjects: [Subject] = [
        Subject(name: "Literature",emoji: "📖", background: "bgItaliano", awards: [
            Award(name: "Dante Award", description: "Your first achievement!", imageName: "medLetteraturaBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medLetteraturaArgento"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medLetteraturaOro"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medLetteraturaOro"),//Clone to add fake awards
        ]),
        Subject(name: "Geography",emoji: "🌎", background: "bgGeografia", awards: [
            Award(name: "Italy Award", description: "Your first achievement!", imageName: "medGeografiaBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medGeografiaArgento"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medGeografiaOro"),
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medGeografiaOro"),//Clone to add fake awards
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medGeografiaOro"),//Clone to add fake awards
            
        ]),
        Subject(name: "Math",emoji: "🧮", background: "bgMatematica", awards: [
            Award(name: "Eulero Award", description: "Your first achievement!", imageName: "medMatematicaBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medLetteraturaArgento"),//FAKE
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medLetteraturaOro"),//FAKE
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medLetteraturaOro"),//FAKE //Clone to add fake awards
        ]),
        Subject(name: "Science",emoji: "🧪", background: "bgScienze", awards: [
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medScienzeBronzo"),
            Award(name: "Newton Award", description: "Your second achievement!", imageName: "medScienzeArgento"),
            Award(name: "Newton Award", description: "Your third achievement!", imageName: "medScienzeOro"),
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medScienzeOro"),//Clone to add fake awards
            Award(name: "Newton Award", description: "Your first achievement!", imageName: "medScienzeOro"),//Clone to add fake awards
            
        ])
    ]
    
    let name: String
    let emoji: String
    let background: String
    let awards: [Award]
}

struct Award: Hashable {
    var name: String
    var description: String
    var imageName: String
}
