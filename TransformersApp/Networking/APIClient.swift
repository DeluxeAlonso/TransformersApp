//
//  APIClient.swift
//  TransformersApp
//
//  Created by Alonso on 12/3/20.
//

import Foundation

protocol APIClient {

    var session: URLSession { get }

    func fetch<T: Decodable>(with request: URLRequest,
                             as decodingType: DecodingType,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void)

}

extension APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            and decodingType: DecodingType,
                                            modelType: T.Type,
                                            completionHandler completion: JSONTaskCompletionHandler?) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion?(nil, .requestFailed)
                return
            }
            // Handles empty response
            guard httpResponse.statusCode != 204 else {
                completion?(EmptyResult(), nil)
                return
            }
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                if let data = data {
                    do {
                        let genericModel: T

                        switch decodingType {
                        case .json:
                            let decoder = JSONDecoder()
                            genericModel = try decoder.decode(modelType, from: data)
                        case .propertyList:
                            let decoder = PropertyListDecoder()
                            genericModel = try decoder.decode(modelType, from: data)

                        }
                        completion?(genericModel, nil)

                    } catch {
                        print(error.localizedDescription)
                        completion?(nil, .requestFailed)
                    }
                } else {
                    completion?(nil, .invalidData)
                }
            } else {
                completion?(nil, APIError(response: httpResponse))
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest,
                             as decodingType: DecodingType = .json,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, and: decodingType, modelType: T.self) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.requestFailed))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.requestFailed))
                }
            }
        }
        task.resume()
    }

}
