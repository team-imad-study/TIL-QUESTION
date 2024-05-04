# 선택정렬

출제일 : 2024/04/29 (DAY 1) </br>
풀이일 : 2024/05/03 (DAY 2)

---

## [2750번] 수 정렬하기

> 출제자 : KUN </br>
> 풀이자 : NCookie

https://www.acmicpc.net/problem/2750

### 코드

### 풀이

---

## [28116번] 선택 정렬의 이동 거리

> 출제자 : NCookie </br>
> 풀이자 : KUN

https://www.acmicpc.net/problem/28116

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

### 입력

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

### 정렬 및 루프

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

---

> 출제자 : Quarang </br>
> 풀이자 : PCYSB

## [23882번 알고리즘 수업] - 선택 정렬 2

https://www.acmicpc.net/problem/23882

### 코드

### 풀이

---

> 출제자 : PCYSB </br>
> 풀이자 : Quarang

## [23883번 알고리즘 수업] - 선택 정렬 3

https://www.acmicpc.net/problem/23883

### 코드

### 풀이
