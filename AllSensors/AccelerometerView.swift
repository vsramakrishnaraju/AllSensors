//
//  AccelerometerView.swift
//  AllSensors
//
//  Created by Venkata K on 11/18/23.
//

import Foundation
import SwiftUI

struct AccelerometerView: View {
    var accelerometerData: (x: Double, y: Double, z: Double)
    
    private func normalizedValue(_ value: Double) -> CGFloat {
        // Normalize the accelerometer value to a range that fits the view. This will depend on your specific use case.
        // You may need to adjust the multiplier based on the expected range of your accelerometer data.
        return CGFloat(value) * 50 // Example multiplier
    }

    var body: some View {
        VStack {
            Text("Accelerometer")
                .font(.headline)

            HStack {
                VStack {
                    Text("X")
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 50, height: normalizedValue(accelerometerData.x))
                }
                VStack {
                    Text("Y")
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 50, height: normalizedValue(accelerometerData.y))
                }
                VStack {
                    Text("Z")
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 50, height: normalizedValue(accelerometerData.z))
                }
            }
        }
    }
}

