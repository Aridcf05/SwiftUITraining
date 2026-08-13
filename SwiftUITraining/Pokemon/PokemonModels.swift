import Foundation

// MARK: - Modelos Servicio 1 (Lista)
struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable, Hashable {
    let name: String
    let url: String
    
    var id: String { name }
}

// MARK: - Modelos Servicio 2 (Detalle)
struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [TypeElement]
    
    struct Sprites: Codable {
        let frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    struct TypeElement: Codable {
        let type: TypeInfo
    }
    
    struct TypeInfo: Codable {
        let name: String
    }
}
