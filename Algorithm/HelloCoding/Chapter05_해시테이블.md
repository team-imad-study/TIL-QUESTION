출제일 : 2024/04/15 (DAY 4) </br>
풀이일 : 2024/05/18 (DAY 5)

---

# [1764번] 듣보잡

> 출제자 : PCYSB </br>
> 풀이자 : NCookie

https://www.acmicpc.net/problem/1764

## 출제자 : PCYSB

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

# [26008번] 해시 해킹

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



---

# [프로그래머스] 폰켓몬

> 출제자 : KNU </br>
> 풀이자 : Quarang

https://school.programmers.co.kr/learn/courses/30/lessons/1845

## 출제자 : KNU

## 풀이자 : Quarang

---

# [프로그래머스] 베스트앨범

> 출제자 : Quarang </br>
> 풀이자 : KNU

https://school.programmers.co.kr/learn/courses/30/lessons/42579

## 출제자 : Quarang

## 풀이자 : KNU
