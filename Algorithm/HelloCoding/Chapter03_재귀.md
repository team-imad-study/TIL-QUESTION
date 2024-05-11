출제일 : 2024/05/03 (DAY 2) </br>
풀이일 : 2024/05/11 (DAY 3)

---

# [2748번] 피보나치 수 2

https://www.acmicpc.net/problem/2748

> 출제자 : KUN </br>
> 풀이자 : PCYSB

## 출제자 : KUN

### 코드

### 풀이

## 풀이자 : PCYSB

### 코드

### 풀이

---

# [4779번] 칸토어 집합

https://www.acmicpc.net/problem/4779

> 출제자 : NCookie </br>
> 풀이자 : Quarang

## 출제자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    static char[] charArr;

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        String input;
        
        // 입력 끝날 때까지 루프
        while ((input = br.readLine()) != null) {
            int n = Integer.parseInt(input);
            
            // 3^n 만큼 "-" 반복
            charArr = "-".repeat((int) Math.pow(3, n)).toCharArray();

            // 완전 이진 트리의 전위 탐색 과정과 유사함
            cantor(charArr.length, 0);
            System.out.println(charArr);
        }
    }

    static void cantor(int length, int startIndex) {
        // 선의 길이가 1이 되면 재귀 종료
        if (length == 1) {
            return;
        }

        //
        int nextLength = length / 3;

        // 3등분한 가운데 문자열을 공백으로 대체
        for (int i = 0; i < nextLength; i++) {
            charArr[i + startIndex + nextLength] = ' ';
        }

        // 각각 3등분 후의 왼쪽과 오른쪽 문자열에 재귀 함수 호출
        cantor(nextLength, startIndex);
        cantor(nextLength, startIndex + 2 * nextLength);
    }
}
```

### 풀이

$n^3$개의 '-'로 이루어진 문자열을 3등분하고 그 중 가운데 문자열을 공백으로 대체해야 한다. 그리고 나머지 두 덩이의 문자열을 다시 3등분하고 가운데 문자열을 공백으로 바꾼다. 이를 연속된 '-'의 개수가 1개가 될 때까지 반복하는 것이다.

나는 이 부분에서 이진트리의 전위 탐색을 떠올렸고 그 구현 코드를 가져와서 적용했다.

## 풀이자 : Quarang

### 코드

### 풀이

---

# [17478번] 재귀함수가 뭔가요?

https://www.acmicpc.net/problem/17478

> 출제자 : Quarang </br>
> 풀이자 : NCookie

## 출제자 : Quarang

### 코드

### 풀이

## 풀이자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {
    static StringBuilder sb = new StringBuilder();
    static int n;

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        n = Integer.parseInt(br.readLine());

        sb.append("어느 한 컴퓨터공학과 학생이 유명한 교수님을 찾아가 물었다.\n");

        recur(0);

        sb.append("라고 답변하였지.\n");
        System.out.println(sb);
    }

    static void recur(int depth) {
        String underBar = "_".repeat(depth * 4);

        // 재귀 종료
        if (depth == n) {
            sb.append(underBar).append("\"재귀함수가 뭔가요?\"\n");
            sb.append(underBar).append("\"재귀함수는 자기 자신을 호출하는 함수라네\"\n");

            return;
        }

        sb.append(underBar).append("\"재귀함수가 뭔가요?\"\n");
        sb.append(underBar).append("\"잘 들어보게. 옛날옛날 한 산 꼭대기에 이세상 모든 지식을 통달한 선인이 있었어.\n");
        sb.append(underBar).append("마을 사람들은 모두 그 선인에게 수많은 질문을 했고, 모두 지혜롭게 대답해 주었지.\n");
        sb.append(underBar).append("그의 답은 대부분 옳았다고 하네. 그런데 어느 날, 그 선인에게 한 선비가 찾아와서 물었어.\"\n");

        recur(++depth);

        sb.append("_".repeat(depth * 4)).append("라고 답변하였지.\n");
    }
}
```

### 풀이

언뜻 봤을 때 복잡해보이지만 규칙이 있다.

제일 먼저 첫 번째 문장은 한 번만 출력된다.

```
어느 한 컴퓨터공학과 학생이 유명한 교수님을 찾아가 물었다.
```

그리고 재귀 때마다 4줄의 문장이 반복된다.

```
"재귀함수가 뭔가요?"
"잘 들어보게. 옛날옛날 한 산 꼭대기에 이세상 모든 지식을 통달한 선인이 있었어.
마을 사람들은 모두 그 선인에게 수많은 질문을 했고, 모두 지혜롭게 대답해 주었지.
그의 답은 대부분 옳았다고 하네. 그런데 어느 날, 그 선인에게 한 선비가 찾아와서 물었어."
```

재귀의 마지막에는 두 개의 문장을 출력하고

```
"재귀함수가 뭔가요?"
"재귀함수는 자기 자신을 호출하는 함수라네"
```

재귀가 종료되며 아래 문장을 출력한다.

```
라고 답변하였지.
```

재귀 시 수행되는 모든 문장의 앞에는 재귀 깊이 * 4개의 `_`가 붙는다.

---

# [25501번] 재귀의 귀재

> 출제자 : PCYSB </br>
> 풀이자 : KUN

https://www.acmicpc.net/problem/25501

## 출제자 : PCYSB

### 코드

### 풀이

## 풀이자 : KUN

### 코드

### 풀이
