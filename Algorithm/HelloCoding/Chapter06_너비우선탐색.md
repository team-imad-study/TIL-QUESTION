출제일 : 2024/04/18 (DAY 5) </br>
풀이일 : 2024/05/22 (DAY 6)

---

# [프로그래머스][1844번] 게임 맵 최단거리

> 출제자 : KUN </br>
> 풀이자 : NCookie

https://school.programmers.co.kr/learn/courses/30/lessons/1844

## 출제자 : KUN

### 코드
```javascript
function solution(maps) {
    
    const n = maps.length; //세로
    const m = maps[0].length; //가로
    const move = [[-1, 0], [1, 0], [0, -1], [0, 1]]; // 상하좌우 이동시 이동량
    
    const act = () => {
        const queue = [[0,0,1]] // [세로, 가로, 이동거리]  초기 설정
        maps[0][0] = 0;
        
        while(queue.length > 0){ // 큐의 길이가 0일아닐때까지 계속 실행
            let [column , row , distance] = queue.shift(); //  큐 한개 가져오기
            
            if(column == n -1 && row == m - 1){ //도착지점에 도착시 루프탈출
                return distance;
            }
            
            for (let [c, r] of move) { // 새로 이동한 위치 변경
                let newColumn = column + c;
                let newRow = row + r;
                
                if(newColumn >= 0 && // 새로운 세로 값이 0보다 클때 
                   newColumn < n && // 새로운 세로 값이 세로 최댓값인 n 보다 작을때 
                   newRow >= 0 &&  // 새로운 가로 값이 0보다 클때 
                   newRow < m &&  // 새로운 가로 값이 가로 최댓값인 m 보다 작을때 
                   maps[newColumn][newRow] === 1){ // 새로 구성한 세로 가로 의 좌표값이 0이 아닌 1일때 
                    queue.push([newColumn, newRow, distance + 1]); 
                    // 큐에 새로운 좌표와 1이 더해진 이동거리를 추가 
                    maps[newColumn][newRow] = 0;
                    // 큐에 추가후 더이상 기존에 이동했던 곳으로 다시 이동하는일이없도록 배열에서 0으로 치환
                    
                }
            }
        }
        return -1; // 최종 목표지점에 도달 못할시 -1 출력
    }
    const answer = act()
    return answer;
}
```


### 풀이
처음 문제를 보고 이차원 배열을 받아내었을때 좌표값 계산을 어떻게 해야하는지 이해가 되질않아서 고생했지만 알고보니 간단했다. 
가로값이 maps[0].length
세로값이 maps.length 이기에 
임의의 가로세로값 x, y 가주어졌을때 좌표값은 
maps[y][x] 가 된다. 
그이후는 bfs 문제로 풀기위해 큐를 추가해주고 큐에 이동거리인 distance 값을 추가로 넣어줘 계산을 쉽게 하였다. 
루프를 돌며 현재 위치에서 이동할 수 있는 방향들을 구해 큐에 추가하고 큐에 추가할때 마다 distance 에 + 1 을 더해줘 이동거리를 알아낼수있게 하였고 visited 배열을 추가하는대신 이미 방문한 좌표의 값을 0으로 바꾸어 한번더 다시 방문하는 일이 없게한게 포인트라고 할수있다.

## 풀이자 : NCookie

### 코드

```java
import java.util.LinkedList;
import java.util.Queue;

class Solution {
    static class Point {
        int x, y;

        public Point(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
    
    public int solution(int[][] maps) {
        int n = maps[0].length;  // 가로 길이
        int m = maps.length;     // 세로 길이
        
        // 현재 위치 기준 상, 우, 하, 좌의 좌표
        int[] dx = {-1, 0, 1, 0};
        int[] dy = {0, 1, 0, -1};

        // 다음으로 확인할 좌표 저장하는 큐
        Queue<Point> queue = new LinkedList<>();
        
        // 이동 거리를 저장하는 배열
        int[][] distance = new int[m][n];

        // 초기 설정
        queue.offer(new Point(0, 0));
        maps[0][0] = 0;
        distance[0][0] = 1;

        while (!queue.isEmpty()) {
            Point node = queue.poll();

            for (int i = 0; i < 4; i++) {
                int nowX = node.x + dx[i];
                int nowY = node.y + dy[i];

                // 다음 칸으로 이동할 수 있을 때
                if (nowX >= 0 && nowX < m
                        && nowY >= 0 && nowY < n
                        && maps[nowX][nowY] == 1) {
                    // 현재 좌표로 다시 오지 않도록 0으로 설정
                    maps[nowX][nowY] = 0;
                    
                    // 이동 거리 1 추가
                    distance[nowX][nowY] = distance[node.x][node.y] + 1;
                    
                    // 현재 좌표를 큐에 추가
                    queue.offer(new Point(nowX, nowY));
                }
            }
        }

        int answer = distance[m - 1][n - 1];
        return answer != 0 ? answer : -1;
    }
}
```

### 풀이

캐릭터는 현재 좌표에서 상하좌우 중 한 칸만 움직일 수 있다. 칸의 값이 0이면 막혀서 못 움직이고, 1일 때에만 움직일 수 있다.

루프를 돌며 현재 위치에서 움직일 수 있는 좌표를 구한다. 이미 방문했던 위치로는 다시 가지 않도록 한다. 이동한 위치의 이동 거리로 이전 좌표의 이동 거리에 1을 더한다.

BFS는 노드를 레벨 순서대로 탐색하고, 큐를 사용한다. 따라서 어떤 노드에 처음 도달했을 때 그 경로는 최단 경로가 된다. 만약 다른 경로가 발견된다 하더라도 그것은 같은 레벨의 노드에서 이어진 것이다. 방문했던 노드는 다시 방문하지 않기 때문에 BFS는 최단 거리를 보장한다.

---


# [백준][1697번] 숨바꼭질

> 출제자 : NCookie </br>
> 풀이자 : PCYSB

https://www.acmicpc.net/problem/1697

## 출제자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static int MAX_SIZE = 100000;
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());

        int n = Integer.parseInt(st.nextToken());
        int k = Integer.parseInt(st.nextToken());

        Map<Integer, List<Integer>> moveMap = new HashMap<>();
        int[] visited = new int[MAX_SIZE + 1];

        // 큐 생성
        Queue<Integer> queue = new LinkedList<>();
        
        // n번 노드부터 탐색 시작 및 간선 세팅
        queue.offer(n);
        moveMap.put(n, getMoveCase(n));
        visited[n] = 0;

        while (!queue.isEmpty()) {
            int node = queue.poll();

            if (node == k) {
                System.out.println(visited[node]);
                return;
            }

            for (int i = 0; i < moveMap.get(node).size(); i++) {
                int now = moveMap.get(node).get(i);

                if (now <= MAX_SIZE && now >= 0 && visited[now] == 0) {
                    // 현재 노드의 깊이 표시
                    visited[now] = visited[node] + 1;
                    
                    // 그래프 및 큐 추가
                    moveMap.put(now, getMoveCase(now));
                    queue.offer(now);
                }
            }
        }
    }

    static List<Integer> getMoveCase(int x) {
        // 특정 위치 x에 있을 때 갈 수 있는 경우는 x-1, x+1, x*2 뿐이다.
        return List.of(x - 1, x + 1, x * 2);
    }
}
```
### 풀이

위치 x에서 갈 수 있는 위치는 x - 1, x + 1, x * 2 이렇게 3곳 뿐이다. 따라서 노드 x에는 이 세 개의 노드가 연결되어 있고, 이들을 탐색하다 보면 n까지 도달할 수 있다.

문제는 탐색 깊이인데, 처음에는 이들이 깊이마다 *3만큼 늘어나기 때문에 이 규칙을 활용하려 했다. 그러나 찾아보니 더 간단한 방법이 있었다. 기존에 방문한 노드인지 확인하기 위해 사용했던 boolean[] visited 배열을 int[] visited로 만들고, 여기에 깊이를 할당하는 것이다.

이렇게 하면 문제를 너비 우선 탐색으로 풀 수 있다. 상위권 코드들을 보면 깊이 우선 탐색이 대부분이던데, 다음에 이를 배우면 다시 풀어봐야겠다.

## 풀이자 : PCYSB

### 코드
```java
fun main() {
    val (N, K) = readLine()!!.split(' ').map { it.toInt() }
    println(bfs(N, K))
}

private fun bfs(N: Int, K: Int): Int {
    val visited = BooleanArray(100001) // 방문 여부 기록 배열, 0~10만까지 사용가능
    val queue = LinkedList<Pair<Int, Int>>() //탐색큐
    queue.add(Pair(N, 0)); visited[N] = true //시작 위치와 소요 시간을 큐에 추가, 방문 기록 추가

    // 큐가 비어있지 않은 동안 탐색
    while (queue.isNotEmpty()) {
        val (point, time) = queue.poll() // 큐에서 현재 위치와 소요 시간을 꺼냄, 첫 위치는 N
        if (point == K) return time //현재 위치가 K인 경우 소요 시간 반환후 종료

        //현재 위치에서 +1 만큼 이동 가능한지와 +1 거리의 방문여부 체크후 이동
        if (checkRange(point + 1) && !visited[point + 1]) {
            queue.add(Pair(point + 1, time + 1)); visited[point + 1] = true
        }

        //현재 위치에서 -1 만큼 이동 가능한지와 -1 거리의 방문여부 체크후 이동
        if (checkRange(point - 1) && !visited[point - 1]) {
            queue.add(Pair(point - 1, time + 1)); visited[point - 1] = true
        }

        //현재 위치에서 *2 만큼 이동 가능한지와 *2 거리의 방문여부 체크후 이동
        if (checkRange(point * 2) && !visited[point * 2]) {
            queue.add(Pair(point * 2, time + 1)); visited[point * 2] = true
        }
    }
    return -1
}

private fun checkRange(x: Int) = x in 0..100000 //x의 범위가 0~십만까지의 범위에 있는지를 확인
```

### 풀이
수빈의 위치는 N, 동생의 위치는 K
수빈이는 위치가 X일 때 걷는다면 1초 후에 X-1, X+1로 이동
순간이동시에는 1초 후에 2*X의 위치로 이동

해당 코드에 1과 3이 입력되었다고 가정하였을 때

1. 
queue: [(1, 0)]
point = 1, time = 0
가능한 이동, 2, 0 2

queue.add(Pair(2, 1)) 
visited[2] = true

2.
queue: [(2, 1)]
point = 2, time = 1
가능한 이동, 3, 4

queue.add(Pair(3, 2))
queue.add(Pair(4, 2))

3.
queue: [(3, 2), (4, 2)]
point = 3, time = 2

끝 시간을 반환한다.

---

# [백준][2606번] 바이러스

> 출제자 : PCYSB </br>
> 풀이자 : Quarang

https://www.acmicpc.net/problem/2606

## 출제자 : PCYSB

### 코드
``` java
fun main() {
    val N = readLine()!!.toInt() // 총 컴퓨터의 수
    val C = readLine()!!.toInt() //연결된 컴퓨터 수
    val graph = mutableMapOf<Int, MutableList<Int>>()

    for (i in 0 until C){
        val (A, B) = readLine()!!.split(' ').map { it.toInt() }
        graph.computeIfAbsent(A) { mutableListOf() }.add(B)
        graph.computeIfAbsent(B) { mutableListOf() }.add(A)
    }
    val infectedCount = bfs2606(graph, 1)
    println(infectedCount)



}

fun bfs2606(graph: Map<Int, List<Int>>, start: Int): Int{
    val visited = mutableListOf<Int>()
    var queue:Queue<Int> = LinkedList()
    queue.add(start)
    visited.add(start)

    while (queue.isNotEmpty()){
        val node = queue.poll() //큐에 있는 내용을 제거함

        for (neighbor in graph[node] ?: emptyList()){
            if (neighbor !in visited){
                visited.add(neighbor)
                queue.add(neighbor)
            }
        }
    }

    return visited.size-1

}
```

### 풀이
해당 문제는 서로 연결되어 있는가가 가장 중요한 문제이기 때문에
각 노드간의 연결만을 확실하게 해준다면 쉽게 풀 수 있다.

우선 
graph.computeIfAbsent(A) { mutableListOf() }.add(B)
graph.computeIfAbsent(B) { mutableListOf() }.add(A)
해당 부분을 통해 각 노드들을 연결하여 준다.
이후에는 일반적인 BFS 방식을 통하여 리스트에 감염된 컴퓨터들의 목록을 나열하고
해당 리스트의 크기를 리턴해준다.

## 풀이자 : Quarang

### 코드
```swift
let num = Int(readLine()!)!     //7
    let pairs = Int(readLine()!)!       //6
    var graph = [[Int]](repeating: [], count: num + 1)      //
    var visited = [Bool](repeating: false, count: num + 1)      //

    (0..<pairs).forEach{ _ in
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        graph[input[0]].append(input[1])
        graph[input[1]].append(input[0])
    }
    
    func bfs(start: Int) {
        var queue = [start]     
        var index = 0
        visited[start] = true
        
        while queue.count > index {
            for nextNode in graph[queue[index]] {
                if !visited[nextNode] {
                    visited[nextNode] = true
                    queue.append(nextNode)
                }
            }
            index += 1
        }
    }
    bfs(start: 1)
    print(visited.filter { $0 }.count - 1)
```

### 풀이

```
해당 문제는 그래프의 노드와 간선갯수를 입력받고 데이터를 입력받아 그래프를 만든 뒤에
1번과 연결된 모든 노드의 갯수를 출력하는 문제(단 1번은 제외하고)
풀이 방법은 너비우선 탐색알고리즘(BFS)을 사용했고, 시간복잡도는 O(V+E)가 나오게 된다.
```

> 힌트
- 여기서 차별화된 점은 항상 노드들은 1...N형태라는 것임
- 그말은 즉, 딕셔너리를 사용해서 해당 값들의 키를 따로 지정해주지 않아도 index로 배열을 사용할 수 있다는 것임.(항상 1씩 차이나는 배열이 index값을 대신하여 사용할 수 있다는 이점 존재)

> 과정

1. 문제 처럼 값을 모두 입력 받음
2. 입력받은 데이터들을 그래프형태로 만드는 과정을 통해 특정 요소와 같은 index에 연결된 데이터들을 모두 저장
3. 그럼 그래프의 해당 인덱스값을 가진 그래프의 요소안에는 해당 요소와 연결된 다른 요소들이 저장되게 됨 ( ex)[[2,5][1,2,3,5]] )
4. 문제의 기준은 1번어기 때문에 1을 가진채로 bfs함수를 진행 시킴
5. 한번 조회한 값을 visited함수에 저장 시키며 요소들을 모두 검색해 결국 더이상 검색할 수 없을때까지(1이 연결된 모든 노드를 찾을 때까지)계속 탐섹을 진행
6. 마지막까지 방문되지 않은 visited배열의 요소를 제외한 상태로 갯수를 새서 -1을 하여 출력
7. -1은 1번 요소도 포함되어있기 때문

---


# [프로그래머스][43163번] 단어변환

> 출제자 : Quarang </br>
> 풀이자 : KUN

https://school.programmers.co.kr/learn/courses/30/lessons/43163

## 출제자 : Quarang

### 코드
```swift
func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
    func bfs() -> Int {
        var queue = [begin]
        var compare = [begin]
        var count = 0
        while !queue.isEmpty {
            let size = queue.count
            let node = queue.removeLast()
            guard node != target else{ return count }
            
            (0..<size).forEach { _ in
                words.forEach { word in
                    var diff = 0
                    zip(node, word).forEach { if $0 != $1 { diff += 1 } }  //글자 수 비교 1개의 글자가 다를때까지
                    if diff == 1 && !compare.contains(word){ //글자가 한개가 다르거나 임시 저장배열에 현재 배열이 존재하지 않을 경우
                        queue.append(word)  //큐에 현재 데이터 추가
                        compare.append(word)    //임시저장 배열에 현재 데이터 추가
                    }
                }
            }
            count += 1  //횟수 추가
        }
        return 0
    }
    return bfs()
}
```
### 풀이

```
해당 문제는 시작글자에서 타겟글자까지 한글자씩 변형시켜서 총 단계별로 1글자 씩만 변화한 횟수를 출력하는 문제다.
만약 한번도 변환하지 못했다면 0을 출력한다.
풀이 방법은 너비우선 탐색알고리즘(BFS)을 사용했고, 시간복잡도는 O(V+E)가 나오게 된다.
```

> 구현과정

1. bfs함수를 생성
2. 함수의 루프를 실행시키기 위한 실질적 `큐`를 생성하고 시작값을 추가
3. 큐는 값이 가변적임으로 지금까지 검사한 값을 저장할 compare변수를 생성 시작값을 추가
4. 큐가 완전히 비어있을때까지 루프는 돌아감
5. 큐의 사이즈와 큐의 가장 마지막 요소를 추출
6. 만약 노드가 타겟이랑 같을 경우 사전에 준비한 count(횟수) 변수 반환
7. 0부터 큐의 사이즈까지 루프 돌림
8. 입력 받은 배열을 하나씩 돌려 해당 요소의 값이 추출한 값과 1개의 글자갯수 차이가 나고 저장배열에 현재배열이 존재하지 않을 경우 큐와 비교배열에 해당 글자를 추가
9. 마지막으로 count를 1개 증가 시킴

위 과정의 반복문을 반복할 경우 횟수가 계산되어 출력됨

## 풀이자 : KUN

### 코드
```javascript
function solution(begin, target, words) {
    
    let visited = []; // 이미 방문한 애들 담아놓을 변수 생성
    let queue = []; // 큐 배열 만들기 
    
    if(!words.includes(target)){
       return 0; // words 배열에 target 이 없다면 그냥 바로 0 출력 
    }
    
    queue.push([begin, 0]); // 큐에 초기값 집어넣기
    
    while(queue.length > 0){
        let [str, cnt] = queue.shift(); // 큐값 하나 꺼내오기 
        
        if(str === target){ // 가져온값이 target 이 맞다면 루프탈출 cnt 출력
            return cnt
        }
        
        for(let i = 0; i < words.length; i++){
            let wrongText = 0 // 다른 글자의 갯수를 저장할 변수 생성
            
            if(visited.includes(words[i])){
                continue; // words[i] 가 이미 visited 배열에 있는 단어라면 건너뜀
            }
            for(let j = 0; j < words[i].length; j++){
                if (words[i][j] !== str[j]){
                    // words[i][j] 와 str[j] 를 비교함 반복문에 의해서 한글자씩 비교됨
                    wrongText += 1 
                    // 다른글자라면 wrongText에 +1
                }
                
                }
            if(wrongText === 1){ // 틀린글자가 1개라면 노드끼리 이어진 거라고보고 
                    queue.push([words[i], cnt + 1]) // 큐에 단어와 카운터에 +1 해서 넣어줌
                    visited.push(words[i]) // visited 배열에 해당단어를 넣어 이미 방문했음을 알림
            }
        }
    }
    
    
}
```

### 풀이

문제를 이해해보니 begin 문자열과 words에 들어있는 문자열들을 비교했을때 한글자씩만 달라야 바꿀수있고 words 배열에 없는 문자열로는 변환을 할수없다는걸 알았다. 이를 구현하기 위해 첫번째로 words 배열안에  target 에 해당하는 단어가 없다면 도달할수없는 문제니 0을출력해주었고 루프문안에 루프문을 만들어 words[i][j] 와 str[j] 를 비교해 각각 한글자씩 비교하는 방법을 사용하였다 비교해서 서로 다른 문자라면 
wrongText 라는 변수에 +1 씩을 해주고 있기에 루프문을 돌았을때 wrongText가 1 이라면 큐배열에 들어있는 문자열과 해당문자열이 한글자만 다른 문자열인게 되므로 해당문자열을 다음 큐에 추가해줌과 동시에 cnt 카운터를 +1 해준다. 그이후 visited 배열에 문자를 추가해줌으로써 다시 방문하는 일이 없게 하였고 target 문자열에 도달하면 cnt를 리턴해줘 답으로 제출한다.


---
