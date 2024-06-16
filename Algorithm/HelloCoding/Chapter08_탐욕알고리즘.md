출제일 : 2024/05/31 (DAY 8) </br>
풀이일 : 2024/06/03 (DAY 9)

---

# [프로그래머스][42883번] 큰 수 만들기

> 출제자 : Quarnag </br>
> 풀이자 : KUN

https://school.programmers.co.kr/learn/courses/30/lessons/42883

## 출제자 : Quarang

### 코드
```swift
func solution(_ number:String, _ k:Int) -> String {
        let numArr = number.compactMap{ $0.wholeNumberValue }
        var answer = [Int]()
        var k1 = k

        for i in 0..<number.count {
            while k1 > 0, !answer.isEmpty, answer.last! < numArr[i] {
                answer.removeLast()
                k1 -= 1
            }
            if k1 <= 0 {
                answer.append(contentsOf: numArr[i...])
                break
            } else {
                answer.append(numArr[i])
            }
        }
        return String(answer.map{ String($0) }.joined().prefix(number.count-k))
    }
```

### 풀이
```
위 문제는 입력된 문자열에서 k번 숫자를 제거하여, 만들 수 있는 값 중 가장 큰 값을 출력하는 문제
입력 배열의 크기 만큼 루프가 실행 되기 때문에 시간 복잡도는 O(N)으로 예상
```
> 과정
1. 입력 된 문자열을 정수 배열 형태로 변환
2. 출력할 정수 배열을 선언
3. 처음에 입력한 k를 재정의(변수와 상수를 분리)
4. 정수 배열의 크기 만큼 루프 실행
    4 - 1. 만약 K1 > 0(아직 문자를 모두 제거하지 않았을 경우)이고, 정답 배열이 비어있지 않고(처음 값 제외), 배열의 마지막 값이 현재 루프의 인덱스 보다 작을 경우(앞 수가 뒷수보다 작을 경우)
    4 - 2. answer배열의 마지막을 삭제하고 카운트를 감소
    4 - 3. 만약 루프가 도는 중에 K1의 값이 0이 되었다면 아직 검사할 수를 모두 정답배열에 추가(뒤에를 검사할 필요가 없어졌기 때문)
    4 - 4. 아닐 경우 answer배열에 값을 하나씩 추가하고 반복
5. 정수형 배열인 answer를 다시 문자열로 만들어 준 뒤 중복 값 추가 방지를 위해 배열길이의 k를 뺀 수 만큼 앞을 제거함


## 풀이자 : KUN

### 코드
```javascript
function solution(number, k) {
  const stack = []; // 스택 배열 추가 

  for (const num of number) { // nuber의 갯수만큼 반복
    while (k > 0 && stack[stack.length - 1] < num) {
        // k 가 0보다 클때 스택의 마지막요소가 현재 돌고있는 숫자보다 작을때 
      stack.pop(); //마지막 요소 제거
      k--; // k 마이너스해줌
    }
    stack.push(num); // 그렇지 않을경우 스택에 추가 
  }

  stack.splice(stack.length - k, k);// 제거해야하는 k 가 다돌고나와도 0보다 클때 splice를 이용해 스택 의 뒤 k번째 부터 k만큼 제거

  return stack.join(""); //정답 리턴
}
```
### 풀이
처음 문제를 풀기시작했을땐 단순히 주어진 숫자들을 루프돌며 현재숫자보다 이후에 나올 숫자보다 작으면 현재숫자를 제거하면 될거라고 생각해 그렇게 구현하니 시간초과가 나버렸다. 그래서 
스택을 이용해서 푼다고 하기에 나도 스택을 사용해 풀어보기로 하였다.
스택을 배열을 사용해 구현 해주고 nuber를 루프로 돌며 제거해야하는 숫자의 갯수 k 가 0보다 클때 && 스택의 마지막 요소가 지금 돌고있는 숫자보다 작을때 스택의 마지막 요소를 제거하고 숫자를 한개 제거했으니 k-- 를 해준다. 
그렇지 않을 경우엔 스택에 현재 숫자를 추가하여 반복문을 반복할수있도록 해준다.
이렇게해서 전체의 숫자를 돌고난후에도 k가 아직 남아있을경우가 있을수 있기에 
그럴경우 k의 갯수만큼 스택의 뒷부분부터 제거해준다.

---

# [프로그래머스][42860번] 조이스틱

> 출제자 : KUN </br>
> 풀이자 : NCookie

https://school.programmers.co.kr/learn/courses/30/lessons/42860

## 출제자 : KUN

### 코드
```javascript
function solution(name) {
  var answer = 0;
      //처음부터 순서대로 오른쪽으로 움직였을때의 최솟값
  let min = name.length - 1;

  for (let i = 0; i < name.length; i++) {
    let currentAlPhabet = name.charCodeAt(i); 
      // 루프문을 돌며 현재 인덱스의 알파뱃을 아스키코드로 가져옴
      // 총알파뱃 갯수 26개중 중간점인 N 보다 작으면(A~M)
    if (currentAlPhabet < 78) {  // N의 아스키코드 78
      answer += currentAlPhabet - 65; 
        //알파벳의 아스키코드에서 A의 아스키코드 만큼 빼줌 A일경우 0
    } else {
      // N보다 크거나 같으면(N~Z)
      // Z의 아스키 코드 90 에서 알파뱃의 아스키코드만큼 빼줌
      // A에서 Z로 이동할때 한번만큼의 이동이 필요하니 1을더함
      answer += 90 - currentAlPhabet + 1; 
    }

    
    let nextIndex = i + 1;

    // 현재알파벳이 마지막 알파벳이 될 때까지 && 다음알파벳으로 A가 나올때까지 nextIndex += 1
    // nextIndex가 A가 아니면 넘어가고, nextIndex에 A가 나온다면 nextIndex += 1을 하여 A의 다음 인덱스도 A인지 확인한다.
    
    while (nextIndex < name.length && name.charCodeAt(nextIndex) === 65) {
      nextIndex += 1;
    }

    // length - nextIndex는 뒤로 쭉 갔을 때의 길이(A를 통과해서 갔을 때).
    min = Math.min(
      min, // 오른쪽으로만 이동하는경우
      i * 2 + name.length - nextIndex, 
        // A를 기준으로 왼쪽먼져 처리하고 반대로 넘어가기
        // A를 기준으로 왼쪽 알파벳수가 오른쪽 알파벳수보다 적을때 최솟값
        // `A` 앞의 알파벳 수 => i
        // 왔다갔다 해야하는 횟수 => 2
        // `A` 뒤의 알파벳 수 => name.length - nextIndex
      i + (name.length - nextIndex) * 2 
        // 처음부터 반대로 넘어가기
        // A를 기준으로 왼쪽 알파벳수가 오른쪽 알파벳수보다 많을때 최솟값
        // `A` 앞의 알파벳 수 => i
        // `A` 뒤의 알파벳 수 => name.length - nextIndex
        // 왔다갔다 해야하는 횟수 => 2
    ); // 이 세 요소들중 최솟값을 가져옴
  }
  answer += min; // 알파벳의 이동횟수와 커서의 이동횟수를 더함
  return answer; // 출력
}
```

### 풀이
이문제에서 중요한것은 문자를 수정할때의 이동횟수가 아닌 커서를 움직일때의 이동횟수를 구하는것이 관건 이였다.
문자열은 아스키 코드를 사용해 가운데 알파벳인 n 을 기준으로 n보다 크면 아랫방향으로 움직이도록 n보다 작으면 a부터 정방향으로 움직이도록 해서 이동거리를 계산하면된다

하지만 커서를 이동시키는것은 세가지의 경우가 있다.

커서의 기초위치는 첫번째칸이다.

1. 기초위치부터 끝까지 정방향으로만 이동하는경우

2. 중간에 a 가 있는경우 a 기준 왼쪽부터 이동했다가 뒤로 돌아 반댓방향으로 진행하는경우

3. 중간에 a 가 있는경우 처음부터 뒷방향으로 갔다가 왼쪽으로 다시 돌아오는경우

위 세가지 경우를 각각 현재 코드로 구현하면

1. name.length - 1

2. i * 2 + name.length - nextIndex

3. i + (name.length - nextIndex) * 2

이렇게 구현할수있었다. 
nextIndex는 연속된 A 의 마지막 인덱스를 가르킨다.

이세가지 경우중 최솟값을 구해내서 기존 알파벳 이동횟수계산에 더해줘 리턴을 해줬다.

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
```swift
func solution(_ people: [Int], _ limit: Int) -> Int {
        var people = people.sorted()
        var result = 0
        var start = 0
        var end = people.count - 1
        
        while start <= end {
            if people[start] + people[end] <= limit {
                start += 1
                end -= 1
            } else {
                end -= 1
            }
            result += 1
        }
        return result
    }
```

### 풀이
```
위 문제는 사람수와 최대 무게를 입력 받아 최대한 적은 횟수로 사람을 보트로 옮길 수 있는 값을 구하는 문제
배열의 첫과 끝을 같이 검사하며 루프가 진행 됨으로 최대 n,최소 n/2번 동작함으로 시간복잡도는 O(N)으로 예상
```
> 과정
1. 무게가 가장 무거운 사람과 가벼운 사람을 함께 비교해야함으로 무게가 가벼운 사람부터 오름차순으로 정렬
2. 횟수를 세기 위해 result를 0으로 초기화
3. 시작과 마지막 index를 비교하기 위해 각각 자릿값 초기화
4. start와 end가 엇갈리는 순간 까지 반복
    4 - 1. 만약 가장 가벼운 사람과 가장 무거운 사람의 합이 구명보트의 한계점도가 작거나 같으 경우 보트를 두명이서 탑승할 수 있음으로, 양쪽 한명씩 제거
    4 - 2. 만약 아니면 가장 무거운 사람만 탑승 
    4 - 3. 위의 조건에 따라 2명 혹은 1명이 사라지고 보트를 운반한 횟수 카운트
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
