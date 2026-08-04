import Foundation

struct CharacterDTO: Decodable, Identifiable {
    let id: Int
    let fullName: String
    let race: String
    let planet: String
    let isJedi: Bool
    let age: Int

    enum CodingKeys: String, CodingKey {
        case id = "character_id"
        case fullName = "full_name"
        case race
        case planet
        case isJedi = "jedi"
        case age = "years_old"
    }
}
