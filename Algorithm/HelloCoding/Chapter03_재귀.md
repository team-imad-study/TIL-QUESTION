출제일 : 2024/05/03 (DAY 1) </br>
풀이일 : 2024/05/11 (DAY 2)

---

# [10870] 피보나치 수 2

https://www.acmicpc.net/problem/10870

> 출제자 : KUN </br>
> 풀이자 : PCYSB

## 출제자 : KUN

### 코드
```javascript
const readline= require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let input: number;

rl.on("line", function(line){
    input = parseInt(line);
}).on("close", function(){
    const result = fibo(input);
  console.log(result);
})

const fibo = (input: number): number => {
  if (input == 0) {
    return 0;
  } else if (input == 1) {
    return 1;
  } else {
    return fibo(input - 1) + fibo(input - 2);
  }
};
```


### 풀이
간단한 피보나치 수열을 구하는 문제이다. 
입력값으로 n을 입력받는데 이 n으로 n 번째의 피보나치 수열에 대입되는 값을 구해내면된다. n의범위는 0 =< n =< 20 이다.

해당문제에 이미 피보나치 수열을 구하는 식이 있기에 어렵지않게 접근할수 있다.
Fn = Fn-1 + Fn-2 (n ≥ 2) 이식을 코드로 구현하기 위해 재귀 함수를 사용했고 

input 으로 n 을 받아내 n 이 0이나 1이 될때까지 해당식을 반복하면 n에 대입되는 피보나치 수열의 값을 알아낼수있다. 
물론 처음 문제를 보았을때는 이해가 잘안되었으나 그림을 그리면서 이해를 하게되었다.
![피보나치수열 재귀함수 설명](https://github.com/team-imad-study/study-question/assets/136051281/2b1ed839-a06d-4031-9645-f9cb40f74a60)

물론 반복되는 식계산이기에 for 문으로도 구현 할 수 있는 문제 이지만 재귀함수를 배운 챕터이기에 재귀함수로 구현한것이다.


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
```javascript
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

let input: string[] = []; // 입력값을 저장할 배열 선언

rl.on("line", function (line: any) {
  input.push(line.trim());
}).on("close", function () {
  input.shift(); // 첫 번째 요소를 제거
  const answer = act(input);
  answer.forEach((item) => console.log(item));
});
let cnt = 0; // 전역변수로 카운터 추가
const act = (input: string[]) => {
  const answer: any[] = [];
  for (let i = 0; i < input.length; i++) {
    answer.push(`${isPalindrome(input[i])} ${cnt}`); // 출력기준과 맞추기위해 isPalindrome 의 결과와 cnt를 문자열로 바꿔 한요소로 저장 
  }
  return answer;
};

const isPalindrome = (s: string) => {
  return recusion(s, 0, s.length - 1);
};

const recusion = (s: string, l: number, r: number): any => {
  if (l === 0) {
    cnt = 0; //카운터 초기화 
  }
  cnt++; //카운터 증가

  if (l >= r) {
    return 1;
  } else if (s[l] !== s[r]) {
    return 0;
  } else {
    return recusion(s, l + 1, r - 1);
  }
};
```


### 풀이
팰린드롬 문자열이란 앞에서부터 읽었을때와 뒤에서부터 읽었을 때가 같은 문자열을 말한다. 예) tenet , level
이문제는 문제에서 이미 펠린드롬 문자열인지 아닌지를 1 과 0으로 나타내주는 함수를 알려주었다. 
문제에 첨부된 코드) 
```c
#include <stdio.h>
#include <string.h>

int recursion(const char *s, int l, int r){
    if(l >= r) return 1;
    else if(s[l] != s[r]) return 0;
    else return recursion(s, l+1, r-1);
}

int isPalindrome(const char *s){
    return recursion(s, 0, strlen(s)-1);
}

int main(){
    printf("ABBA: %d\n", isPalindrome("ABBA")); // 1
    printf("ABC: %d\n", isPalindrome("ABC"));   // 0
}
```
우리가 해야될것은 출력 기준인 팰린드롬 문자열인지 확인한 결과 1 or 0(한칸빈칸) 재귀함수의 호출횟수 
를 만들어내기위해 저함수를 자신의 언어로 컨버트하는것과 재귀함수쪽에 카운터를 하나 만들어 달아주는것이다.
일단 전역변수로 cnt 라는 변수를 하나 추가해주었다. 
그리고 위코드를 내가쓰고있는 언어인 TYPESCRIPT 로 컨버트 해주고 recursion 함수 쪽에 재귀의 첫입력인 i === 0 인것을 확인하고 맞다면 카운터를 초기화 해주었다. 
그리고 i !== 0 인 다른경우엔 재귀함수가 진행중인 것이니 cnt++ 로 카운터 증가를 구현해주었다. 

그리고 출력을 하기위해 act 함수에서 answer 배열을 만들어주고 for 문으로 input[i] 를 isPalindrome 함수에 집어넣어줌과 동시에 cnt를 받아와 문자열로써 (isPalindrome(input[i])의결과)(띄어쓰기 한칸)(카운터의수) 를 한줄의 문자열로 저장해주었다. 
그리고 이것을 한줄씩 출력하게 되면 올바른 출력값이 나오게된다.

