//
//  HealthManager.swift
//  CaffeineEstimate
//
//  Created by Simmons on 6/12/24.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    
    // HealthKit 데이터 저장소 초기화
    let healthStore = HKHealthStore()
    
    init() {
        // 카페인 데이터 타입 정의
        let caffeineType = HKQuantityType(.dietaryCaffeine)
        // 읽기 권한을 요청할 HealthKit 데이터 타입 집합
        let healthTypesToRead: Set = [caffeineType]
        let healthTypesToShare: Set = [caffeineType]
        
        // 비동기적으로 HealthKit 데이터 접근 권한 요청
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: healthTypesToShare, read: healthTypesToRead)
                // 여기에 스플래시 -> 홈 화면 넘어가는 거 구현
            } catch {
                print("error fetching health data") // 권한 요청 실패 시 에러 메세지 출력
            }
        }
    }
    
//    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
//        // 카페인 데이터 타입 정의
//        let caffeines = HKQuantityType(.dietaryCaffeine)
//        // 읽기 권한을 요청할 HealthKit 데이터 타입 집합
//        let healthTypes: Set = [caffeines]
//        
//        // 비동기적으로 HealthKit 데이터 접근 권한 요청
//        healthStore.requestAuthorization(toShare: [], read: healthTypes) { success, error in
//            if success {
//                print("Health data access granted")
//            } else {
//                print("Health data access denied")
//            }
//            completion(success, error)
//        }
//    }
    
    func fetchTodayCaffeine(completion: @escaping (Int?) -> Void) {
        // 카페인 데이터 타입 정의
        let caffeineType = HKQuantityType(.dietaryCaffeine)
        // HKQuery: HealthKit의 모든 쿼리 클래스에 대한 추상클래스 -> 항상 구체적인 하위 클래스 중 하나를 사용하여 작업('.'을 쓰라는 듯)
        // predicateForSamples: 시작 날짜와 종료 날짜가 지정된 시간 간격 내에 속하는 샘플에 대한 조건자를 반환
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        // HKStatisticsCollectionQuery: 고정 길이 시간 간격에 걸쳐 여러 통계 쿼리를 수행
        // quantityType: 검색할 샘플 유형 -> HKQuantityType(.stepCount)이 들어감
        // quantitySamplePredicate: 쿼리에서 반환되는 결과를 제한하는 조건자 -> 위에 설정한 조건이 들어감
        let query = HKStatisticsQuery(quantityType: caffeineType, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today step data") // 데이터 요청 실패 시 에러 메세지 출력
                completion(nil)
                return
            }
            // 카페인 함량 mg 데이터 변환
            let caffeine = quantity.doubleValue(for: HKUnit.gramUnit(with: .milli))
            print(type(of: caffeine)) // 카페인 함량 출력
            completion(Int(caffeine))
        }
        
        healthStore.execute(query) // 쿼리 실행
    }
    
    func saveCaffeine(caffeineAmount: Double) {
        // 카페인 데이터 타입 정의
        let caffeineType = HKQuantityType(.dietaryCaffeine)
        // 카페인 섭취량을 나타내는 HealthKit 수량 객체 생성
        let caffeineQuantity = HKQuantity(unit: HKUnit.gramUnit(with: .milli), doubleValue: caffeineAmount)
        // 샘플 생성
        let caffeineSample = HKQuantitySample(type: caffeineType, quantity: caffeineQuantity, start: Date(), end: Date())
        
        // 데이터 저장
        healthStore.save(caffeineSample) { success, error in
            if let error = error {
                print("Error saving caffeine intake: \(error.localizedDescription)")
            } else {
                print("Successfully saved caffeine intake.")
            }
        }
    }
}

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date()) // 오늘 날짜의 시작 시간 반환
    }
}
