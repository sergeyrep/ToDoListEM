import Foundation

protocol NetworkServiseProtocol {
  func fetchTodos() async throws -> [ToDo]
  func fetchTodo(id: Int) async throws -> ToDo
}

final class NetworkServise: NetworkServiseProtocol {
  
  private let base = "https://dummyjson.com"
  
  func fetchTodos() async throws -> [ToDo] {
    guard let url = URL(string: base + "/todos") else { throw APIError.invalidURL }
    let (data, resp) = try await URLSession.shared.data(from: url)
    guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
      throw APIError.badStatus((resp as? HTTPURLResponse)?.statusCode ?? -1)
    }
    let decoder = JSONDecoder()
    do {
      let decoded = try decoder.decode(TodosResponse.self, from: data)
      let now = Date()
      return decoded.todos.map {
        ToDo(
          id: $0.id,
          title: $0.todo,
          details: nil,
          createdAt: Date(),
          isCompleted: $0.completed
        )
      }
    } catch {
      throw APIError.decoding
    }
  }
  
  func fetchTodo(id: Int) async throws -> ToDo {
    guard let url = URL(string: base + "/todos/\(id)") else { throw APIError.invalidURL }
    let (data, resp) = try await URLSession.shared.data(from: url)
    guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
      throw APIError.badStatus((resp as? HTTPURLResponse)?.statusCode ?? -1)
    }
    let decoder = JSONDecoder()
    do {
      let decoded = try decoder.decode(TodoDTO.self, from: data)
      let now = Date()
      return ToDo(
          id: decoded.id,
          title: decoded.todo,
          details: nil,
          createdAt: now,
          isCompleted: decoded.completed
        )
    } catch {
      throw APIError.decoding
    }
  }
}

enum APIError: Error {
  case invalidURL
  case badStatus(Int)
  case decoding
}

struct TodosResponse: Decodable {
  let todos: [TodoDTO]
  let total: Int
  let skip: Int
  let limit: Int
}

struct TodoDTO: Decodable {
  let id: Int
  let todo: String
  let completed: Bool
  let userId: Int
}
