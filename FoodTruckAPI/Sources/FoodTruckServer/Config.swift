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

struct ConfigError: LocalizedError {
    var errorDescription: String? {
        return "Could not retrieve config info"
    }
}

func getConfig() throws -> Service {
    
    var appEnv: AppEnv?
    
    do {
        Log.warning("Attempting to retreive CF Env")
        appEnv = try CloudFoundryEnv.getAppEnv()
        
        let services = appEnv!.getServices()
        let servicePair = services.filter { element in element.value.label == "cloudantNoSQLDB" }.first
        guard let service = servicePair?.value else {
            throw ConfigError()
        }
        return service
    } catch {
        Log.warning("An error occurred while trying to retreive configs")
        throw ConfigError()
    }
}
