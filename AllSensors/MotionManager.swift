//
//  MotionManager.swift
//  AllSensors
//
//  Created by Venkata K on 11/17/23.
//
import Foundation
import CoreMotion
import Combine
import UIKit

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var accelerometerData: (x: Double, y: Double, z: Double) = (x: 0.0, y: 0.0, z: 0.0)
    @Published var gyroData: (x: Double, y: Double, z: Double) = (x: 0.0, y: 0.0, z: 0.0)
    @Published var isCloseToUser: Bool = false
    private var altimeter = CMAltimeter()
    @Published var barometerPressure: Double = 0.0
    private var notificationSubscription: AnyCancellable?

    init() {
        motionManager.accelerometerUpdateInterval = 1/30 // 30 Hz
        motionManager.gyroUpdateInterval = 1/30 // 30 Hz
        startSensors()
        UIDevice.current.isProximityMonitoringEnabled = true
        observeProximityChanges()
    }

    private func startSensors() {
        // Accelerometer Data Collection
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data else { return }
                let newAccelerometerData = (x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z)
                self?.accelerometerData = newAccelerometerData
            }
        }
        
        // Gyroscope Data Collection
        if motionManager.isGyroAvailable {
            motionManager.startGyroUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data else { return }
                let newGyroData = (x: data.rotationRate.x, y: data.rotationRate.y, z: data.rotationRate.z)
                self?.gyroData = newGyroData
            }
        }
    }

    private func observeProximityChanges() {
        notificationSubscription = NotificationCenter.default.publisher(for: UIDevice.proximityStateDidChangeNotification)
            .map { _ in UIDevice.current.proximityState }
            .receive(on: RunLoop.main)
            .assign(to: \.isCloseToUser, on: self)
    }
    
    func startBarometerUpdates() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { [weak self] (altitudeData, error) in
                guard let altitudeData = altitudeData else { return }
                // Update the barometerPressure property with the new pressure value
                DispatchQueue.main.async {
                    self?.barometerPressure = altitudeData.pressure.doubleValue * 10.0 // hPa conversion if needed
                }
            }
        }
    }

    deinit {
        UIDevice.current.isProximityMonitoringEnabled = false
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
}
