출제일 : 2024/05/11 (DAY 2) </br>
풀이일 : 2024/05/15 (DAY 3)

---

# [2751] 수 정렬하기 2

https://www.acmicpc.net/problem/2751

> 출제자 : NCookie </br>
> 풀이자 : KUN

## 출제자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();

        int n = Integer.parseInt(br.readLine());
        ArrayList<Integer> list = new ArrayList<>();

        for (int i = 0 ; i < n; i++) {
            list.add(Integer.parseInt(br.readLine()));
        }
        Collections.shuffle(list);

        quickSort(list, 0, n - 1);

        for (int i = 0 ; i < n; i++) {
            sb.append(list.get(i)).append("\n");
        }
        System.out.println(sb);
    }

    private static void quickSort(ArrayList<Integer> arr, int lo, int hi) {
        if (lo >= hi) {
            return;
        }

        int pivot = partition(arr, lo, hi);

        quickSort(arr, lo, pivot);
        quickSort(arr, pivot + 1, hi);
    }

    private static int partition(ArrayList<Integer> arr, int lo, int hi) {
        int mid = lo + (hi - lo) / 2;

        // 피벗으로 중간값 선택
        // int 값의 오버플로우를 대비하여 다음과 같이 수식을 구성함
        int pivot = arr.get(mid);
        lo--; hi++;

        while (lo <= hi) {
            do {
                lo++;
            } while (arr.get(lo) < pivot);

            do {
                hi--;
            } while (arr.get(hi) > pivot && lo <= hi);

            if (lo < hi) {
                swap(arr, lo, hi);
            } else {
                break;
            }
        }

        return hi;
    }

    private static void swap(ArrayList<Integer> arr, int i, int j) {
        int tmp = arr.get(i);
        arr.set(i, arr.get(j));
        arr.set(j, tmp);
    }
}
```

### 풀이

구현된 퀵 정렬은 가운데 피벗으로, 흔히 볼 수 있는 코드와 크게 다를 것이 없다. 다만 이 문제 같은 경우 퀵 정렬의 최악의 경우인 역정렬을 입력 데이터로 넣어두었기 때문에 시간 복잡도가 $O(n^2)$이 되는 경우가 발생한다. ([링크 참고](https://www.acmicpc.net/board/view/31887))

따라서 일반적인 방법으로는 이 문제를 퀵 정렬로 풀 수 없다. 대신 꼼수를 사용했다. 입력된 데이터를 랜덤으로 섞어서 최악의 경우를 의미 없게 만드는 것이다. (아주 낮은 확률로 섞은 이후 역정렬 데이터가 될 수도 있지만...) 이렇게 하면 정상적으로 문제 풀이에 성공한 것을 확인할 수 있다.


## 풀이자 : KUN

### 코드
```javascript
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

let input: number[] = []; // 입력값을 저장할 배열 선언

rl.on("line", function (line: any) {
  input.push(parseInt(line));
}).on("close", function () {
  input.shift();

  console.log(solution(input));
});

const solution = (input: number[]) => {
  return input.sort((a, b) => a - b).join(`\n`);
};
```

### 풀이
퀵정렬을 사용하지만 않았다면 정말 간단한 문제였다. 하지만 본코드에서도 볼 수 있듯이 난 결국 퀵정렬로 이문제를 푸는데 실패하였다. 

일단 이문제는 단순 퀵정렬로 풀려고하면 무조건 타임오버가 뜨도록 설계가 되어있다 이유는 
일단 들어오는 n 입력의 자릿수가 백만 이며 들어오는 입력중 단순 퀵정렬의 최악의 경우의 수인 이미 정렬되어있는 배열이나 역순 내림차순으로 정렬이 되어있는경우 시간 복잡도가 n제곱이 되며 타임오버가 난다. 
이를 해결하기위해 제출자에게도 힌트를 얻은결과로는 이미정렬되어있거나 역순정렬인 퀵정렬 저격의 배열을 타파하기위해 
1. 입력받은 배열을 랜덤으로 한번섞는다. (저격배열방지)
2. 퀵정렬의 피벗값을 배열의 중앙값 혹은 랜덤 방식으로 선택하여 진행한다.
3. 2중 피벗 퀵정렬이나 입력받은 배열이 일정 n개를 초과할시 다른 정렬알고리즘을 사용한다 예) 합정렬

이러한 방법들을 이용해 문제에 접근할수있지만 나는 2번방법까지 사용하고도 시간초과가 났다. 

예상하기로는 방법은 옳았으나 입력받은 배열을 랜덤으로 섞을때 sort 를 사용하거나 sort 를 사용하지않아도 
언어자체로 시간이 꽤나 소요가 되는것같다. 

그리고  윗코드처럼 sort로써 계산된 배열을 바로바로 출력하지않으면 
출력하는 출력부에서마져 정렬이 완료된 배열을 한줄씩 출력하기 위해서 for문을 한번더 돌려야하는점등을 뽑을수 있을겄같다. 

제출자에게 똥쓰래기 언어의 한계라는 말을듣고 시무룩해진 하루였다.

---

# [16678] 모독

https://www.acmicpc.net/problem/16678

> 출제자 : KUN </br>
> 풀이자 : NCookie

## 출제자 : KUN

### 코드
```javascript
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

let input: number[] = []; // 입력값을 저장할 배열 선언

rl.on("line", function (line: any) {
  input.push(parseInt(line));
}).on("close", function () {
  input.shift();
  input.sort((a, b) => a - b); //오름차순 정렬
  const answer = act(input);
  console.log(answer);
});

let Jaina = 0;

const act = (input: number[]) => {
  if (input[0] != 1) {
    Jaina += input[0] - 1;
    input[0] = 1;
  }

  for (let i = 1; i < input.length; i++) {
    if (input[i] > input[i - 1]) {
      Jaina += input[i] - input[i - 1] - 1;
      input[i] = input[i - 1] + 1;
    }
  }
  return Jaina;
};
```
### 풀이
일단 이문제를 이해하는데는 그렇게 어렵진 않았다. 문제지문이 길어서 그렇지 그렇게까지 난해한 설명은 아니었다고 생각한다. 
문제를 요약을 해보면 왕이 한번만 Defile 을 사용해 모든 국회의원을 없애고 싶어하고 이를 위해 최소한으로 필요한 해커 제이나의 수를 출력해주면 된다. 
이를 조건으로 바꿔서 생각하면
1. 입력받은 배열은 오름차순으로 정렬되어야만한다.
2. 모든 국회의원이 단 한번의 Defile로 전원탈락하기 위해선 배열의 최솟값은 1이여야 한다.
3. 모든 국회의원이 단 한번의 Defile로 전원탈락하기 위해선 배열이 오름차순으로 진행중일때 요소끼리의 차가 1 이 나거나 같은값이여야 한다.
### 이러한 조건을 충족시키는 루프문을 만들어 루프를 돌며 필요한 제이나의 수를 카운트 해주면된다. 그래서 코드를 차례차례 살펴 보자면
- 입력받은 배열을 sort 함수를 이용해 오름차순 정렬을 해주고
- 정렬된 배열을 act 함수에 집어넣어 배열의 첫인덱스 = 최솟값이 1인지 확인을 한다음 만약 1이 아니라면 차이값을 구하여 jaina 카운트에 더해주고 배열의 첫인덱스를 1로 바꾸어 준다.
- 첫자리는 1이기에 인덱스 1번부터 루프를 돌며 현인덱스(i) 와 전인덱스 (i - 1) 을 비교해 그차이값만큼 jaina 카운터에 더해준다.
- 루프가 끝이나면 jaina 카운터를 리턴한다.  

## 풀이자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int n = Integer.parseInt(br.readLine());
        int[] arr = new int[n];

        for (int i = 0; i < n; i++) {
            arr[i] = Integer.parseInt(br.readLine());
        }
        
        // 정렬
        quickSort(arr, 0, n - 1);

        // 명예 점수들을 오름차순으로 정렬했을 때 첫 번째 명예 점수는 반드시 1이어야 함
        long hackers = arr[0] - 1;
        arr[0] = 1;

        /*
         * 한 번의 Defile 프로젝트 실행만으로 모든 국회의원을 없애려면
         * 명예 점수를 오름차순으로 정렬했을 때
         * 이전 명예 점수와 같거나 1만큼 커야 한다.
         */
        for (int i = 1; i < n; i++) {
            if (arr[i] - arr[i - 1] > 1) {
                int next = arr[i - 1] + 1;  // 현재 위치에 들어갈 명예 점수

                hackers += arr[i] - next;
                arr[i] = next;
            }
        }

        System.out.println(hackers);
    }

    private static void quickSort(int[] arr, int lo, int hi) {
        if (lo >= hi) {
            return;
        }
        
        int pivot = partition(arr, lo, hi);
        
        quickSort(arr, lo, pivot - 1);
        quickSort(arr, pivot + 1, hi);
    }
    
    private static int partition(int[] arr, int lo, int hi) {
        int pivotIndex = lo + (hi - lo) / 2;
        int pivot = arr[pivotIndex];
        
        // 피벗값을 가장 오른쪽으로 이동
        swap(arr, pivotIndex, hi);

        int i = lo;
        for (int j = lo; j < hi; j++) {
            if (arr[j] < pivot) {
                swap(arr, i, j);
                i++;
            }
        }

        swap(arr, i, hi);
        return i;
    }
    
    private static void swap(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
```

### 풀이

왕은 단 1번의 "Defile" 프로젝트 실행을 통해 모든 국회의원을 없애려고 한다. 프로젝트 내용은 다음과 같다.

```
 1. 모든 국회의원을 모독해서 각각의 명예 점수를 1씩 감소시킨다.
 2. (1)로 인해 1명이라도 국회의원에서 박탈당한 사람이 발생했다면 국민들의 분노를 이용해 (1)로 돌아간다.
 3. (1)에 의해 국회의원에서 박탈당한 사람이 없다면 프로젝트를 종료한다.
```

프로젝트를 한 번만 수행하기 위해서는 명예 점수들을 **오름차순으로 정렬**했을 때 이전의 명예 점수와 같거나 1만큼 커야한다. 이렇게 해야 프로젝*트를 *실행했을 때 도미노처럼 연쇄작용으로 모든 국회의원을 없앨 수 있다.

예를 들어보자.
1. 입력 값으로 7 3 6 2 4가 들어왔다. (arr : `[7, 3, 6, 2, 4]`)
2. 정렬하면 2 3 4 6 7이 된다. (arr : `[2, 3, 4, 6, 7]`)
3. 가장 작은 명예 점수는 반드시 1이어야 한다. (arr : `[1, 3, 4, 6, 7]`, hackers = `1`)
4. 명예 점수는 앞의 명예 점수보다 1만큼 크거나 같아야 한다. 3이 2가 되기 위해서는 해커가 한 명 더 필요하다. (arr : `[1, 2, 4, 6, 7]`, hackers = 2)
5. 4는 2보다 크므로 명예 점수 3이 되어야 한다. (arr : `[1, 2, 3, 6, 7]`, hackers = 3)
6. 이를 반복한다.
7. 최종적으로 명예 점수는 1 2 3 4 5와 같은 형태가 된다. (arr : `[1, 2, 3, 4, 5]`, hackers = 7)

---

# [24090] 알고리즘 수업 - 퀵 정렬 1

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

# [24092] 알고리즘 수업 - 퀵 정렬 3

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
