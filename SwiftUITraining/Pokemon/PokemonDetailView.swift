import SwiftUI

struct PokemonDetailView: View {
    let pokemonName: String
    @StateObject private var viewModel = PokemonDetailViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Cargando información...")
            } else if let detail = viewModel.pokemonDetail {
                ScrollView {
                    VStack(spacing: 20) {
                        if let spriteUrl = detail.sprites.frontDefault, let url = URL(string: spriteUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 180, height: 180)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        Text("#\(detail.id) \(detail.name.capitalized)")
                            .font(.largeTitle)
                            .bold()
                        
                        HStack {
                            ForEach(detail.types, id: \.type.name) { typeElem in
                                Text(typeElem.type.name.capitalized)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }
                        
                        HStack(spacing: 40) {
                            VStack {
                                Text("Altura").font(.caption).foregroundColor(.gray)
                                Text("\(Double(detail.height) / 10.0, specifier: "%.1f") m").font(.headline)
                            }
                            VStack {
                                Text("Peso").font(.caption).foregroundColor(.gray)
                                Text("\(Double(detail.weight) / 10.0, specifier: "%.1f") kg").font(.headline)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding()
                }
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle(pokemonName.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetail(for: pokemonName)
        }
    }
}

#Preview {
    PokemonDetailView(pokemonName: "pikachu")
}
