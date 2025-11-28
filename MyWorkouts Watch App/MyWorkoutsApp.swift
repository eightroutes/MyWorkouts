//
//  MyWorkoutsApp.swift
//  MyWorkouts Watch App
//
//  Created by 정근호 on 11/28/25.
//

import SwiftUI

@main
struct MyWorkouts_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView, content: {
                SummaryView()
            })
            .environmentObject(workoutManager) // workoutManager 주입
        }
    }
}
