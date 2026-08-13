import Foundation
import Combine
// MARK: - ViewModel para la Lista
@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadPokemons() async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.pokemons = try await PokeAPIService.shared.fetchPokemonList()
        } catch {
            self.errorMessage = "Error al obtener la lista de Pokémon."
        }
        
        isLoading = false
    }
}

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadDetail(for name: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.pokemonDetail = try await PokeAPIService.shared.fetchPokemonDetail(name: name)
        } catch {
            self.errorMessage = "Error al cargar los datos de \(name)."
        }
        
        isLoading = false
    }
}
