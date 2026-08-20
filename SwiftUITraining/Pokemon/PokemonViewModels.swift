import Foundation
import Combine

// MARK: - ViewModel Lista
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
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
        } catch {
            self.errorMessage = "Error general: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

// MARK: - ViewModel Detalle
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
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
        } catch {
            self.errorMessage = "Error al cargar datos de \(name): \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
