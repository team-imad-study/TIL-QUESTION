출제일 : 2024/05/27 (DAY 7) </br>
풀이일 : 2024/05/31 (DAY 8)

---

# [프로그래머스][42883번] 큰 수 만들기

> 출제자 : Quarnag </br>
> 풀이자 : KUN

https://school.programmers.co.kr/learn/courses/30/lessons/42883

## 출제자 : Quarang

### 코드

### 풀이

## 풀이자 : KUN

### 코드

### 풀이

---

# [프로그래머스][42860번] 조이스틱

> 출제자 : KUN </br>
> 풀이자 : NCookie

https://school.programmers.co.kr/learn/courses/30/lessons/42860

## 출제자 : KUN

### 코드

### 풀이

## 풀이자 : NCookie

### 코드

```java
class Solution {
    static public int solution(String name) {
        int answer = 0;

        int n = name.length();
        int upDown = 0;
        int leftRight = n - 1;

        for (int i = 0; i < n; i++) {
            if (name.charAt(i) <= 'N') {
                upDown += name.charAt(i) - 65;
            } else {
                upDown += 91 - name.charAt(i);
            }

            // 연속된 A의 다음 문자를 찾을 때까지 탐색
            int nextMove = i + 1;
            while (nextMove < n && name.charAt(nextMove) == 'A') {
                nextMove++;
            }

            leftRight = Math.min(leftRight, 
                        Math.min(i + i + (n - nextMove), (n - nextMove) + (n - nextMove) + i));
        }

        answer = upDown + leftRight;

        return answer;
    }
}
```

### 풀이

이 문제의 핵심을 정리하자면 다음과 같다.

1. 어떤 위치의 문자가 A가 아니라면 반드시 방문해야 한다. 즉, 문자가 A인 위치는 생략해도 된다.
2. 조이스틱을 위아래로 움직여 알파벳을 만드는 횟수는 정해져 있다. (고정)
3. 따라서 조이스틱을 좌우로 움직이는 횟수가 가장 적은 경우를 찾아야 한다.
4. A가 연속된 구간을 만날 때마다 어떻게 해야 움직이는 횟수가 가장 적은지 탐색한다.

조이스틱을 좌우로 최소한으로 움직이는 경우는 3가지가 있다.

- 원점으로부터 오른쪽 끝까지 탐색하는 경우 => `n - 1`

- 원점으로부터 x까지 이동하고 다시 왼쪽으로 이동해서 y까지 탐색하는 경우</br>
    => `x + x + (n - y)` : 오른쪽으로 x만큼 이동 + 다시 왼쪽으로 x만큼 이동 + 왼쪽으로 y까지(n-y) 이동

- 원점으로부터 왼쩍으로 이동해 y까지 탐색하고 다시 오른쪽으로 x까지 탐색하는 경우</br>
    => `(n - y) + (n - y) + x` : 왼쪽으로 y까지(n-y) 이동 + 오른쪽으로 원점까지(n-y) 이동 + 오른쪽으로 x까지 이동

### 참고

- [C++ 극도로 상세하고 쉬운 풀이](https://school.programmers.co.kr/questions/76244)
- [중요한 힌트 정리해드립니다.](https://school.programmers.co.kr/questions/47855)

---

# [프로그래머스][42885번] 구명보트

> 출제자 : PCYSB </br>
> 풀이자 : Quarang

https://school.programmers.co.kr/learn/courses/30/lessons/42885

## 출제자 : PCYSB

### 코드

### 풀이

## 풀이자 : Quarang

### 코드

### 풀이

---

# [백준][1541번] 잃어버린 괄호

> 출제자 : NCookie </br>
> 풀이자 : PCYSB

https://www.acmicpc.net/problem/1541

## 출제자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String s = br.readLine();

        String[] split = s.split("-");

        int answer = 0;

        for (int i = 0; i < split.length; i++) {
            String[] numbers = split[i].split("\\+");
            int sum = 0;
            for (String num : numbers) {
                sum += Integer.parseInt(num);
            }

            if (i != 0) {
                answer -= sum;
            } else {
                answer += sum;
            }
        }

        System.out.println(answer);
    }
}
```

### 풀이

식을 가장 작은 수로 만들기 위해서는 최대한 많은 수를 더하고 앞에 "-" 연산자를 붙여서 음수로 만들어야 한다. 이를 위해 "-"를 기준으로 식을 분리한다.

"-"를 기준으로 나뉘어진 문자열들은 숫자와 "+"들로만 이루어져 있다. 이들의 합을 각각 구하고, 첫 번째 문자열을 제외하고는 뺄셈 연산을 수행한다. 입력의 첫 번째 문자로는 숫자만 올 수 있기 때문에 첫 번째 덩어리는 항상 양수이기 때문이다.

## 풀이자 : PCYSB

### 코드

### 풀이

---