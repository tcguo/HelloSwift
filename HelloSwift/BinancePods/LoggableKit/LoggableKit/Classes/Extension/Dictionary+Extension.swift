// Copyright © 2021 Binance. All rights reserved.

extension Dictionary {
    public func toJSONData(_ options: JSONSerialization.WritingOptions = []) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }

    public func toJSONString(prettyPrint: Bool = true) -> String? {
        let options: JSONSerialization.WritingOptions = prettyPrint ? .prettyPrinted : []
        if let jsonData = toJSONData(options) {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
    }
}
