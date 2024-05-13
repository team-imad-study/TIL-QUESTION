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
```swift
var inputLines: [Int] = []

func cantor(num: Double) -> String {
    guard num > 0 else {return "-"}
    let cantor = cantor(num: num-1)
    return cantor + String(repeating: " ", count: Int(pow(3,num-1))) + cantor
}
while let line = readLine(), let num = Double(line) {  print(cantor(num: num)) }
```

### 풀이
```
해당 문제는 같은 이벤트를 반복하는 함수를 재귀화하여 반복시켜 결과값을 도출하는 문제

접근방식은 입력받은 수를 1씩 감소 시켜 재귀 변수를 만들어 공백과 합치는 방식을 사용
재귀의 반복 횟수 N번과 재귀 내에서 공백의 수를 반복 시키는 3^(n-1)번에 따라 시간복잡도는 O(N^2)으로 예상

```


1. 입력을 받는 값을 실수로 변환하여 칸토어 집합 함수 실행
2. 칸토어 함수 내에선 입력 받은 값이 0 이상일 경우만 다음 이벤트를 실행하고, 아닐 경우 "-"을 출력
3. 칸토어 함수를 입력수의 -1로 재실행하고 그 값을 저장
4. 칸토어함수를 재실행한 값을 양측에 반복수만큼 공백처리한 값 양측에 붙임을 반복


> 키포인트

재귀가 반복 되는 부분 즉 규칙성을 찾아본다.
반복과정은 다음과 같다.
```
---------------------------
---------         ---------
---   ---         ---   ---
- -   - -         - -   - -

```

-이 1이 아닐 경우 그 줄을 3등분한 것에 1/3부터 2/3까지는 공백처리를 해야하고 
그것은 공백의 길이는 3^(N-1)값인 것임 

어차피 양측의 줄의 길이는 2이상이기 때문에 -로 이루어진 문자열을 계속 재귀로 반복해야하기 때문에 
재귀로 도출한 문자열과 공백 문자열을 합치는 것을 함수화 시키면 금방 도식화 가능

---

# [17478번] 재귀함수가 뭔가요?

https://www.acmicpc.net/problem/17478

> 출제자 : Quarang </br>
> 풀이자 : NCookie

## 출제자 : Quarang

### 코드
### 코드
```swift
var count = Int(readLine()!)!

func recursion(count:Int,repeating:Int){
    let text = String(repeating: "____", count: repeating)
    print("\(text)\"재귀함수가 뭔가요?\"")
    if count > 0{
        print("\(text)\"잘 들어보게. 옛날옛날 한 산 꼭대기에 이세상 모든 지식을 통달한 선인이 있었어.")
        print("\(text)마을 사람들은 모두 그 선인에게 수많은 질문을 했고, 모두 지혜롭게 대답해 주었지.")
        print("\(text)그의 답은 대부분 옳았다고 하네. 그런데 어느 날, 그 선인에게 한 선비가 찾아와서 물었어.\"")
        recursion(count:  count - 1 ,repeating: repeating + 1)
    }else{
        print("\(text)\"재귀함수는 자기 자신을 호출하는 함수라네\"")
    }
    print("\(text)라고 답변하였지.")
}
print("어느 한 컴퓨터공학과 학생이 유명한 교수님을 찾아가 물었다.")
recursion(count: count,repeating: 0)
```

### 풀이
```
해당 문제는 근본적인 재귀문제로 문자열의 반복을 재귀가 실행 될때마다 _(언더바)로 추가하여 반복 횟수를 가독성 있게 볼 수 있는 문제

재귀의 반복으로 N번반복, repeating함수의 반복으로 N번 반복 즉 O(N^2)의 시간복잡도를 가질 것이라 예상됨
```

1. "어느 한 컴퓨터공학과 학생이 유명한 교수님을 찾아가 물었다." 문자열은 항상 첫번째만 출력되고 등장하지 않기 때문에, 그냥 print로 출력
2. 재귀 함수에 입력값과 반복횟수 0을 파라미터로 가진채로 실행
3. 재귀함수내에서 현재 재귀 반복횟수에 따라 "_"를 반복적으로 실행하여 문자열 생성
4. 가장 먼저 "재귀함수가 뭔가요?"라는 질문 출력으로 재귀가 시작함. 이때부터 언더바를 사용하며 등장
5. 그 다음 재귀 횟수가 유효할 상태라면 대답을 출력하고 재귀 횟수가 유효하지 않을때 즉, 재귀가 끝났을때는 재귀함수에 관란 설명을 출력
6. 무조건적으로 출력되야할 "라고 답변하였지."를 출력한 뒤 재귀를 반복

> 키포인트

재귀의 반복횟수를 하나씩 차감하고, 현재까지의 반복횟수를 증가 시키는 것을 파라미터로 잡아 재귀를 실행 시킴
그리하여 재귀의 끝을 결정할 수 있고 재귀의 반복량에 따라 "_"의 갯수도 결정할 수 있게 됨

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
