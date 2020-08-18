//
//  APIData.swift
//  BeCareful
//
//  Created by Israel Filadelfo Calderon Chavez on 21/03/20.
//  Copyright © 2020 Israel Filadelfo Calderon Chavez. All rights reserved.
//

import Foundation
import FirebaseMessaging

// MARK: API Protocol Definition
protocol APIProtocol {
    func registerUser(with id: UserID, result: @escaping(Result<RegisterStatus, APIServiceError>) -> Void)
    func validateRegister(with data: RegisterOTP, result: @escaping(Result<RegisterOTPStatus, APIServiceError>) -> Void)
    func send(devices: DeviceModel, result: @escaping(Result<RegisterStatus, APIServiceError>) -> Void)
}

// MARK: - Error Definition
enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

// MARK: - API Client Implementation
class APIData: APIProtocol {

    // MARK: Properties
    private let urlSession = URLSession.shared

    // MARK: - Public Methods
    public func registerUser(with id: UserID, result: @escaping(Result<RegisterStatus, APIServiceError>) -> Void) {
        fetchResources(targetType: .register(userID: id), completion: result)
    }

    public func validateRegister(with data: RegisterOTP, result: @escaping(Result<RegisterOTPStatus, APIServiceError>) -> Void) {
        fetchResources(targetType: .validation(code: data), completion: result)
    }

    public func send(devices: DeviceModel, result: @escaping(Result<RegisterStatus, APIServiceError>) -> Void) {
        fetchResources(targetType: .send(devices: devices), completion: result)
    }
}

// MARK: - API Definition
extension APIData {

    enum TargetType {
        case register(userID: UserID)
        case validation(code: RegisterOTP)
        case send(devices: DeviceModel)

        // MARK: - Properties
        var baseURL: URL {
            var url: String = ""
            switch self {
            default:
                // TODO: - Change for your url mock but no do push 
                url = "https://polls.apiblueprint.org"
            }
            return URL(string: url)!
        }

        var apiKey: String {
            switch self {
            default:
                return ""
            }
        }

        var path: String {
            switch self {
            case .register:
                return "/register"
            case .validation:
                return "/register/validation"
            case .send:
                return "/status"
            }
        }

        var headers: [String: String] {
            switch self {
            case .send:
                let headers: [String: String] = ["application/json": "Content-Type"]
                return headers
            default:
                let headers: [String: String] = ["application/json": "Content-Type"]
                return headers
            }
        }

        var method: String {
            switch self {
            default:
                return "POST"
            }
        }

        var parameters: Data? {
            switch self {
            case .register(let user):
                let userData = try? self.parameterEncode.encode(user)
                return userData
            case .validation(let data):
                let userData = try? self.parameterEncode.encode(data)
                return userData
            default:
                return nil
            }
        }

        var parameterDecoder: JSONDecoder {
            switch self {
            default:
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                return jsonDecoder
            }
        }

        private var parameterEncode: JSONEncoder {
            switch self {
            default:
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                encoder.outputFormatting = .prettyPrinted
                return encoder
            }
        }
    }
}

extension APIData {

    private func fetchResources<T: Decodable>(targetType: TargetType, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        let urlComponents = targetType.baseURL.appendingPathComponent(targetType.path)
        var request = URLRequest(url: urlComponents)
        request.httpMethod = targetType.method
        targetType.headers.forEach({request.addValue($0.key, forHTTPHeaderField: $0.value)})
        request.httpBody = targetType.parameters

        urlSession.dataTask(with: request) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return }
                do {
                    let values = try targetType.parameterDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                completion(.failure(.apiError))
            }
        }.resume()
    }
}
