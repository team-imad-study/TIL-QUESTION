출제일 : 2024/04/29 (DAY 0) </br>
풀이일 : 2024/05/03 (DAY 1)

---

# [백준][2750번] 수 정렬하기

> 출제자 : KUN </br>
> 풀이자 : NCookie

https://www.acmicpc.net/problem/2750
## 출제자 : KUN
### 코드

```javascript
const readline = require("readline");

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let input = [];

rl.on("line", function(line) {
    input.push(parseInt(line));
}).on("close", function() {
    input.shift(); // 첫 번째 요소를 제거
    const sortedArr = selectionSort(input); // 정렬된 배열을 반환
    sortedArr.forEach(item => console.log(item)); // 정렬된 배열을 한 줄씩 출력
});

const findSmallest = (input) => {
    let smallest = input[0];
    let smallestIndex = 0;
    for (let i = 1; i < input.length; i++) {
        if (input[i] < smallest) {
            smallest = input[i];
            smallestIndex = i;
        }
    }
    return smallestIndex;
};

const selectionSort = (input) => {
    const sortedArr = [];
    const inputLength = input.length;
    for (let i = 0; i < inputLength; i++) {
        const smallestIndex = findSmallest(input);
        sortedArr.push(input.splice(smallestIndex, 1)[0]);
    }
    return sortedArr;
};

```

### 풀이

입력의 첫번째 요소는 배열의 총 길이로써 정렬에 필요없는 요소이기에 

```javascript
input.shift(); // 첫 번째 요소를 제거
```
해당코드를 사용해 지워준다. 배열을 사용하는 많은 문제들이 첫번째요소로 이러한 총길이를 주는경우가 많으니 다음에도 다시 사용할것!

간단한 문제이기에 설명할거리가 별로없지만 순서대로 따라가면서 알아보자면 

```javascript
const findSmallest = (input) => {
    let smallest = input[0];
    let smallestIndex = 0;
    for (let i = 1; i < input.length; i++) {
        if (input[i] < smallest) {
            smallest = input[i];
            smallestIndex = i;
        }
    }
    return smallestIndex;
};
```

해당코드의 첫번째 함수부분이다 이함수에선 smallest 즉 최소값과 smallistIndex 최소값의 인덱스 값을 각각 0번째요소와 0으로 초기설정을 해주고있다 
그후 반복되는 루프문에선 루프를 돌며 input의 i번째요소와 smallest 를 비교해 해당스텝의 smallest값보다 작다면 
smallest 값과 smallestIndex를 재설정해준다 그리고 smallestIndex값을 출력해준다.

```javascript
const selectionSort = (input) => {
    const sortedArr = [];
    const inputLength = input.length;
    for (let i = 0; i < inputLength; i++) {
        const smallestIndex = findSmallest(input);
        sortedArr.push(input.splice(smallestIndex, 1)[0]);
    }
    return sortedArr;
};
```
해당코드의 두번째 함수부분이다 이함수에선 정렬된 배열을 출력하기위해 sortedArr 이라는 배열을 빈배열로 하나 만들어내고 
루프문을 돌며 각스탭마다 실행된 첫번째함수의 출력값을 sortedArr에 하나씩 추가하여준다.

## 풀이자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();

        int n = Integer.parseInt(br.readLine());
        int[] arr = new int[n];

        for (int i = 0 ; i < n; i++) {
            arr[i] = Integer.parseInt(br.readLine());
        }

        // 선택 정렬
        for (int i = 0; i < n; i++) {
            int minIndex = i;
            for (int j = i; j < n; j++) {
                if (arr[j] < arr[minIndex]) {
                    minIndex = j;
                }
            }

            int tmp = arr[i];
            arr[i] = arr[minIndex];
            arr[minIndex] = tmp;

            sb.append(arr[i]).append("\n");
        }

        System.out.println(sb);
    }
}
```

### 풀이

첫 번째 줄에서 n을 받고, n번만큼 루프를 돌며 입력 데이터를 읽어온다.

이후 입력 데이터가 저장된 배열을 선택 정렬을 사용해 오름차순으로 정렬한다. 선택 정렬은 주어진 리스트에서 최소값을 찾고, 이를 맨 앞에 위치한 값을 교체하는 것을 반복하는 제자리 정렬 알고리즘 중 하나이다.

이를 구현하기 위해 2중 for문을 사용했으며, 따라서 위 프로그램의 시간복잡도는 $O(n^2)$이다.

---

# [백준][28116번] 선택 정렬의 이동 거리

> 출제자 : NCookie </br>
> 풀이자 : KUN

https://www.acmicpc.net/problem/28116

## 출제자 : NCookie
### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;


public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st;
        StringBuilder sb = new StringBuilder();

        int N = Integer.parseInt(br.readLine());

        // 각 숫자가 몇 번째 인덱스에 있는지 저장하고 있는 배열
        // Ex) [1, 3, 5, 2, 4]를 입력으로 받았을 때
        // idxArr[1]에는 1, [2]에는 4, [3]에는 2, [4]에는 5, [5]에는 3이 저장됨
        int[] idxArr = new int[N + 1];

        // 수열 A를 저장하고 있는 배열
        int[] numArr = new int[N + 1];

        // 각 숫자의 이동거리를 저장하는 배열
        int[] answer = new int[N + 1];

        st = new StringTokenizer(br.readLine());
        for (int i = 1; i <= N; i++) {
            int num = Integer.parseInt(st.nextToken());
            idxArr[num] = i;
            numArr[i] = num;
        }

        // 수열 A는 1부터 N까지 있으므로 1부터 시작
        for (int i = 1; i <= N; i++) {
            // 현재 최소값이 와야하는 위치의 값이 최소값이 아닌 경우
            if (numArr[i] != i) {
                // 정렬되지 않은 부분의 최소값이 저장된 위치
                int minIndex = idxArr[i];

                // 최소값이 저장된 위치와 현재 정렬하려는 위치 간의 거리
                int distance = minIndex - i;

                // 이동한 값들의 숫자에 거리 추가
                answer[numArr[i]] += distance;
                answer[numArr[minIndex]] += distance;

                // 선택 정렬에서 정렬된 부분까지는(배열의 인덱스 i까지) 더 이상 사용하지 않기 때문에
                // 값을 스왑하지 않고 인덱스 값을 대입해주기만 함
                idxArr[numArr[i]] = idxArr[i];
                numArr[minIndex] = numArr[i];
            }

            sb.append(answer[i]).append(' ');
        }

        System.out.println(sb);
    }
}
```

### 풀이

이 문제 풀이의 핵심은 다음과 같다.

1. 수열 A에는 1부터 N까지의 정수가 중복되지 않고 한 번씩 등장한다.
2. 따라서 선택 정렬의 과정에서 다음으로 와야할 최소값을 알 수 있다.

**입력**

위의 내용을 응용하여 문제를 풀기 위해서 두 개의 배열을 생성한다. 참고로 직관적으로 배열의 인덱스와 입력값을 매칭시키기 위해 배열 크기를 N + 1로 설정했다. (모든 배열의 0번방은 쓰지 않는다.)

- `numArr[n + 1]` : 수열 A를 저장하고 있는 배열
- `idxArr[n + 1]`
  - $A_i$가 저장된 위치를 저장하고 있는 배열
  - 이 배열은 양의 정수 $A_i$번째 방에, $A_i$가 `numArr`에 저장된 위치를 저장한다.
  - 만약 이 배열을 맵이나 딕셔너리로 대체하려면 key에는 $A_i$를, value에는 $A_i$가 `numArr`에 저장된 위치를 저장한다.

따라서 데이터 입력 시 두 배열의 초기화는 이렇게 이루어진다.

```java
// 각 숫자가 몇 번째 인덱스에 있는지 저장하고 있는 배열
// Ex) [1, 3, 5, 2, 4]를 입력으로 받았을 때
// idxArr[1]에는 1, [2]에는 4, [3]에는 2, [4]에는 5, [5]에는 3이 저장됨
int[] idxArr = new int[N + 1];

// 수열 A를 저장하고 있는 배열
int[] numArr = new int[N + 1];

// 각 숫자의 이동거리를 저장하는 배열
int[] answer = new int[N + 1];

st = new StringTokenizer(br.readLine());
for (int i = 1; i <= N; i++) {
    int num = Integer.parseInt(st.nextToken());
    idxArr[num] = i;
    numArr[i] = num;
}
```

**정렬 및 루프**

**선택 정렬**은 루프를 돌면서 배열의 현재 인덱스에 정렬되지 않은 값들 중 최소값이 와야한다. 그리고 이 문제에서는 현재 인덱스와 최소값이 위치한 인덱스의 차이를 구해야 하는거고.

만약 선택정렬을 직접 구현하게 되면 for문 두 개를 중첩해서 사용해야 한다. 따라서 시간복잡도는 $O(n^2)$가 된다. 해당 문제는 입력 데이터의 길이인 N이 굉장히 크기 때문에 $O(n^2)$ 정도의 시간이면 `시간 초과`가 발생하는 것 같다.

여기서 우리는 배열을 순회하면서 현재 인덱스에 어떤 값이 와야하는지 알 수 있고, 그 값의 위치도 알고 있다. 왜냐? $A_i$는 1부터 N까지의 모든 양의 정수가 중복되지 않고 꼭 한 번씩 등장하기 때문이다. 이들의 위치를 저장하고 있는 배열(맵 또는 딕셔너리)도 만들었고.

그래서 위 내용을 구현하자면 다음과 같다.

```java
// 수열 A는 1부터 N까지 있으므로 1부터 시작
for (int i = 1; i <= N; i++) {
    // 현재 최소값이 와야하는 위치의 값이 최소값이 아닌 경우
    if (numArr[i] != i) {
        // 정렬되지 않은 부분의 최소값이 저장된 위치
        int minIndex = idxArr[i];

        // 최소값이 저장된 위치와 현재 정렬하려는 위치 간의 거리
        int distance = minIndex - i;

        // 이동한 값들의 숫자에 거리 추가
        answer[numArr[i]] += distance;
        answer[numArr[minIndex]] += distance;

        // 선택 정렬에서 정렬된 부분까지는(배열의 인덱스 i까지) 
        // 더 이상 사용하지 않기 때문에
        // 값을 스왑하지 않고 인덱스 값을 대입해주기만 함
        idxArr[numArr[i]] = idxArr[i];
        numArr[minIndex] = numArr[i];
    }

    sb.append(answer[i]).append(' ');
}

System.out.println(sb);
```

## 풀이자 : KUN

### 코드

### 풀이

---

> 출제자 : Quarang </br>
> 풀이자 : PCYSB

# [백준][23882번] - 선택 정렬 2

https://www.acmicpc.net/problem/23882

## 출제자 : Quarang

### 코드
```swift
var input = readLine()!.split(separator: " ").map{Int($0)!}
var array = readLine()!.split(separator: " ").map{Int($0)!}

func selectSort(){
    let count = input[0]
    var end = 0
    guard count > 1 else {
        print(-1)
        return
    }
    for i in stride(from: count-1, to: 0, by: -1){
        let j = array.firstIndex(of: array[0..<i].max()!)!
        if array[i] < array[j]{
            array.swapAt(i, j)
            end += 1
            if end == input[1]{
                print(array.map{String($0)}.joined(separator: " "))
                return
            }
        }
    }
    if end < input[1]{
        print(-1)
        return
    }
}

selectSort()
```

### 풀이

```
해당 문제는 선택정렬 중 특정 횟수에 배열 상태를 출력하는 문제

배열의 범위는 N(5 ≤ N ≤ 10,000)으로 표현 가능한 길이 자체가 짧기 때문에 O(N^2)정도의 시간복잡도를 가져도 풀이 가능
```

1. 배열의 길이가 하나일 경우 -1을 출력하고 시작
2. 배열은 가장 마지막부터 정렬하여 루프를 시작함으로 인덱스 길이 -1부터 0까지 루프 시작 
3. 해당 배열의 마지막 인덱스를 제외한 그 앞 요소들 중에서 `가장 큰 수를 j`에 저장
4. i의 요소와 j의 요소를 비교하여 j가 더 클 경우 스왑하고 end값을 1 증가 시킴
5. 루프 반복 중 입력받은 input과 end가 같을 경우 해당 배열의 상태를 출력하고 함수에서 break
6. 루프가 다 돌 때까지 input과 end가 바뀌지 않았다면, -1을 출력

**키포인트**

반복문을 하나를 사용했지만, 배열 요소 중 가장 큰값을 색출하는 식
```swift
let j = array.firstIndex(of: array[0..<i].max
```
이 코드는 해당 스코프의 0부터 인덱스 길이`(0~n-1)`만큼 배열을 만들고 그 값 중에 가장 큰값을 찾아야하기 때문에 최악의 경우인 `O(N)`의 시간 복잡도를 가짐

그래서 배열의 길이 N번 중 한번에 N의 시간이 걸리기 때문에 `O(N^2)`의 시간 복잡도를 가짐

## 풀이자 : PCYSB

### 코드
```java
fun main() {
    val br = BufferedReader(InputStreamReader(System.`in`))
    var (n, k) = br.readLine().split(' ').map { it.toInt() } //배열의 크기 n, 교환 번째
    val arr = br.readLine().split(' ').map { it.toInt() }.toIntArray() // 배열

    for (i in n - 1 downTo 1) {
        var max = i
        for (j in i - 1 downTo 0) {
            if (arr[max] < arr[j]) {
                max = j //가장 큰 수가 있는 인덱스
            }
        }
        if (arr[max] != arr[i]) {
            val temp = arr[i] //
            arr[i] = arr[max] // 가장 큰 수가 들어가야 하는 곳
            arr[max] = temp //
            if (--k == 0) {
                println(arr.joinToString(" "))
                return
            }
        }
    }
    println(-1)
}
```

### 풀이
> N개의 서로 다른 양의 정수가 저장된 배열 A
> 선택 정렬로 배열 A를 오름차순 정렬할 경우 K 번 교환이 발생한 직후의 배열 A를 출력해야 하는 문제

**입력**
첫째 줄에 배열 A의 크기, 교환 횟수
다음 줄에 서로 다른 배열 A의 원소를 입력한다.
A의 크기 N(5<=N <= 10000), 교환 횟수 K(1<=K<=N)

1. 배열의 크기 n과 교환 번째 k를 입력 받는다. 
2. 배열의 요소를 입력 받는다.
3. 배열의 가장 마지막 부분 부터 처음 +1 까지 i, 가장 마지막 부분 - 1 부터 처음까지 j
4. i의 요소와 j의 요소를 비교하여 가장 큰 수가 있는 값을 변수에 저장한다.
5. j가 마지막까지 돌은 후 i인덱스와 가장 큰 수가 있는 max 변수를 교환(기존 가장 큰 수 j의 자리에는 i의 요소가 들어간다.)
6. 이를 반복하며 교환 횟수 k를 1씩 줄여나간다.
7. k가 0이 될 시 현재의 배열을 출력, 또는 k가 되기전에 교환이 끝난다면 -1을 출력한다.

---

> 출제자 : PCYSB </br>
> 풀이자 : Quarang

# [백준][23883번] - 선택 정렬 3

https://www.acmicpc.net/problem/23883

## 출제자 : PCYSB

### 코드
```java
fun main() {
    var (n, k) = readLine()!!.split(' ').map { it.toInt() } // 배열 크기 n, 교환 횟수 k
    val li = readLine()!!.split(' ').map { it.toInt() }.toMutableList() //입력 받은 배열
    val sortedLi = li.sorted() // 원래 배열은 놔두고 정렬된 새 배열 생성

    val d = mutableMapOf<Int, Int>()
    li.forEachIndexed { index, value -> d[value] = index } // 기존값 저장


    for (i in n - 1 downTo 0) { // 기존, 변경값 배열값 비교
        if (sortedLi[i] != li[i]) { //
            val temp = listOf(li[i], sortedLi[i])
            li[i] = temp[1] // temp로만 해결 x 바뀐수가 또 바뀔경우는 비교가 불 가능 하기에 바뀐 수는 li[i]에 입력(현재 인덱스에 넣음)
            li[d[sortedLi[i]]!!] = temp[0] // 
            d[temp[0]] = d[temp[1]]!!.also { d[temp[1]] = d[temp[0]]!! }

            if (--k == 0) {
                println(temp.joinToString(" "))
                return
            }
        }
    }
    println(-1)
}
```

### 풀이 
> N개의 서로 다른 양의 정수가 저장된 배열 A를 선택 정렬로 오름차순 정렬할 경우 K 번째 교환되는 수를 구하는 문제

**입력**
첫째 줄에 배열 A의 크기 N, 교환 횟수 K를 입력한다. (5<=N<=500,000), (1<=K<=N)

**출력**
K 번째 교환되는 두 개의 수를 작은 수부터 한 줄에 출력한다. 교환 횟수가 K 보다 작으면 -1을 출력한다.

1. 배열 크기 N과 교환 횟수 K를 한 줄에 입력 받는다.
2. 배열의 요소를 한 줄에 입력받는다.
3. 기존의 배열을 정렬한 변수 sortedLi와 기존의 배열을 똑같이 복사한 map을 만든다.(map에는 요소를 key값으로 가지고, index를 value로 가진다.)
4. 뒤에서부터 0번 인덱스 까지 정렬된 배열과 정렬되지 않은 배열을 비교하며 반복 한다.
5. temp라는 변수에 정렬되지 않은 배열과, 정렬된 배열을 할당한다.
6. 정렬되지 않은 배열에 정렬된 배열의 요소를 할당한다.
7. map에 저장된 인덱스와 값을 활용하여 바뀐 부분의 인덱스를 변경한다.
8. 정렬된 배열과 정렬되지 않은 배열의 값을 활용하여 map의 값도 동일하게 변경해준다.
9. 해당 for 문을 돌때마다 k의 값을 1씩 줄여나가며 0이 될 시 반환한다.
10. 만약 k가 0이 되지 않았는데 for문이 종료될 경우 -1을 반환한다.


## 풀이자 : Quarang

### 코드

```swift
let input = readLine()!.split(separator: " ").map { Int($0)! }  
var array = readLine()!.split(separator: " ").map { Int($0)! }  
let sortedArray = array.sorted()   
var dic = [Int: Int]()                                   
array.enumerated().forEach{ dic[$1] = $0 }

var cnt = 0
for i in stride(from: input[0]-1, through: 0, by: -1) {
    if array[i] != sortedArray[i] {
        let temp = (array[i], sortedArray[i])
        array.swapAt(i, dic[sortedArray[i]]!)
                                                                
        let tmp = dic[temp.0]
        dic[temp.0] = dic[temp.1]
        dic[temp.1] = tmp
        
        cnt += 1
        if input[1] == cnt {
            print("\(temp.0) \(temp.1)")
            break
        }
    }
}
if cnt < input[1]{
    print(-1)
}
```

### 풀이

```
해당 문제는 선택정렬 중 특정 횟수에 따른 배열의 교환 요소를 출력하는 문제

배열의 범위는 N(5 ≤ N ≤ 500,000)으로 표현 가능한 길이 자체가 길기 때문에 O(N^2)정도의 시간복잡도를 가지면 시간초과가 발생함으로
해당 문제는 O(N) 혹은 O(N logN)으로 풀이 가능
```

1. 딕셔너리와 입력받은 배열,입력값에 대한 정렬한 배열을 준비한다.
2. 딕셔너리에는 입력받은 배열의 값은 `key`로, 배열의 요소는 `value`로 저장함
3. 이 문제는 배열의 마지막 부분부터 정렬하며 값을 변경함으로, 배열의 마지막 인덱스부터 처음까지 루프를 돌림
4. 루프에서 인덱스를 가지고 정렬배열과 입력배열을 비교하여 값이 다를시 스왑 이벤트를 실행 시킴
5. 값이 다른 순간, 원래 그 자리에 정렬되어야할 값을 찾음(여기서 딕셔너리를 사용하는데, 그 이유는 `정렬되어야할 값을 알고 있기에 그 값이 존재하는 인덱스를 알 수 있기 때문`)
6. 그렇게 요소의 인덱스를 서로 추출하여 서로 바꿈
7. 다음조건을 만족하기 위해 딕셔너리도 똑같이 바꿔줌
8. 만약 입력받은 수와 현재 스왑한 횟수가 일치할 경우 적은수를 먼저 출력하고 루프를 탈출

**키포인트**

해당 배열에서 교환할 인덱스를 색출하는 과정
```swift
array.swapAt(i, dic[sortedArray[i]]!)
```
사전에 만들어 둔 딕셔너리를 활용하여 요소의 키를 가진 값을 바로 출력하여 항상 `O(1)`의 시간복잠도를 가진다는 장점이 있음

하지만 `sorted()` 함수를 사용했기 때문에, 기존 알고리즘의 시간복잡도보다 높은 시간을 가진 알고리즘이 된 단점이 있음.

이것은 따로 보완할 필요가 있음
