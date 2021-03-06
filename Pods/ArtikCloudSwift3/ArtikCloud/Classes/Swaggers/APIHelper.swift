// APIHelper.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

class APIHelper {
    static func rejectNil(_ source: [String:Any?]) -> [String:Any]? {
        var destination = [String:Any]()
        for (key, nillableValue) in source {
            if let value = nillableValue {
                destination[key] = value
            }
        }

        if destination.isEmpty {
            return nil
        }
        return destination
    }

    static func convertBoolToString(_ source: [String: Any]?) -> [String:Any]? {
        guard let source = source else {
            return nil
        }
        var destination = [String:Any]()
        for (key, value) in source {
            if let value = value as? Bool {
                destination[key] = "\(value)"
            } else {
                destination[key] = value
            }
        }
        return destination
    }

}
