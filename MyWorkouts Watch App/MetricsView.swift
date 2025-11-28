//
//  MetricsView.swift
//  MyWorkouts Watch App
//
//  Created by 정근호 on 11/28/25.
//

import SwiftUI

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        VStack(alignment: .leading) {
            ElapsedTimeView(
                elapsedTime: workoutManager.builder?.elapsedTime ?? 0,
                showSubseconds: true
            )
                .foregroundStyle(.yellow)
                .fontWeight(.semibold)
            Text(
                Measurement(
                    value: workoutManager.activeEnergy,
                    unit: UnitEnergy.kilocalories
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .workout,
//                        numberFormat: .numeric(precision(.fractionLength(0)))
                        numberFormatStyle: .number.precision(.fractionLength(0)) // 소수점 이하의 자릿수를 0으로 지정 -> 정수만 표시
                    )
                )
            )
            Text(
                workoutManager.heartRate
                    .formatted(
                        .number.precision(.fractionLength(0))
                    ) + " bpm"
            )
            Text(
                Measurement(
                    value: workoutManager.distance,
                    unit: UnitLength.meters
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .road)
                )
                
            )
        }//VStack
        .font(.system(.title, design: .rounded)
            .monospacedDigit()
            .lowercaseSmallCaps()
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .bottom)
        .scenePadding()
    }
}

#Preview {
    MetricsView()
        .environmentObject(WorkoutManager())
}
