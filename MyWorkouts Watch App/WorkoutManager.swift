//
//  WorkoutManager.swift
//  MyWorkouts Watch App
//
//  Created by 정근호 on 11/28/25.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject {
    var selectedWorkout: HKWorkoutActivityType? {
        didSet {
            guard let selectedWorkout else { return }
            // selectedWorkout 세팅 시 nil이 아니면 운동 바로 시작
            startWorkout(workoutType: selectedWorkout)
        }
    }
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    /// 정해진 workoutType으로 운동 시작
    func startWorkout(workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(
                healthStore: healthStore,
                configuration: configuration
            )
        } catch {
            return
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
        )
        
        // Workout Session 시작, Data 수집 시작
        let startDate = Date.now
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
            // Workout 시작
        }
    }
}
