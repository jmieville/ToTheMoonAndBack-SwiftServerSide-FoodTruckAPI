//
//  Config.swift
//  FoodTruckAPI
//
//  Created by Jean-Marc Kampol Mieville on 3/12/2560 BE.
//
//

import Foundation
import LoggerAPI
import CouchDB
import CloudFoundryEnv
import Configuration

struct ConfigError: LocalizedError {
    var errorDescription: String? {
        return "Could not retrieve config info"
    }
}

func getConfig() throws -> Service {
    var appEnv: ConfigurationManager?
    
    do {
        Log.warning("Attempting to retrieve CF Env")
        appEnv = try ConfigurationManager()
        
        let services = appEnv!.getServices()
        let servicePair = services.filter { element in element.value.label == "cloudantNoSQLDB" }.first
        
        guard let service = servicePair?.value else {
            throw ConfigError()
        }
        return service
    } catch {
        Log.warning("An error occured while trying to retrieve config")
        throw ConfigError()
    }
}
