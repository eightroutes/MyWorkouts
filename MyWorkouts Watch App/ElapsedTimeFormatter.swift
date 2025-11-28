//
//  ElapsedTimeFormatter.swift
//  MyWorkouts Watch App
//
//  Created by 정근호 on 11/28/25.
//

import Foundation

/// 시간을 "MM:SS" + ".ss"초 형태로 변환
class ElapsedTimeFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second] // 분, 초만
        formatter.zeroFormattingBehavior = .pad // 0패딩 추가 - 항상 두자리(01) 유지
        return formatter
    }()
    var showSubseconds = true
    
    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else { return nil }
        guard let formattedString = componentsFormatter.string(from: time) else { return nil }
        
        if showSubseconds {
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100) // 1로나눴을때나머지(소수부분) * 100
            let decimalSeparator = Locale.current.decimalSeparator ?? "." // 소수점
            return "\(formattedString)\(decimalSeparator)\(String(format: "%02d", hundredths))"
//            return String(format: "%@%@%0.2d", formattedString, decimalSeparator, hundredths)
        }
        return formattedString
    }
}
