import Foundation

// MARK: - Catálogo de Errores
enum NetworkError: LocalizedError {
    case noInternet
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError
    case timeout
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "Sin conexión a internet. Espera un momento a que se restablezca la red y reintenta."
        case .invalidURL:
            return "La dirección solicitada no es válida."
        case .serverError(let code):
            return "El servidor respondió con un error (Código HTTP: \(code))."
        case .decodingError:
            return "No se pudieron procesar los datos de PokéAPI."
        case .timeout:
            return "El tiempo de espera se ha agotado. Tu conexión está tardando en responder."
        case .unknown(let message):
            return "Error: \(message)"
        }
    }
}

// MARK: - Servicio PokéAPI
class PokeAPIService {
    static let shared = PokeAPIService()
    private init() {}
    
    // Función auxiliar para construir peticiones sin caché
    private func makeRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10 // 10 segundos para dar margen al DNS del simulador
        return request
    }
    
    // Servicio 1: Obtener Lista Oficial
    func fetchPokemonList(limit: Int = 20, offset: Int = 0) async throws -> [PokemonListItem] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)") else {
            throw NetworkError.invalidURL
        }
        
        let request = makeRequest(for: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown("Respuesta de servidor no válida.")
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
            
            do {
                let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                return decoded.results
            } catch {
                throw NetworkError.decodingError
            }
            
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost, .cannotConnectToHost, .cannotFindHost, .dnsLookupFailed:
                throw NetworkError.noInternet
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw NetworkError.noInternet
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error.localizedDescription)
        }
    }
    
    // Servicio 2: Obtener Detalle del Pokémon
    func fetchPokemonDetail(name: String) async throws -> PokemonDetail {
        let formattedName = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(formattedName)") else {
            throw NetworkError.invalidURL
        }
        
        let request = makeRequest(for: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown("Respuesta de servidor no válida.")
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(PokemonDetail.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
            
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost, .cannotConnectToHost, .cannotFindHost, .dnsLookupFailed:
                throw NetworkError.noInternet
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw NetworkError.noInternet
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error.localizedDescription)
        }
    }
}
