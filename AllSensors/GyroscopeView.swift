//
//  GyroscopeView.swift
//  AllSensors
//
//  Created by Venkata K on 11/18/23.
//

import Foundation
import SwiftUI

struct GyroscopeView: View {
    var gyroData: (x: Double, y: Double, z: Double)
    
    private func normalizedAngle(_ value: Double) -> Angle {
        // Normalize the gyroscope value to an angle.
        // You may need to adjust the conversion based on the expected range of your gyroscope data.
        return Angle(degrees: value * 360 / (2 * .pi))
    }
    
    var body: some View {
        VStack {
            Text("Gyroscope")
                .font(.headline)
            
            HStack {
                VStack {
                    Text("Pitch")
                    Circle()
                        .trim(from: 0, to: 0.5) // Half circle to represent 180 degrees of rotation
                        .stroke(Color.red, lineWidth: 10)
                        .frame(width: 50, height: 50)
                        .rotationEffect(normalizedAngle(gyroData.x))
                }
                VStack {
                    Text("Roll")
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(Color.green, lineWidth: 10)
                        .frame(width: 50, height: 50)
                        .rotationEffect(normalizedAngle(gyroData.y))
                }
                VStack {
                    Text("Yaw")
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(Color.blue, lineWidth: 10)
                        .frame(width: 50, height: 50)
                        .rotationEffect(normalizedAngle(gyroData.z))
                }
            }
        }
    }
}
