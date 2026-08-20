import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack(spacing: 12) {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Cargando Pokédex...")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 44))
                        .foregroundColor(.red)
                    
                    Text("No se pudo cargar la información")
                        .font(.headline)
                    
                    Text(error)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    Button {
                        Task { await viewModel.loadPokemons() }
                    } label: {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Reintentar")
                        }
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.top, 8)
                }
                .padding()
            } else {
                List(viewModel.pokemons) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemonName: pokemon.name)) {
                        HStack {
                            Image(systemName: "circle.circle.fill")
                                .foregroundColor(.red)
                                .font(.caption)
                            Text(pokemon.name.capitalized)
                                .font(.body)
                                .fontWeight(.medium)
                        }
                    }
                }
            }
        }
        .navigationTitle("Pokédex")
        .task {
            if viewModel.pokemons.isEmpty {
                await viewModel.loadPokemons()
            }
        }
    }
}

#Preview {
    NavigationStack {
        PokemonListView()
    }
}
