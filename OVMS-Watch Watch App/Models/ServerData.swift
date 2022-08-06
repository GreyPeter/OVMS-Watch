//
//  ServerData.swift
//  OVMS-Watch Watch App
//
//  Created by Peter Harry on 6/8/2022.
//

import Foundation

enum Endpoint {
    static let identifierKey = "identifier"
    case charge
    case status
    case vehicles
    case vehicle
    case cookie
    case token
    case location
    var path: String {
        switch self {
        case .charge:
            return "/api/charge/"
        case .status:
            return "/api/status/"
        case .vehicles:
            return "/api/vehicles"
        case .vehicle:
            return "/api/vehicle/"
        case .cookie:
            return "/api/cookie"
        case .token:
            return "/api/token"
        case .location:
            return "/api/location/"
        }
    }
    var identifier: String {
        switch self {
        case .charge:
            return "Charge"
        case .status:
            return "Status"
        case .vehicles:
            return "Vehicles"
        case .vehicle:
            return "Vehicle"
        case .cookie:
            return "Cookie"
        case .token:
            return "Token"
        case .location:
            return "Location"
        }
    }
}

enum Mode {
    static let identifierKey = "identifier"
    case driving
    case charging
    case idle
    var identifier: String {
        switch self {
        case .driving:
            return "D"
        case .charging:
            return "C"
        case .idle:
            return "I"
        }
    }
}

enum DownloadStatus {
    case notStarted
    case queued
    case inProgress(Double)
    case completed
    case failed(Error)
  }

public var lastSOC = 0
var currentToken = Token.initial
var vehicles = Vehicle.dummy
let keyChainService = KeychainService()
var userName = ""

class ServerData: NSObject, ObservableObject {
    static let shared = ServerData()
    var charge: Charge = Charge.dummy
    var status: Status = Status.dummy
    var location: Location = Location.dummy
    var mode: Mode = .idle
    @Published var chargePercent: Double = Double(Charge.dummy.soc) ?? 0.0
    @Published var currMode = Mode.idle.identifier
    
}

func getURL(for endpoint: Endpoint) -> String? {
    var vehicleID = vehicles[0].id
    if endpoint.identifier == "Vehicles" || endpoint.identifier == "Cookie" {
        vehicleID = ""
    }
    if endpoint.identifier == "Token" {
        vehicleID = "/\(currentToken.token)"
    }
    var password = keyChainService.retrievePassword(for: userName) ?? ""
    if currentToken.token != "" && endpoint.identifier != "Token" {
        password = currentToken.token
    }
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.openvehicles.com"
    urlComponents.port = 6869
    urlComponents.path = "\(endpoint.path)\(vehicleID)/"
    urlComponents.query = "username=\(userName)&password=\(String(describing: password))"
    return urlComponents.url?.absoluteString
}


