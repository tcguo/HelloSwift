//
//  NetworkBaseData.swift
//  HelloSwift
//
//  Created by gtc on 2021/8/5.
//

import Foundation

struct NetworkBaseData<T: Codable>: Codable {
    var status: Int
    var message: String
    var serverTm: UInt64
    var data: T?
}

class URLSessionTaskMetricsLogger: NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for transactionMetric in metrics.transactionMetrics {
            // 打印各个阶段的耗时
            transactionMetric
            if let fetchStartDate = transactionMetric.fetchStartDate, // 开始请求时间
               let domainLookupStartDate = transactionMetric.domainLookupStartDate, // DNS 解析开始时间
               let domainLookupEndDate = transactionMetric.domainLookupEndDate, // DNS 解析结束时间
               let connectStartDate = transactionMetric.connectStartDate, // TCP 连接开始时间
               let connectEndDate = transactionMetric.connectEndDate, // TCP 连接结束时间
               let secureConnectionStartDate = transactionMetric.secureConnectionStartDate, // TLS 握手开始时间
               let secureConnectionEndDate = transactionMetric.secureConnectionEndDate, // TLS 握手结束时间
               let requestStartDate = transactionMetric.requestStartDate,  // 请求发送开始时间
               let requestEndDate = transactionMetric.requestEndDate, // 请求发送结束时间
               let responseStartDate = transactionMetric.responseStartDate, // 服务器处理开始时间
               let responseEndDate = transactionMetric.responseEndDate { // 服务器处理结束时间
                
                let dnsTime = domainLookupEndDate.timeIntervalSince(domainLookupStartDate)
                let connectTime = connectEndDate.timeIntervalSince(connectStartDate)
                let tlsTime = secureConnectionEndDate.timeIntervalSince(secureConnectionStartDate)
                let requestTime = requestEndDate.timeIntervalSince(requestStartDate)
                let serverProcessingTime = responseStartDate.timeIntervalSince(requestEndDate)
                let responseTime = responseEndDate.timeIntervalSince(responseStartDate)
                
                print("DNS 解析耗时: \(dnsTime) seconds")
                print("TCP 连接时间: \(connectTime) seconds")
                print("TLS 握手时间: \(tlsTime) seconds")
                print("请求发送时间: \(requestTime) seconds")
                print("服务端处理时间: \(serverProcessingTime) seconds")
                print("服务器响应时间: \(responseTime) seconds")
            }
        }
    }
}


