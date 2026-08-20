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
                        // Imagen usando AsyncImage
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
                        
                        // Tipos
                        HStack {
                            ForEach(detail.types, id: \.type.name) { typeElem in
                                Text(typeElem.type.name.capitalized)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.15))
                                    .cornerRadius(8)
                            }
                        }
                        
                        // Altura y Peso
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
                        
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Estadísticas Base")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 4)
                            
                            ForEach(detail.stats, id: \.stat.name) { statElem in
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(formattedStatName(statElem.stat.name))
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Spacer()
                                        Text("\(statElem.baseStat) / 255")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    // BARANDILLA DESLIZANTE DE PROGRESO
                                    ProgressView(value: Double(statElem.baseStat), total: 255.0)
                                        .tint(statColor(for: statElem.baseStat))
                                }
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemGroupedBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
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
    
    // Función auxiliar para formatear los nombres de las stats
    private func formattedStatName(_ name: String) -> String {
        switch name {
        case "hp": return "HP"
        case "attack": return "Ataque"
        case "defense": return "Defensa"
        case "special-attack": return "Atq. Especial"
        case "special-defense": return "Def. Especial"
        case "speed": return "Velocidad"
        default: return name.capitalized
        }
    }
    
    // Función auxiliar para cambiar el color de la barra según el nivel del valor
    private func statColor(for value: Int) -> Color {
        switch value {
        case 0..<50: return .red
        case 50..<80: return .orange
        case 80..<100: return .yellow
        default: return .green
        }
    }
}

#Preview {
    PokemonDetailView(pokemonName: "pikachu")
}
