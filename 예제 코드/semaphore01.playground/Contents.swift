import UIKit

//동시 작업 개수 제한
func semaphoreA(){
    let semophore = DispatchSemaphore(value: 3) //공유자원 접근 가능 수 설정
    let task = (0...10)
    
    task.forEach{ i in
        DispatchQueue.global().async{   //비동기 함수
            semophore.wait()    //변화량?
            //임계구역
            print("공유 자원 접근 시작\(i)")
            sleep(2)
            print("공유 자원 접근 종료\(i)")
            semophore.signal()
        }
    }
}









//두 스레드의 특정 이벤트 완료 상태 동기화
func semaphoreB(){
    
    let semaphore = DispatchSemaphore(value: 0) //세마포어 초기값 0으로 설정
    let task = ["A","B","C"]
    
    task.forEach { task in
        DispatchQueue.global().async {
            print("task \(task) 시작!")
            print("task \(task) 진행중..")
            print("task \(task) 끝!")
            semaphore.signal()
        }
        
        semaphore.wait()
        print("task \(task) 완료됨")
        print("            ")
    }
    
}

semaphoreB()

