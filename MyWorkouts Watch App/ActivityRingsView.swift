//
//  ActivityRingsView.swift
//  MyWorkouts Watch App
//
//  Created by 정근호 on 11/28/25.
//

import SwiftUI
import HealthKit

struct ActivityRingsView: WKInterfaceObjectRepresentable { // WatchKit의 Activity Ring(WKInterfaceActivityRing)을 SwiftUI에서 사용 가능하도록 래핑

    let healthStore: HKHealthStore
    
    func makeWKInterfaceObject(context: Context) -> some WKInterfaceObject {
        let activityRingsObject = WKInterfaceActivityRing() // Activity Ring (WatchKit 전용 컴포넌트)
        
        // 오늘 날짜의 ActivitySummary만
        let calendar = Calendar.current
        var components = calendar.dateComponents([.era, .year, .month, .day], from: Date.now)
        components.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: components)
        
        let query = HKActivitySummaryQuery(predicate: predicate) { query, summaries, error in
            DispatchQueue.main.async {
                activityRingsObject.setActivitySummary(summaries?.first, animated: true)
            }
        }
        
        healthStore.execute(query) // HealthKit 쿼리 실행
        
        return activityRingsObject // Activity Ring 반환
    }
    
    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceObjectType, context: Context) {
        
    }
}

//#Preview {
//    ActivityRingsView()
//}
