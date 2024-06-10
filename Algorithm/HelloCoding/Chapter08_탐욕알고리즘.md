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
```java
import java.util.*;

class Solution {
    public int solution(int[] people, int limit) {
        int answer = 0;
        int index = 0;
         Arrays.sort(people);
        
        for (int i = people.length -1; i >= index; i--){
            if(people[i] + people[index] <= limit){
                answer++;
                index++;
            }
            else{
                answer++;
            }
        }
        
        return answer;
    }
}
```

### 풀이
구명 보트에 한 번에 최대 2명씩이라는 조건이 붙어 있기에 해당 문제는 손쉽게 풀 수 있다.
가장 무거운 사람과 가장 가벼운 사람의 무게를 더했을 때 제한 무게를 넘지 않는다면 answer을 1씩 올리고 for문의 탈출 주기도 -1만큼 해준다.
만약 무게를 더했을 때 제한 무게를 초과 한다면 answer을 1 올리고 for문의 탈출 주기를 수정하지 않는다.

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
``` java
fun main() {
    val calculate = readLine().toString()
    //1. 문자열 추출
    val regex = Regex("([-+])")
    val tokens = calculate.split(regex).filter { it.isNotEmpty() } // 숫자만을 추출
    val operators = regex.findAll(calculate).map { it.value }.toList()// 문자만을 추출
    val firstNumber = tokens[0].toInt() //가장 처음 분리한 숫자

    val numbers = IntArray(tokens.size) //변환된 숫자
    numbers[0] = firstNumber

    for (i in 1 until tokens.size) {
        numbers[i] = tokens[i].toInt()
    }



    for (i in 0 until operators.size) {
        var op = operators[i] // 연산자
        if (op == "-") {
            greedy(numbers, i + 1)
            return
        }
    }
    greedy(numbers, 100)

}

fun greedy(numbers: IntArray, i: Int) {
    var result: Int = numbers[0] //결과값
    var aaa: Boolean = false
    for (j in 1 until numbers.size) {
        // 처음 숫자부터 더하다가, -가 나온 이후에는 모든 숫자를 음수로 변경한다.
        if (j == i) {
            aaa = true
        }
        if (aaa) {
            result -= numbers[j]
        } else result += numbers[j]

    }
    println(result)

}
```

### 풀이
1. 일단 입력을 String 형식으로 받기 때문에 숫자와 연산자를 분리해 주어야 한다.
- 가장 처음과 마지막 문자는 숫자이기 때문에 처음의 문자는 무조건 양수가 나옴을 알 수 있다.
- 첫 번째 숫자에는 기호가 없기 때문에 자연스럽게 숫자 배열과 연산자 리스트의 크기는 1이 차이 남을 알 수 있다.
- 그래서 첫 번째 부호만을 따로 저장하고 나머지는 for문을 통해서 저장한다.

2. 가장 작은 수를 만들어 내는 것은 결국 -의 유무이기 때문에 -가 나온 순간 부터는 모든 수를 빼서 더하기 시작하게 하면 된다.
- 연산자를 검사하여 "-"가 나올 시에는 greedy함수를 호출한다.(i+1의 경우에는 연산자는 숫자를 기준으로 1번 인덱스부터 시작되기 때문)
- 0번 인덱스의 요소부터 하나씩 더 하다가 "-"가 나왔다면 aaa 변수를 true로 바꾸고 이후의 모든 수는 빼기 시작한다.

3. 만약 -가 하나도 없는 경우에는 그냥 더하기를 진행한다.
- 이 경우 조건중 식의 길이는 50보다 작거나 같다고 하는 조건이 있기 때문에 조건에 부합하지 않는 큰 수를 greedy 함수에 넣어 true가 되지 못하게 막아 놓았다.


---
