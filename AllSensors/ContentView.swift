//
//  ContentView.swift
//  AllSensors
//
//  Created by Venkata K on 11/17/23.
//
import SwiftUI
import CoreMotion

struct ContentView: View {
    @StateObject var motionManager = MotionManager()
    @State private var isDarkModeEnabled: Bool = false  // Define the state variable here
    
    var body: some View {
        VStack {
            Text("Sensor Data")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            AccelerometerView(accelerometerData: motionManager.accelerometerData)
                            .padding()
                            .background(Color(UIColor.systemGroupedBackground))
                            .cornerRadius(12)
                            .shadow(radius: 5)

            GyroscopeView(gyroData: motionManager.gyroData)
                            .padding()
                            .background(Color(UIColor.systemGroupedBackground))
                            .cornerRadius(12)
                            .shadow(radius: 5)
            
            VStack {
                Label {
                    Text("Barometer")
                    Text("\(motionManager.barometerPressure, specifier: "%.2f") hPa")
                        .font(.title)
                } icon: {
                    Image(systemName: "barometer")
                        .foregroundColor(.purple) // Choose color as needed
                }
            }
            .padding()
            .background(Color.purple.opacity(0.1))
            .cornerRadius(10)
            .padding(.vertical)
            
            VStack {
                Label {
                    Text("Proximity")
                    Text(motionManager.isCloseToUser ? "Near" : "Far")
                        .font(.title)
                } icon: {
                    Image(systemName: motionManager.isCloseToUser ? "person.fill.viewfinder" : "viewfinder")
                        .foregroundColor(motionManager.isCloseToUser ? .red : .gray)
                }
            }
            .padding()
            .background(Color.red.opacity(0.1))
            .cornerRadius(10)
            .padding(.vertical)
            
            Toggle("Ambient Light Sensor", isOn: $isDarkModeEnabled)
                .padding()
                .background(isDarkModeEnabled ? Color.gray.opacity(0.1) : Color.yellow.opacity(0.1))
                .cornerRadius(10)
                .padding(.vertical)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isDarkModeEnabled ? Color.black : Color(UIColor.systemBackground)) // Changed this line
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        
    }
}


struct SensorDataView: View {
    var title: String
    var data: (x: Double, y: Double, z: Double)
    var icon: String
    var color: Color
    
    var body: some View {
        VStack {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundColor(color)
            Text("X: \(data.x, specifier: "%.2f")")
            Text("Y: \(data.y, specifier: "%.2f")")
            Text("Z: \(data.z, specifier: "%.2f")")
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
