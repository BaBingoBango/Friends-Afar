//
//  UserData.swift
//  Friends Afar
//
//  Created by Ethan Marshall on 4/10/20.
//  Copyright © 2020 Ethan Marshall. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject, Codable {
    
    // Enumerations
    enum CodingKeys: String, CodingKey {
        case healthcareMode
        case inboxResponses
        case responseModelData
        case badgeOpacity
        case blockList
        case blocksBadWords
        case numRequests
        case numResponses
        case numInbox
    }
    
    // Variables
    let didChange = PassthroughSubject<UserData, Never>()
    
    // Save data variables
    @Published var healthcareMode: Bool {
        didSet {
            didChange.send(self)
        }
    }
    @Published var inboxResponses: [Response] {
        didSet {
            didChange.send(self)
        }
    }
    @Published var responseModelData: [Response] {
        didSet {
            didChange.send(self)
        }
    }
    @Published var badgeOpacity: Double {
        didSet {
            didChange.send(self)
        }
    }
    @Published var blockList: [String] {
        didSet {
            didChange.send(self)
        }
    }
    @Published var blocksBadWords: Bool {
        didSet {
            didChange.send(self)
        }
    }
    @Published var numRequests: Int {
        didSet {
            didChange.send(self)
        }
    }
    @Published var numResponses: Int {
        didSet {
            didChange.send(self)
        }
    }
    @Published var numInbox: Int {
        didSet {
            didChange.send(self)
        }
    }
    
    // Non-save data variables
    var badWords: [String] = [
        "5h1t",
        "5hit",
        "a$$",
        "a$$hole",
        "a_s_s",
        "a2m",
        "a54",
        "a55",
        "a55hole",
        "ass fuck",
        "ass hole",
        "assbag",
        "assbandit",
        "assbang",
        "assbanged",
        "assbanger",
        "assbangs",
        "assbite",
        "assclown",
        "asscock",
        "asscracker",
        "assface",
        "assfaces",
        "assfuck",
        "assfucker",
        "ass-fucker",
        "assfukka",
        "assgoblin",
        "assh0le",
        "asshat",
        "ass-hat",
        "asshead",
        "assho1e",
        "asshole",
        "assholes",
        "asshopper",
        "ass-jabber",
        "assjacker",
        "asslick",
        "asslicker",
        "assmaster",
        "assmonkey",
        "assmucus",
        "assmucus",
        "assmunch",
        "assmuncher",
        "assnigger",
        "asspirate",
        "ass-pirate",
        "assshit",
        "assshole",
        "asssucker",
        "asswad",
        "asswhole",
        "asswipe",
        "asswipes",
        "b!tch",
        "b00bs",
        "b17ch",
        "b1tch",
        "bi+ch",
        "biatch",
        "bitch",
        "bitch tit",
        "bitch tit",
        "bitchass",
        "bitched",
        "bitcher",
        "bitchers",
        "bitches",
        "bitchin",
        "bitching",
        "bitchtits",
        "bitchy",
        "black cock",
        "boong",
        "booobs",
        "boooobs",
        "booooobs",
        "booooooobs",
        "c.0.c.k",
        "c.o.c.k.",
        "c.u.n.t",
        "c0ck",
        "c-0-c-k",
        "c0cksucker",
        "chick with a dick",
        "child-fucker",
        "climax, clit",
        "clit licker",
        "clit licker",
        "clitface",
        "clitfuck",
        "clitoris",
        "clitorus",
        "clits",
        "clitty",
        "clitty litter",
        "coccydynia",
        "cock, cunt",
        "c-u-n-t",
        "cunt hair",
        "cunt hair",
        "shit",
        "ejaculate",
        "f u c k",
        "f u c k e r",
        "f.u.c.k",
        "f_u_c_k",
        "f4nny, fagbag",
        "fagfucker",
        "fagg",
        "fagged",
        "fagging",
        "faggit",
        "faggitt",
        "faggot",
        "fcuk",
        "fcuker",
        "fcuking",
        "fuck",
        "f-u-c-k",
        "fuck buttons",
        "fuck hole",
        "fuck hole",
        "Fuck off",
        "fuck puppet",
        "fuck trophy",
        "fuck yo mama",
        "fuck you",
        "fucka",
        "fuckass",
        "fuck-ass",
        "fuck-ass",
        "fuckbag",
        "fuck-bitch",
        "fuck-bitch",
        "fuckboy",
        "fuckbrain",
        "fuckbutt",
        "fuckbutter",
        "fucked",
        "fuckedup",
        "fucker",
        "fuckers",
        "fuckersucker",
        "fuckface",
        "fuckhead",
        "fuckheads",
        "fuckhole",
        "fuckin",
        "fucking",
        "fuckings",
        "fuckingshitmotherfucker",
        "fuckme",
        "fuckme",
        "fuckmeat",
        "fuckmeat",
        "fucknugget",
        "fucknut",
        "fucknutt",
        "fuckoff",
        "fucks",
        "fuckstick",
        "fucktard",
        "fuck-tard",
        "fucktards",
        "fucktart",
        "fucktoy",
        "fucktoy",
        "fucktwat",
        "fuckup",
        "fuckwad",
        "fuckwhit",
        "fuckwit",
        "fuckwitt",
        "fudge packer",
        "fudgepacker",
        "fudge-packer",
        "fuk",
        "fuker",
        "fukker",
        "fukkers",
        "fukkin",
        "fuks",
        "fukwhit",
        "fukwit",
        "fuq",
        "futanari",
        "fux",
        "fux0r",
        "fvck",
        "fxck",
        "gangbang",
        "gayass",
        "gaybob",
        "gaydo",
        "gayfuck",
        "gayfuckist",
        "gaysex",
        "gaytard",
        "gaywad",
        "giant cock",
        "jerk off",
        "male squirting",
        "masterb8",
        "masterbat*",
        "masterbat3",
        "masterbate",
        "master-bate",
        "master-bate",
        "masterbating",
        "masterbation",
        "masterbations",
        "masturbate",
        "masturbating",
        "masturbation",
        "maxi",
        "mcfagget",
        "menage a trois",
        "menses",
        "menstruate",
        "menstruation",
        "m-fucking",
        "mothafuck",
        "mothafucka",
        "mothafuckas",
        "mothafuckaz",
        "mothafucked",
        "mothafucked",
        "mothafucker",
        "mothafuckers",
        "mothafuckin",
        "mothafucking",
        "mothafucking",
        "mothafuckings",
        "mothafucks",
        "mother fucker",
        "mother fucker",
        "motherfuck",
        "motherfucka",
        "motherfucked",
        "motherfucker",
        "motherfuckers",
        "motherfuckin",
        "motherfucking",
        "motherfuckings",
        "motherfuckka",
        "motherfucks",
        "muthafecker",
        "muthafuckker",
        "muther",
        "mutherfucker",
        "n1gga",
        "n1gger",
        "igaboo",
        "nigg3r",
        "nigg4h",
        "nigga",
        "niggah",
        "niggas",
        "niggaz",
        "nigger",
        "niggers",
        "p.u.s.s.y.",
        "p0rn",
        "paedophile",
        "paki",
        "panooch",
        "penis",
        "phone sex",
        "phonesex",
        "phuck",
        "phuk",
        "phuked",
        "phuking",
        "phukked",
        "phukking",
        "phuks",
        "phuq",
        "piece of shit",
        "pigfucker",
        "porn",
        "porno",
        "pornography",
        "reverse cowgirl",
        "revue",
        "rimjaw",
        "rimjob",
        "rimming",
        "rtard",
        "r-tard",
        "s.h.i.t.",
        "s_h_i_t",
        "sand nigger",
        "sh!+",
        "sh!t",
        "sh1t",
        "s-h-1-t",
        "shag",
        "shagger",
        "shaggin",
        "shagging",
        "shamedame",
        "shaved beaver",
        "shaved pussy",
        "shemale, shi+",
        "shibari",
        "shirt lifter",
        "shit",
        "s-h-i-t",
        "slut",
        "whore",
        "penis"
    ]
    
    // Methods
    init() {
        healthcareMode = false
        inboxResponses = [Response]()
        responseModelData = [Response]()
        badgeOpacity = 0.0
        blockList = [String]()
        blocksBadWords = true
        numRequests = 0
        numResponses = 0
        numInbox = 0
    }
    func saveToFile() {
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directoryURL.appendingPathComponent("UserData.json")
        let myEncoder = JSONEncoder()
        do {
            let encoded = try? myEncoder.encode(self)
            try encoded?.write(to: fileURL, options: [])
        } catch {
            print("There is an error in the saveToFile() method of UserData.")
        }
    }
    static func getFromFile() -> UserData? {
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = directoryURL.appendingPathComponent("UserData.json")
        let myDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL, options: [])
            let decoded = try? myDecoder.decode(UserData.self, from: data)
            return decoded!
        } catch {
            print("There is an error in the getFromFile() method of UserData.")
        }
        return UserData()
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(healthcareMode, forKey: .healthcareMode)
        try container.encode(inboxResponses, forKey: .inboxResponses)
        try container.encode(responseModelData, forKey: .responseModelData)
        try container.encode(badgeOpacity, forKey: .badgeOpacity)
        try container.encode(blockList, forKey: .blockList)
        try container.encode(blocksBadWords, forKey: .blocksBadWords)
        try container.encode(numRequests, forKey: .numRequests)
        try container.encode(numResponses, forKey: .numResponses)
        try container.encode(numInbox, forKey: .numInbox)
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        healthcareMode = try values.decode(Bool.self, forKey:  .healthcareMode)
        inboxResponses = try values.decode([Response].self, forKey: .inboxResponses)
        responseModelData = try values.decode([Response].self, forKey: .responseModelData)
        badgeOpacity = try values.decode(Double.self, forKey: .badgeOpacity)
        blockList = try values.decode([String].self, forKey: .blockList)
        blocksBadWords = try values.decode(Bool.self, forKey: .blocksBadWords)
        numRequests = try values.decode(Int.self, forKey: .numRequests)
        numResponses = try values.decode(Int.self, forKey: .numResponses)
        numInbox = try values.decode(Int.self, forKey: .numInbox)
    }
}
