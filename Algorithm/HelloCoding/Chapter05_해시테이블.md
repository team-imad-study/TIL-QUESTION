출제일 : 2024/04/15 (DAY 4) </br>
풀이일 : 2024/05/18 (DAY 5)

---

# [백준][1764번] 듣보잡

> 출제자 : PCYSB </br>
> 풀이자 : NCookie

https://www.acmicpc.net/problem/1764

## 출제자 : PCYSB

### 코드

```java
fun main() {
    val (N, M) = readLine()!!.split(' ').map { it.toInt() }

    val mapA = mutableMapOf<String, String>()
    val mapB = mutableMapOf<String, String>()

    for (i in 0 until N+M){
        val r = readLine()!!.toString()
        if (i < N){
            mapA["$r"] = r
        }else{
            mapB["$r"] = r
        }

    }

    val commonKey = mapA.keys.intersect(mapB.keys).sorted()
    println(commonKey.size)
    commonKey.forEachIndexed { index, s ->
        println(s)
    }

}

```

### 풀이
1. N과 M을 입력받는다.
2. N+M만큼 이름을 입력 받는데 i가 N보다 작을 경우에는 mapA에 key값으로 이름 value로 이름을 입력
3. 그렇지 않을 경우에는 key값에 이름 value 값으로 이름을 입력 받는다.
4. 두 개의 map에서 같은 key를 가지고 있는 공통 값만을 찾음과 동시에 정렬한다.
5. 해당 리스트의 크기를 출력 하고 이어서 순서대로 공통 값을 출력한다.

## 풀이자 : NCookie

### 코드 (1)

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        StringTokenizer st = new StringTokenizer(br.readLine());

        int n = Integer.parseInt(st.nextToken());
        int m = Integer.parseInt(st.nextToken());

        HashMap<String, Boolean> stringBooleanHashMap = new HashMap<>();

        for (int i = 0; i < n; i++) {
            stringBooleanHashMap.put(br.readLine(), true);
        }

        List<String> arr = new ArrayList<>();
        for (int j = 0; j < m; j++) {
            String s = br.readLine();
            if (stringBooleanHashMap.containsKey(s)) {
                arr.add(s);
            }
        }

        Collections.sort(arr);

        sb.append(arr.size()).append("\n");
        for (String s : arr) {
            sb.append(s).append("\n");
        }
        System.out.println(sb);
    }
}
```

### 풀이 (1)

간단하게 HashMap 자료구조를 사용해 문제를 풀었다. 맵 자료구조에 이미 이름이 저장되어 있다면 정답에 추가하도록 했다.

### 코드 (2)

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();
        StringTokenizer st = new StringTokenizer(br.readLine());

        int n = Integer.parseInt(st.nextToken());
        int m = Integer.parseInt(st.nextToken());
        int all = n + m;

        // 모든 입력 데이터를 한 배열에 저장하고 정렬한다.
        String[] arr = new String[all];
        for (int i = 0; i < all; i++) {
            arr[i] = br.readLine();
        }
        Arrays.sort(arr);

        // 정렬한 데이터 중 같은 문자열이 2개 이상이면 정답에 추가
        int cnt = 0;
        for (int i = 1; i < all; i++) {
            if (arr[i].equals(arr[i - 1])) {
                sb.append(arr[i]).append("\n");
                cnt++;
            }
        }

        System.out.println(cnt);
        System.out.println(sb);
    }
}
```

### 풀이 (2)

- HashMap 자료구조를 사용하지 않고 문제를 해결했다.
- 모든 입력 데이터를 하나의 배열에 저장하고 정렬했다. 이후 배열을 순회하면서 같은 문자열이 두 번 이상 나오면 정답에 추가하도록 했다.
- 결과적으로 HashMap을 썼을 때보다 조금 더 빨라지긴 했지만 의미 있을 정도의 차이는 아니었다.

---

# [백준][26008번] 해시 해킹

> 출제자 : NCookie </br>
> 풀이자 : PCYSB

https://www.acmicpc.net/problem/26008

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
        StringTokenizer st = new StringTokenizer(br.readLine());

        int n = Integer.parseInt(st.nextToken());
        int m = Integer.parseInt(st.nextToken());
        int a = Integer.parseInt(st.nextToken());

        int h = Integer.parseInt(br.readLine());

        /*
         * 가능한 배열의 조합의 수는 m^n개다. 각 배열의 요소마다 m개의 선택지가 있기 때문이다.
         * 미자막에 m으로 mod 연산을 하므로 해시값 h는 0부터 m-1까지의 숫자가 같은 확률로 나온다.
         * 따라서 특정 해시값이 나올 경우는 m^n / n, 즉 m^(n-1)개이다.
         * 이를 마지막에 1000000007으로 나머지 연산해주면 되는데,
         * 중간에 값이 매우 커지므로 매 연산마다 나머지 연산을 수행한다.
         */
        long answer = 1;
        for (int i = 0; i < n - 1; i++) {
            answer = (answer * m) % 1000000007;
        }

        System.out.println(answer);
    }
}
```

**나머지값 분포 검증용 파이썬 코드**
```python
from collections import Counter

def modulo_remainders_distribution(n, m):
    remainders_distribution = Counter()  # 나머지 값의 분포를 저장할 Counter 객체

    # 가능한 배열의 조합을 생성하고 나머지 연산 후 분포를 기록
    for i in range(m ** n):
        array = [(i // (m ** j)) % m for j in range(n)]  # 배열 생성
        remainder = sum(array) % m  # 배열의 합을 m으로 나머지 연산
        remainders_distribution[remainder] += 1  # 나머지 값의 출현 횟수 기록

    return remainders_distribution

n = int(input("배열의 길이를 입력하세요: "))
m = int(input("배열 안의 숫자 범위를 입력하세요: "))

distribution = modulo_remainders_distribution(n, m)

print("나머지 값과 해당 값의 출현 횟수:")
for remainder, count in distribution.items():
    print(f"나머지: {remainder}, 출현 횟수: {count}")
```

### 풀이

가능한 배열의 조합의 수는 $m^n$개다. 각 배열의 요소마다 m개의 선택지가 있기 때문이다. 미자막에 m으로 mod 연산을 하므로 해시값 h는 0부터 m-1까지의 숫자가 같은 확률로 나온다.

따라서 특정 해시값이 나올 경우는 $m^n \over n$, 즉 $m^{n-1}$개이다. 이를 마지막에 1000000007으로 나머지 연산해주면 되는데, 중간에 값이 매우 커지므로 매 연산마다 나머지 연산을 수행한다.


## 풀이자 : PCYSB
### 코드

```java
fun main() {
    val (N, M, A) = readLine()!!.split(' ').map { it.toInt() }
    val H = readLine()!!.toInt() //모든 요소를 합치고 M으로 나누었을 때 나와야 하는 수

    var answer = 1L

    for(i in 0 until N-1){
        answer = (answer * M)%1000000007
    }
    println(answer)
}
```
### 풀이
문제가 너무 복잡하여 알아보기 쉽게 아래와 같이 표시하였다.
배열 P의 사이즈는 N, 모든 원소는 M-1 이하의 값을 가진다. M은 나누는 수 이면서 원소의 값의 제한 이다. (0 <= 원소 < M) 해당 원소의 값을 더하고 M으로 나누었을 경우 해시값 H가 나오는 경우의 수를 구하는 문제이다.

예제)
3 2 1
1

p[p0, p1, p2 ] -> 여기서 p에 들어갈 수 있는 원소의 값은 0, 1 // M이 2니까

h(p)[p0 + (p1 * A^1) + (p2 * A^2)] mod M = H

h(p) = [(0, 1) + ((0, 1) * 1) + ((0, 1) * 1)] mod 2 = 1 -> 해당 원소들의 합을 2로 나누었을 때 1이 나오는 경우를 출력하면 된다.

해당 경우를 살펴 보면 h(p)의 값은 0 ~ M-1 중에 하나이다. (0부터 이기에 총 M개, M으로 나누고 남은 숫자가 최소한 한 개는 있어야 되기 때문에)

그리고 배열 P의 경우에 배열의 크기가 N 만큼을 가진다. (N만큼 크기를 가진 배열의 각각의 번째마다 M개 만큼의 요소를 가질 수 있다.)

때문에 P 배열에서 나올 수 있는 경우의 수는 M^N 만큼이 있다. 

우리가 구해야 하는 해시값을 갖는 비밀번호의 개수는 mod 연산이 끝난 후의 값이다. 

여기서 어떤 요소들이 들어오고 그 요소의 합의 나머지는 항상 동일한 개수가 나온다.

그렇기 때문에 해당 부분에서는 M^N/M = M^N-1 라는 공식이 성립된다.

---

# [프로그래머스][1845번] 폰켓몬

> 출제자 : KUN </br>
> 풀이자 : Quarang

https://school.programmers.co.kr/learn/courses/30/lessons/1845

## 출제자 : KUN

## 풀이자 : Quarang

### 코드(1)

```swift
func ponkemon(_ nums:[Int]) -> Int{
    let select = nums.count/2
    let nums = Set(nums)
    return nums.count > select ? select : nums.count
}
```

### 풀이(1)

```
해당 문제는 해시로 푸는 문제지만 성능과 효율성을 따졌을때 사용할 필요가 없다고 느껴 Set를 사용하여 풀이 진행
Set를 하는 작업은 배열의 각 요소를 집합에 추가해야함으로 O(N)의 시간복잡도를 가짐
```

1. 입력 받은 배열 전체 갯수의 절반의 수를 초과하면 안되기 때문에 데려갈 수 있는 폰켓몬의 최대값을 설정
2. 입력 받은 폰켓몬 고유번호의 중복값을 없애 자시 저장, 이때 `Set`를 사용
3. 만약 입력 받은 폰켓몬 고유번호의 갯수가 최대 데려갈 수 있는 폰켓몬 수보다 많을 경우 최대 수를 출력하고, 아닐 경우 고유 번호 수를 출력

### 코드(2)

```swift
func ponkemon(_ nums:[Int]) -> Int{
    let select = nums.count/2
    var dict = [Int:Int]()
    nums.forEach { num in
        dict[num,default: 0] += 1
    }
    return dict.count > select ? select : dict.count
}
```

### 풀이(2)

만약 해시로 꼭 구현해야한다면, 별반 다를 부분은 없음
마찬가지로 Set를 사용하지는 않지만 forEach문을 입력받은 배열 길이 갯수만큼 돌리니 전 문제와 같이 O(N)의 시간복잡도를 가짐

해시(딕셔너리)도 중복을 제거하는 특징이 있어서 같은 방법으로 값을을 분리 시킨뒤 전체 크기 갯수로 비교하여 
값을 출력하면 끝


---

# [프로그래머스][42579번] 베스트앨범

> 출제자 : Quarang </br>
> 풀이자 : KUN

https://school.programmers.co.kr/learn/courses/30/lessons/42579

## 출제자 : Quarang

### 코드

```swift
import Foundation

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    
    var genreDict = [String:[(index:Int,play:Int)]]()
    
    genres.enumerated().forEach{ (index,genre) in
        genreDict[genre , default : []].append((index,plays[index]))
    }
    
    var sortedTupleArr = [(index:[Int],sum:Int)]()
    genreDict.forEach { (_,index) in
        let sorted = index.sorted{ $1.play < $0.play}
        let sum = sorted.map{$0.play}.reduce(0, +)
        sortedTupleArr.append((sorted.prefix(2).map{$0.index},sum))
    }
    return sortedTupleArr.sorted{ $0.sum > $1.sum}.flatMap{$0.index}
}
```

### 풀이

```
해당 문제는 두가지의 배열의 요소로 특정 규칙을 만족하도록 값을 출력해야하는 문제다.
딕셔너리(해시)를 생성한 뒤 해시에 값을 추가하는 과정에서 딕셔너리의 전체 길이의 루프를 돌며, 정렬함수를 쓰기 때문에 결론적으로 이 문제의 총 시간 복잡도는 O(N)이라고 할 수 있다.
```

이 문제의 미 포인트는 `해시 안에 튜플`을 사용했다는 점이다.
1. 해시의 키를 `String`, 값을 `(Int,Int)`타입의 튜플형태로 초기화 하여 변수 생성
2. `enumerated()`를 사용하여 장르 필터와 인덱스 값으로 루프를 돌려 딕셔너리에 genre를 키로, (index,plays)를 값으로 저장함 그럼 다음과 같은 결과가 나옴

**입력값**
|genres|plays|return|
|---|---|---|
|["classic", "pop", "classic", "classic", "pop"]|[500, 600, 150, 800, 2500]	|[4, 1, 3, 0]|

**반환값**
```
["classic": [(index: 0, play: 500), (index: 2, play: 150), (index: 3, play: 800)], "pop": [(index: 1, play: 600), (index: 4, play: 2500)]]
```

3. 이 다음은 해당 조건대로 정렬하고 값을 변형하여 주는 작업임
```
1. 속한 노래가 많이 재생된 장르를 먼저 수록합니다.
2. 장르 내에서 많이 재생된 노래를 먼저 수록합니다.
```
4. 위 조건의 만족하기 위해 play값 기준으로 오름차순으로 정렬함
5. 그리고 plays의 합계를 계산
6. 정렬 된 plays 배열에서 가장 많이 플레이된 앞부분 수 두개를 잘라서 합계값을 같이 튜플 형태로 딕셔너리에 저장

그렇게 되면 촐 플레이 횟수를 따져서 값을 정렬할 수 있게 됨


## 풀이자 : KUN
