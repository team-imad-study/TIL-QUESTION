출제일 : 2024/06/03 (DAY 9) </br>
풀이일 : 2024/06/14 (DAY 10)

---

# [프로그래머스][42895번] N으로 표현

> 출제자 : Quarnag </br>
> 풀이자 : PCYSB

https://school.programmers.co.kr/learn/courses/30/lessons/42895

## 출제자 : Quarang

### 코드
```swift
func solution(_ N:Int, _ number:Int) -> Int {
    var dp = Array(repeating: [Int](), count: 9)
    for i in 1..<9 {
        dp[i].append(Int(String(repeating: String(N), count: i))!)
        for j in 1..<i {
            for x1 in dp[j] {
                for x2 in dp[i-j] {
                    dp[i].append(x1*x2)
                    dp[i].append(x1+x2)
                    dp[i].append(x1-x2)
                    if x2 != 0 { dp[i].append(x1/x2) }
                }

            }
        }
        if dp[i].contains(number){ return i }
    }
    return -1
}
```

### 풀이

```
위 문제는 한 숫자만으로 특정 값을 사칙연산으로 만들 수 있는 경우의 수 중 가장 적은 항의 갯수를 구하는 문제

dfs혹은 bfs로도 풀수 있는 문제이지만 모든 경우를 다 검사해야하기 때문에 시간이 오래걸린다는 단점이 있음

이에 동적계획법으로 인해 런타임 시간을 현저히 줄일 수 있게 됨
```
> 과정
1. 먼저 모든 경우의 수를 저장할 2차원 배열 생성
2. N은 한자리 수임으로 0부터 9까지 반복
3. 첫번째는 해당 수로 만들수 있는 갯수만큼 첫번째로 추가(ex)N = 5라면 f(1) = 5, f(2) = 55, f(3) = 555..)
4. 1부터 시작해 현제 i의 갯수만큼 반복하고 그 중 이미 저장되어있는 값에 사칙연산을 한번씩 모두 실행함
5. 만약 사칙연산을 한 결괏값이 도출될 경우 해당 i번째를 리턴(반복을 0부터 1씩 늘려서 검사하기 때문에, 결괏값이 나오는 순간이 가장 적은 값이라 단언할 수 있음)
6. 만약 모든 루프를 돌았음에도 결괏값이 나오지 않았다면 -1을 출력

## 풀이자 : PCYSB

### 코드
```java
class Solution {
    fun solution(N: Int, number: Int): Int {
        if (N == number) return 1
        
        val dp = Array(9) { mutableSetOf<Int>() }
        dp[1].add(N)
        
           for (i in 2..8) {

        dp[i].add(N.toString().repeat(i).toInt())

        for (j in 1 until i) {
            for (x in dp[j]) {
                for (y in dp[i - j]) {
                    dp[i].add(x + y)
                    dp[i].add(x - y)
                    dp[i].add(x * y)
                    if (y != 0) {
                        dp[i].add(x / y)
                    }
                }
            }
        }

        if (number in dp[i]) {
            println(i)
            return i

        }
    }

    return -1
}
}
```

### 풀이
i는 현재 만들어지고 있는 조합들을 의미한다.
- 가장 처음에는 해당 숫자를 사칙연산이 아닌 연속된 숫자들만을 할당한다.
- 1번 인덱스에는 직접 첫 숫자를 추가하기에 i는 2번 인덱스 부터 시작한다.

j는 조합을 만들기 위해서 찾아볼 배열들의 범위를 말한다.
- 1번 인덱스	~ i-1번 인덱스까지의 배열을 의미한다.

x는 j번째 배열에 있는 요소들을 하나씩 기준으로 잡고 y와 더한다.

y는 j-1번째에 요소들을 전부 현재 j 번째 요소와 사칙연산을 하여 배열에 추가한다.

이런식으로 8번 까지 반복하여 8번을 초과한 경우에는 -1을 리턴하고 그렇지 않은 경우에 i가 한 번 끝날때 마다 해당 배열안에 만들어야 하는 숫자가 있는지를 확인
하여 있다면 해당 인덱스를 리턴하고 그렇지 않다면 다시 반복한다.

---

# [백준][2629번] 양팔저울

> 출제자 : NCookie </br>
> 풀이자 : Quarnag

https://www.acmicpc.net/problem/2629

## 출제자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

public class Main {
    static int n;
    static int[] weight = new int[31];

    // 추의 개수는 최대 30개까지, 무게는 최대 15000g이 될 수 있다.
    static boolean[][] dp = new boolean[31][15001];

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringBuilder sb = new StringBuilder();

        // 추 입력
        n = Integer.parseInt(br.readLine());
        StringTokenizer st = new StringTokenizer(br.readLine());
        for (int i = 0; i < n; i++) {
            weight[i] = Integer.parseInt(st.nextToken());
        }

        solve(0, 0);

        int balls = Integer.parseInt(br.readLine());
        st = new StringTokenizer(br.readLine());
        for (int i = 0; i < balls; i++) {
            int ball = Integer.parseInt(st.nextToken());
            if (ball > 15000) {
                sb.append("N").append(" ");
            } else {
                String result = dp[n][ball] ? "Y" : "N";
                sb.append(result).append(" ");
            }
        }


        System.out.println(sb);
    }

    static void solve(int i, int w) {
        // 재귀 종료 조건
        // 모든 추의 개수를 조합해 봤거나, 이미 추들로 완성했던 무게는 스킵
        if (i > n || dp[i][w]) {
            return;
        }

        dp[i][w] = true;
        solve(i + 1, w + weight[i]);
        solve(i + 1,  Math.abs(w - weight[i]));
        solve(i + 1, w);
    }
}
```

### 풀이

추를 놓는 경우의 수는 3개다. 구슬 쪽 저울에 올릴 것인지, 반대편 저울에 올린 것인지, 아예 사용하지 않을 것인지. 따라서 이 모든 경우의 수를 따져보고 구슬 무게를 만들 수 있는지 확인해야 한다. 그러나 이대로 구현하면 경우의 수가 매우 많아 시간 초과가 발생할 것이기 때문에, 다이나믹 프로그래밍 방식을 적용한다.

구현하기 위해 냅색 문제(배낭 문제)와 비슷하게 dp를 2차원 배열로 선언한다. 그리고 추를 놓는 3가지 경우에 대해 재귀를 수행한다. 만약 이미 true(구슬 무게를 잴 수 있음)이면 해당 재귀 스택은 종료된다.

이 때 dp[x][y]는 x번까지의 추를 사용했을 때 y 무게를 만들 수 있는지에 대한 여부이다. 

추는 입력으로 최대 30개까지 들어오고, 각각의 추는 최대 500g이다. 즉, 추로 만들 수 있는 최대 무게는 15000g이다. 그래서 dp 배열은 dp[31][15001]로 할당해주고, 15,000g까지만 무게 잴 수 있는지 여부를 계산한다. 

구슬 입력으로 15,000보다 크게 들어오면 주어진 추로는 절대 무게를 잴 수 없기 때문에 항상 "N"이다.

## 풀이자 : Quarang

### 코드
```swift
let n = Int(readLine()!)!                                                   
let weights = readLine()!.split(separator: " ").map{Int(String($0))!}
let m = Int(readLine()!)!
let marble = readLine()!.split(separator: " ").map{Int(String($0))!}
var dp = Set<Int>()  

for weight in weights {
    var tmp:Set<Int> = [weight]
    for d in dp {
        tmp.insert(abs(weight-d))
        tmp.insert(weight+d)
    }
    dp.formUnion(tmp)
}
print(marble.map{dp.contains($0) ? "Y" : "N"}.joined(separator: " "))
```

### 풀이
```
이 문제는 추의 갯수와 구슬 개수를 입력 받아 각 구슬 별로 양팔 저울에 무게가 같게 만들 수 있는 모든 구슬의 무게를 검사 해 주어진 각 구슬의 무게에 대하여 확인이 가능하면 Y, 아니면 N 을 차례로 출력하는 문제
```
양팔저울이 수평이 되게 하는 조건은 다음과 같음

1. 구슬들을 모두합해 추의 무게와 같게 하는 경우
2. 구슬과 특정 추의 무게를 합이 다른 추와 크기가 같은 경우

위와 같은 공식에 따라 추와 각각의 구슬들의 합과 차이를 구함

> 과정
1. 추의 갯수만큼 반복문 시작
2. 반복할 때마다 추를 하나씩 집합에 추가
3. 이미 저장되어있는 경우에 수(추의 합 혹은 차)에서 현재 구슬의 무게의 합 혹은 차를 계산(반복하여 가능한 모든 수를 검사)
4. 집합은 중복이 안되는 특징이 있음으로 결괏값을 모두 합집합
5. 마지막으로 구슬의 무게를 하나씩 입력받아 현재 집합에 추가 되어있는지를 판별하여 "Y"혹은 "N"을 출력

---

# [백준][11057번] 오르막수

> 출제자 : PCYSB </br>
> 풀이자 : KUN

https://www.acmicpc.net/problem/11057

## 출제자 : PCYSB

### 코드
```java
fun main() {
    val n = readLine()!!.toInt()
    val arr = Array(n + 1) { IntArray(10) }
    var total: Long = 0

    for (i in 0..9) {
        arr[1][i] = 1
    }

    for (k in 2..n) {
        for (i in 0..9) {
            for (j in 0..i) {
                arr[k][i] += arr[k - 1][j] % 10007
            }
        }
    }

    println(arr[n].toList().reduce { acc, num -> (acc + num) % 10_007 })
}
```

### 풀이
1. 오르막 수가 자릿수가 커질때마다 어떤식으로 증가하는지를 일단 알아야한다.
한 자리일 경우
0 -> 1
1 -> 1
2 -> 1
3 -> 1
4 -> 1
5 -> 1
6 -> 1
7 -> 1
8 -> 1
9 -> 1
total = 10

두 자리일 경우
0 -> 1
1, 11 -> 2
2, 12, 22 -> 3
3, 13, 23, 33 -> 4
4, 14, 24, 34, 44 -> 5
5, 15, 25, 35, 45, 55 -> 6
6, 16, 26, 36, 46, 56, 66 -> 7
7, 17, 27, 37, 47, 57, 67, 77 -> 8 
9.... 99 -> 10
total = 55

각각의 자릿수에서 오르막 수의 증가가 되는 것을 확인해 보면 그 전 자릿수의 오르막수들을 본인 자리까지 더하는 것을 알 수 있다.
그래서 자릿수 k, 끝나는 번호 i,  더해줘야할 j 로 나누어  오르막 수를 구하는 식을 만들어 해결 하였다.

## 풀이자 : KUN

### 코드

### 풀이

---

# [프로그래머스][42898번] 등굣길

> 출제자 : KUN </br>
> 풀이자 : NCookie

https://school.programmers.co.kr/learn/courses/30/lessons/42898

## 출제자 : KUN

### 코드

### 풀이

## 풀이자 : NCookie

### 코드

```java
class Solution {
    static public int solution(int m, int n, int[][] puddles) {
        int[][] dp = new int[n + 1][m + 1];
        for (int[] puddle : puddles) {
            dp[puddle[1]][puddle[0]] = -1;
        }

        // 시작점(dp[1][1])을 1로 초기화하기 위해 설정
        dp[0][1] = 1;
        int sum = 0;

        // 현재 위치로 올 수 있는 경로의 개수는 dp 배열의 위와 왼쪽의 값을 더한 값이다.
        // 만약 -1일 경우에는 합 연산에서 제외한다.
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                if (dp[i][j] == -1) {
                    continue;
                }

                sum = 0;
                if (dp[i - 1][j] != -1) {
                    sum += dp[i - 1][j];
                }
                if (dp[i][j - 1] != -1) {
                    sum += dp[i][j - 1];
                }

                dp[i][j] = sum % 1000000007;
            }
        }

        return dp[n][m];
    }
}
```

### 풀이

좌표상에서 오른쪽과 아래쪽으로만 움직이기 때문에 특정 위치에 도달했을 때의 경로는 항상 최단경로다. 따라서 우리는 `학교`까지의 모든 경로 개수를 구하면 된다.

dp[i][j]에 도달하는 경로의 개수는 dp[i-1][j] + dp[i][j-1]이다. 만약 둘 중 하나가 -1(물에 잠긴 곳)이라면 덧셈 연산에서 제외한다. 예제를 표로 그려보면 다음과 같을 것이다.

![image](https://github.com/team-imad-study/study-question/assets/16646208/79c297e2-f74a-4c10-9294-0c888efac379)

집(1, 1)에서 출발하는 경우의 수는 항상 1개다. (3, 2)에서는 왼쪽 값이 -1이므로 위의 값 1만 더한다. `(A + B) % C == (A % B) + (A % C)`이므로 표의 값을 갱신할 때마다 모듈로 연산을 수행한다.

주의해야 할 점으로, 물에 잠긴 곳(`puddles`) 좌표는 2차원 배열이 아니라 (x, y) 좌표 방식으로 제공된다. 처음에 아무 생각없이 `dp[puddle[0]][puddle[1]] = -1;`로 처리해서 오답이 떠서 한참 헤맸었다.

---
