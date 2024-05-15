출제일 : 2024/05/11 (DAY 2) </br>
풀이일 : 2024/05/15 (DAY 3)

---

# [16678] 모독

https://www.acmicpc.net/problem/16678

> 출제자 : KUN </br>
> 풀이자 : NCookie

## 출제자 : KUN

### 코드
### 풀이

## 풀이자 : NCookie

### 코드
### 풀이

---

# [2751] 수 정렬하기 2

https://www.acmicpc.net/problem/2751

> 출제자 : NCookie </br>
> 풀이자 : KUN

## 출제자 : NCookie

### 코드
### 풀이

## 풀이자 : KUN

### 코드
### 풀이

---

# [24090] 퀵 정렬 1

https://www.acmicpc.net/submit/24090

> 출제자 : PCYSB </br>
> 풀이자 : Quarang

## 출제자 : PCYSB

### 코드
### 풀이

## 풀이자 : Quarang

### 코드
```swift
let input = readLine()!.split(separator: " ").map { Int($0)! }
let n = input[0]
var k = input[1]

var array = readLine()!.split(separator: " ").map { Int($0)! }
var result = (0, 0)
quickSort(array: &array, p: 0, r: n - 1)
k > 0 ? print(-1) : print(result.0, result.1)


func quickSort(array: inout [Int], p: Int, r: Int) {
    guard p < r else { return }
    let q = partition(array: &array, p: p, r: r)
    guard k >= 1 else { return }
    quickSort(array: &array, p: p, r: q - 1)
    guard k >= 1 else { return }
    quickSort(array: &array, p: q + 1, r: r)
}

func partition(array: inout [Int], p: Int, r: Int) -> Int {
    let x = array[r]
    var i = p - 1
    for j in p..<r {
        if array[j] <= x {
            i += 1
            array.swapAt(i, j)
            result = (array[i],array[j])
            k -= 1  //add
            if k < 1 { return 0 }   //add
        }
    }
    if i + 1 != r {
        array.swapAt(i + 1, r)
        result = (array[i+1],array[r])
        k -= 1  //add
    }
    return i + 1
}
```
### 풀이
```
해당 문제는 퀵정렬 방식 중 하나인 로무토 분할 알고리즘을 채택한 문제로
문제에서 퀵정렬함수와 파티션 함수가 주어지며, 배열의 길이 N과 교환 횟수K, 배열 A가 주어질때, 파티션 시 교환 되는 수 두개를 오름차순으로 출력하는 문제
시간 복잡도는 O(N logN) (최대 O(N^2))
```

> 로무토 분할 알고리즘이란?
- 퀵정렬은 분할 방법에 따라 호어,로무토 분할 방식이 존재
1. 피벗을 마지막배열의 요소로 지정
2. 문제의 의사코드 처럼 배열을 검사하는 변수와 피벗보다 작은 수를 설정할 변수 두개를 비교함
3. 루프를 돌면 평균적으로 중간 정도까지 왔을때  피벗보다 작은 수들은 왼쪽, 큰 수는 오른쪽으로 모이게 됨
4. 만약 중간 값이 여전히 피벗이 아니라면 원래 피벗이였던 마지막 요소와 중간 요소를 스왑하는 방식

> 로무토 알고리즘 채택 이유
- 애초에 이 문제는 로무토 사용을 강제하는 문제임
- 문제의 의사코드는 로무토를 나타내고 있고, 그 과정에서의 스왑된 수를 추출하는 문제이기 때문

> 문제 풀이
1. 따라서 기존 로무토 분할 알고리즘 함수와 퀵정렬 알고리즘 함수 두가지를 사용하고, 입력한 값을 기준삼아 스왑이 진행할 때마다 1씩 discount하는 식으로 진행
2. 퀵정렬 함수 내에서 k의 값을 주기적으로 검사해 불필요한 계산을 줄임
3. k의 값이 0보다 클 경우 루프를 다 돌아 스왑이 진행되었음에도 아직 남은 루프가 존재하기 때문에 (즉, 로무토알고리즘 횟수 <> 입력횟수) -1을 출력하고 아닐 경우 스왑한 수를 오름차순으로 출력


---

# [24092] 퀵 정렬 3

https://www.acmicpc.net/submit/24092

> 출제자 : Quarang </br>
> 풀이자 : PCYSB

## 출제자 : Quarang

### 코드
```swift
func quick3(){
    let n = Int(readLine()!)!
    var a = readLine()!.split(separator: " ").map { Int($0)! }
    let b = readLine()!.split(separator: " ").map { Int($0)! }
    var result = 0
    
    func quickSort(array: inout [Int], p: Int, r: Int) {
        guard p < r else { return }
        if result == 1 { return }
        let q = partition(array: &array, p: p, r: r)
        quickSort(array: &array, p: p, r: q - 1)
        quickSort(array: &array, p: q + 1, r: r)
    }
    
    func partition(array: inout [Int], p: Int, r: Int) -> Int {
        var lo = p
        var hi = r
        let q = array[r]
        
        while lo < hi {
            while lo < hi && array[lo] < q {  lo += 1 }
            while lo < hi && array[hi] >= q { hi -= 1 }
            array.swapAt(lo, hi)
            compareArray(array: &array)
        }
        array.swapAt(hi, r)
        compareArray(array: &array)
        return hi
    }
    func compareArray(array: inout [Int]) {
        guard array == b else { return }
        result = 1
    }
    
    compareArray(array: &a)
    quickSort(array: &a, p: 0, r: n - 1)
    print(result)
}
quick3()
```

### 풀이
```
해당 문제는 퀵정렬 방식 중 하나인 호어 분할 알고리즘을 채택한 문제로
문제에서 퀵정렬함수와 파티션 함수가 주어지지만, 파티션 분할 방식을 로무토로 할 필요가 없기 때문에 큰수와 작은 수를 번걸아가며 비교해 마지막에 스왑하는 호어 방식을 채택
시간 복잡도는 O(N logN) (최대 O(N^2))
```
> 호어 분할 알고리즘이란?
- 언급한대로 퀵정렬은 두가지 분할 방식이 있고 그중 하나가 호어방식임
1. 마지막 값을 피벗으로 설정하고 배열의 첫번째/마지막 요소를 기준으로 루프를 진행
2. 각각 루프를 실행 시켜 피벗과 비교해 작은값/큰값의 인덱스를 각각 수집
3. 작은 값과 큰값을 서로 스왑
4. 루프가 끝났다는 것은 이미 모두 옮겨진 상태라는 것이고, 큰값의 인덱스는 무조건 피벗보다 큰값이기 때문에 서로 교체하고 리턴

> 호어를 채택한 이유는?
- 문제의 의사 코드는 로무토를 나타내고 있지만, #24090 문제 처럼 스왑한 수를 추출할 필요도 없을 뿐더러 애초에 호어가 훨씬 효율적인 알고리즘임(대략 3배정도)
- 정렬이 어느정도 진행된 배열을 각기 다른 분할 방식으로 접근해보면 느낌이 옴
- swift기준으로 로무토 방식으로 짰을 때 45퍼센트에서 시간초과가 나는것 확임



## 풀이자 : PCYSB

### 코드
### 풀이

---