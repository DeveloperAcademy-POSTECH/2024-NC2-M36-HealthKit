# 2024-NC2-M36-HealthKit
NC2 오전 팀36 스파크없는 시몬스파크팀~!

![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/920e6b88-96f2-4ce2-90a0-55d8adf1d116)

# 2024-NC2-M0-AugmentedReality
## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About Augmented Reality

### HealthKit
- **사용자의 개인 정보 보호 및 제어를 유지하면서 건강 및 피트니스 데이터에 접근 및 공유**
- Apple이 제공하는 Health Data 수집 및 관리 프레임워크
- 사용자들이 여러 건강 관련 앱과 기기에서 수집된 데이터를 하나의 중앙 집중식 데이터베이스에 저장하고 관리할 수 있도록 도와줌

### HealthKit의 데이터 유형
- Characteristic data (특성 데이터)
  - 생년월일, 혈액형, 성별, 피부유형과 같이 일반적으로 변경 되지 않는 항목
- Sample data (샘플 데이터)
  - 대부분의 사용자 건강 데이터 특정 시점의 데이터를 나타내는 데이터
- Workout data (운동 데이터)
  - 피트니스 및 운동 활동에 대한 데이터
- Source data (소스 데이터)
  - 데이터를 저장한 앱 또는 기기의 대한 정보가 포함
- Delete objects (삭제된 개체)
  - 삭제된 항목의 데이터의 uuid를 임시로 저장하는데 사용>
 
## 🎯 What we focus on?
- HealthKit의 활용..
  
  건강 데이터를 읽고 공유(쓰기)하는 기능에 집중!

  받아온 건강 데이터를 어떻게 활용할 것인가가 중요하다고 생각됨

- 건강 앱에 카페인을 기록할 수 있지만, 카페인의 함량을 직접 작성해야 함

<p align="center">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/947a90c4-66b9-481e-998f-29e157a7823e" width="196.5" height="426">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/8df0f5ab-767a-4d1c-b4f3-66644af81c0d" width="196.5" height="426">
  </p>

- 커피를 많이 마시는 사람들에게 카페인의 일일 권장량을 알려주어 과다 섭취를 방지
- 손쉽게 카페인 함량을 입력할 수 있도록 하자!

## 💼 Use Case
1. 건강 앱에 카페인 입력 칸도 모르는..
2. 알고 있어도 카페인의 함량을 조사하여 작성해야 해서 손이 안가는..
3. 카페인 일일 권장량도 몰라서 피곤할 때마다 마시는..

### <p align="center">카페인의 기록을 간편하게 해주어 과다 섭취의 위험을 알리자!</p>

## 🖼️ Prototype
<p align="center">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/3329e116-a248-4483-a845-7a22adb4a639" width="196.5" height="426">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/01cfa7f3-c5ff-42b4-a9a8-670df6d8f75d" width="196.5" height="426">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/08142c03-9a0b-4df0-9be6-eee17dce922a" width="196.5" height="426">
</p>
<p align="center">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/c3be3b7c-81be-48f4-8a04-fa484571e7e8" width="196.5" height="426">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/2af9f383-23a9-45f5-bae4-7ef4ba9de297" width="196.5" height="426">
  <img src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M36-HealthKit/assets/102645399/a0af1dff-3973-4f6e-94fb-078dd7f483bd" width="196.5" height="426">
</p>

## 🛠️ About Code

<pre>
  <code>
import HealthKit

// HealthKit 데이터 저장소 초기화
let healthStore = HKHealthStore()
  </code>
</pre>
- HealthKit 프레임워크를 사용하여 HealthKit 데이터 저장소를 사용

<pre>
  <code>
// 카페인 데이터 타입 정의
let caffeineType = HKQuantityType(.dietaryCaffeine)
// 읽기/쓰기 권한을 요청할 HealthKit 데이터 타입 집합
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
  </code>
</pre>
- 카페인 타입(.dietaryCaffeine)을 지정하고 읽기/쓰기 권한을 요청할 데이터 집합 생성
- HealthKit 데이터 저장소에 requestAuthorization으로 접근 권한을 요청(읽기/쓰기 전부)

<pre>
  <code>
func fetchTodayCaffeine(completion: @escaping (Int?) -> Void) {
    let caffeineType = HKQuantityType(.dietaryCaffeine)
    let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
    
    let query = HKStatisticsQuery(quantityType: caffeineType, quantitySamplePredicate: predicate) { _, result, error in
        guard let quantity = result?.sumQuantity(), error == nil else {
            print("error fetching today step data") // 데이터 요청 실패 시 에러 메세지 출력
            completion(nil)
            return
        }
        // 카페인 함량 mg 데이터 변환
        let caffeine = quantity.doubleValue(for: HKUnit.gramUnit(with: .milli))
        completion(Int(caffeine))
    }
    
    healthStore.execute(query) // 쿼리 실행
}
  </code>
</pre>
- 일일 카페인 함량만 받아올 예정 → 시작 날짜와 종료 날짜를 정해(하루) 조건자(predicate)를 생성
- 쿼리 수행으로 지정된 조건의 데이터를 반환

<pre>
  <code>
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
  </code>
</pre>
- 카페인 함량을 저장할 수 있는 샘플(카페인 단위, 저장하는 시간 등에 맞게)을 만들어
  HealthKit 데이터에 .save로 저장
