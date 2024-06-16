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
        // 걸음 수 데이터 타입 정의
        let steps = HKQuantityType(.dietaryCaffeine)
        // 읽기 권한을 요청할 HealthKit 데이터 타입 집합
        let healthTypes: Set = [steps]
        
        // 비동기적으로 HealthKit 데이터 접근 권한 요청
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("error fetching health data") // 권한 요청 실패 시 에러 메세지 출력
            }
        }
    }
    
    func fetchTodaySteps() {
        // 걸음 수 데이터 타입 정의
        let steps = HKQuantityType(.stepCount)
        // 오늘 하루의 데이터만 가져오는 조건 설정
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("error fetching today step data") // 데이터 요청 실패 시 에러 메세지 출력
                return
            }
            // 걸음 수 데이터 변환
            let stepCount = quantity.doubleValue(for: .count())
            print(stepCount) // 걸음 수 출력
        }
        
        healthStore.execute(query) // 쿼리 실행
    }
    
    func fetchWeekSteps() {
        var interval = DateComponents()
        interval.day = 1 // 하루 단위로 데이터를 집계
        
        // 걸음 수 데이터 타입 정의
        let steps = HKQuantityType(.stepCount)
        // 지난 일주일간의 데이터만 가져오는 조건 설정
        let predicate = HKQuery.predicateForSamples(withStart: .weekOfDay, end: Date(), options: .strictStartDate)
        let query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: .startOfDay, intervalComponents: interval)
        
        query.initialResultsHandler = { query, results, error in
            guard let results = results, error == nil else {
                print("error fetching weekly step data") // 데이터 요청 실패 시 에러 메시지 출력
                return
            }
            
            results.enumerateStatistics(from: .weekOfDay, to: Date()) { statistics, stop in
                if let quantity = statistics.sumQuantity() {
                    let stepCount = quantity.doubleValue(for: .count()) // 걸음 수 데이터 변환
                    print("Date: \(statistics.startDate), Steps: \(stepCount)") // 날짜별 걸음 수 출력
                }
            }
        }
        
        healthStore.execute(query) // 쿼리 실행
    }
    
    func fetchAllSteps() {
        // 걸음 수 데이터 타입 정의
        let steps = HKQuantityType(.dietaryCaffeine)
    
        var interval = DateComponents()
        interval.day = 1 // 하루 단위로 데이터를 집계
        
        fetchFirstDataDate(for: steps) { startDate in // 첫 번째 데이터 날짜를 가져오는 비동기 작업
            guard let startDate = startDate else {
                print("No data available") // 데이터가 없을 경우 메시지 출력
                return
            }
            
            // 현재 날짜를 종료 날짜로 설정
            let endDate = Date()
            // 전체 기간의 데이터만 가져오는 조건 설정
            // HKQuery: HealthKit의 모든 쿼리 클래스에 대한 추상클래스 -> 항상 구체적인 하위 클래스 중 하나를 사용하여 작업('.'을 쓰라는 듯)
            // predicateForSamples: 시작 날짜와 종료 날짜가 지정된 시간 간격 내에 속하는 샘플에 대한 조건자를 반환
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
            
            // HKStatisticsCollectionQuery: 고정 길이 시간 간격에 걸쳐 여러 통계 쿼리를 수행
            // quantityType: 검색할 샘플 유형 -> HKQuantityType(.stepCount)이 들어감
            // quantitySamplePredicate: 쿼리에서 반환되는 결과를 제한하는 조건자 -> 위에 설정한 조건이 들어감
            // options: 수행되는 통계 계산 유형과 여러 소스의 데이터가 병합되는 방식을 정의 -> cumulativeSum이란 샘플의 모든 수량의 합계를 계산한다는 뜻
            // anchorDate: 시간 간격의 시작 시간을 설정 -> 자정(?)을 기준으로 설정
            // intervalComponents: 고정 길이 시간을 정의 -> interval은 하루 단위로 데이터를 집계
            let query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: .startOfDay, intervalComponents: interval)
            
            // 쿼리의 초기 결과에 대한 결과 핸들러
            query.initialResultsHandler = { query, results, error in
                // results는 HKStatisticsCollectionQuery의 결과
                guard let results = results, error == nil else {
                    print("error fetching step data: \(error?.localizedDescription ?? "unknown error")") // 데이터 요청 실패 시 에러 메시지 출력
                    return
                }
                
                // 시작 날짜부터 종료 날짜까지 모든 시간 간격에 대한 통계 개체를 열거 -> 지정된 기간 동안의 걸음 수 데이터를 날짜별로 출력
                // statistics: 각 시간 간격(하루)의 통계 데이터, stop: 반복을 중단하는 데 사용
                results.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                    if let quantity = statistics.sumQuantity() { // 쿼리와 일치하는 모든 샘플의 합계를 반환
                        let stepCount = quantity.doubleValue(for: HKUnit.gramUnit(with: .milli)) // 걸음 수 데이터 변환
                        print("Date: \(statistics.startDate), Steps: \(stepCount)") // 날짜별 걸음 수 출력
                    }
                }
            }
            // 쿼리 실행 (없으면 동작안됨 ㅜ)
            // healthStore는 HealthKit의 데이터를 관리하고 접근하는데 사용하며, execute로 쿼리를 실행
            self.healthStore.execute(query)
        }
    }
    
    private func fetchFirstDataDate(for quantityType: HKQuantityType, completion: @escaping (Date?) -> Void) {
        // NSSortDescriptor: 비교할 속성의 키 경로와 정렬 순서를 지정하여 인스턴스를 구성
        // HKSampleSortIdentifierStartDate: 시작 날짜를 기준으로 샘플을 정렬하는 상수
        // ascending: true -> 오름차순 정렬
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true) // 데이터 정렬을 위한 정렬자 정의
        // HKSampleQuery: 현재 HealthKit스토어에 저장된 데이터(모든 샘플의 스냅샷)를 반환하는 일반 쿼리
        // sampleType: 쿼리할 샘플 지정 -> 여기서는 걸음 수가 되는 거임(HKQuantityType(.stepCount))
        // predicate: 샘플을 필터링하기 위한 조건 -> nil을 사용한 이유는 모든 샘플을 포함하도록!
        // limit: 반환할 샘플의 최대 개수를 지정 -> 1로 설정한 것은 가장 오래된 샘플 하나만 반환한다는 것(처음 기록된 시점의 샘플을 반환.. 걸음 수니까 핸드폰 처음 사고 건강앱 활성화한 시기?)
        // sortDescriptors: 샘플을 정렬하기 위한 정렬자 -> 위에서 정의한 sortDescriptor를 사용하여 정렬(시작 날짜 기준으로 오름차순 정렬)
        let sampleQuery = HKSampleQuery(sampleType: quantityType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { query, samples, error in
            guard let firstSample = samples?.first as? HKQuantitySample else {
                completion(nil) // 첫 번째 데이터가 없을 경우 nil 반환
                return
            }
            completion(firstSample.startDate) // 첫 번째 데이터의 시작 날짜 반환
        }
        
        healthStore.execute(sampleQuery) // 쿼리 실행
    }
}

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date()) // 오늘 날짜의 시작 시간 반환
    }
    
    static var weekOfDay: Date {
        Calendar.current.date(byAdding: .day, value: -7, to: Date())! // 일주일 전 날짜 반환
    }
}
