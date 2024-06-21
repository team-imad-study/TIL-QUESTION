출제일 : 2024/05/27 (DAY 7) </br>
풀이일 : 2024/05/31 (DAY 8)

---

# [백준][1719번] 택배

> 출제자 : Quarang</br>
> 풀이자 : PCYSB

https://www.acmicpc.net/problem/1719

## 출제자 : Quarang

### 코드

```swift
let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let m = input[1]
    var graph = [[(Int, Int)]](repeating: [], count: n + 1)

    for _ in 0..<m {
        let edge = readLine()!.split(separator: " ").map { Int($0)! }
        graph[edge[0]].append((edge[2], edge[1]))
        graph[edge[1]].append((edge[2], edge[0]))
    }

    for i in 1...n {
        dijkstra(start: i, n: n, graph: graph)
    }
    func dijkstra(start: Int, n: Int, graph: [[(Int, Int)]]) {
        var parents = [Int](repeating: 0, count: n + 1)
        for i in 1...n {
            parents[i] = i
        }
        var distance = [Int](repeating: 10001, count: n + 1)
        distance[start] = 0
        
        var pq = [(Int, Int)]()
        pq.append((0, start))
        
        while !pq.isEmpty {
            pq.sort { $0.0 > $1.0 }
            let (currCost, currPos) = pq.removeLast()
            
            if distance[currPos] < currCost {
                continue
            }
            
            for next in graph[currPos] {
                let (nextCost, nextPos) = next
                if currCost + nextCost < distance[nextPos] {
                    pq.append((currCost + nextCost, nextPos))
                    distance[nextPos] = currCost + nextCost
                    parents[nextPos] = currPos
                }
            }
        }
        
        for i in 1...n {
            if i == start {
                print("-", terminator: " ")
            } else {
                var curr = i
                while parents[curr] != start {
                    curr = parents[curr]
                }
                print(curr, terminator: " ")
            }
        }
        print()
    }
```
### 풀이
```
해당 문제는 다익스트라 알고리즘으로 모든 노드의 최단 경로를 출력하는 문제
기본적인 다익스트라 문제로 응용부분은 없는 것으로 생각
모든 간선을 조사해야하기 때문에 기존 시간복잡도인 𝑂(𝐸𝑙𝑜𝑔𝐸)에 노드 갯수인 V를 곱해
𝑂(V𝐸𝑙𝑜𝑔𝐸)가 나오는 것으로 추정
```

> 과정
1. 노드와 노드 사이에 간선의 가중치를 튜플 형태로 추가
2. 부모 노드를 저장할 배열 생성하고 0으로 초기화
3. 각 인덱스에 인덱스 주소값을 저장
4. 경로 저장 배열이 담겨 있는 배열을 생성하고 가장 큰 값인 정수를 저장
5. 시작점은 항상 0으로 초기화
6. 다익스트라를 액션을 취할 우선순위 큐 생성 후 가장 처음 시작할 노드와 노드의 값을 enqueue
7. 우선순위 큐가 빌 때까지 반복
8. 우선순위 큐를 사용하기 때문에, 항상 힙의 값 기준으로 오름차순으로 정렬
9. 큐의 성질로 인해 가장 처음 값을 dequeue
10. 경로 저장 배열의 특정 노드 값이 가중치보다 작을 경우 아무런 이벤트를 하지 않고 다음 루프 실행
11. 그래프에 현재 노드와 연결된 모든 노드의 값들로 루프를 실행
12. 인접 노드와의 거리와 노드이름을 추출
13. 인접 노드 + 가중치가 배열 저장 값보다 작을 경우
14. 우선순위큐에 인접 노드 + 가중치값과 인접노드를 저장함
15. 경로 저장 배열의 특정 배열에 가중치를 저장
16. 부모 배열에는 현재 노드를 저장
17. 만약 시작점과 현제 노드가 같다면 "-"를 출력하고 아닐 경우 아닐때까지 현재 값을 출력

## 풀이자 : PCYSB

### 코드
```java
fun main() {
    val (N, M) = readLine()!!.split(' ').map { it.toInt() } 
    var arr = Array(N + 1) { IntArray(N + 1) { 10000 } } 
    var result = Array(N + 1) { IntArray(N + 1) { 0 } } 


    repeat(M) {

        val (A, B, C) = readLine()!!.split(' ').map { it.toInt() }
        arr[A][B] = C 
        arr[B][A] = C 
        result[A][B] = B 
        result[B][A] = A
    }

    for (i in 1..N) {
        di(arr, i, result)
    }

    for (i in 1..N) {
        for (j in 1..N) {
            if (result[i][j] != 0) print("${result[i][j]} ")
            else print("- ")
        }
        println()
    }

}

fun di(arr: Array<IntArray>, K: Int, result: Array<IntArray>) {
    var distance = arr[K] 
    distance[K] = 0 
    result[K][K] = 0

    for (i in 1 until distance.size) {
        for (j in 1 until distance.size) {
            if (arr[i][j] > arr[i][K] + arr[K][j]) { 
                arr[i][j] = arr[i][K] + arr[K][j] 
                result[i][j] = result[i][K] 
            }
        }
    }
}

```

### 풀이
우리는 세 가지를 생각해야 한다.
1. 출발지
2. 경유지
3. 도착지
출발지를 i, 경유지를 k, 도착지를 j라고 생각하면 i -> k -> j 이렇게 될 것이다.
k와 j는 같을 수도 있을 것이다. (경유지 없이 바로 갈 수있는 경우)

해당 부분을 식으로 만들면 아래와 같을 것이다.
[ i ] [ j ] = [ i ] [ k ] + [ k ] [ j ] (가중치)

[ i ] [ j ] = [ i ] [ k ] (경유지)

가중치를 저장하는 배열과 경유지를 저장하는 배열을 각각 하나씩 만들어 일반적인 가중치를 비교하는 방법을 사용함과 동시에 경유지만을 저장하면 문제를 풀어낼 수 있다.


---

# [백준][1753번] 최단경로

https://www.acmicpc.net/problem/1753

> 출제자 : PCYSB</br>
> 풀이자 : KUN

https://www.acmicpc.net/problem/1753

## 출제자 : PCYSB

### 코드


### 풀이

## 풀이자 : KUN

### 코드
```javascript
const fs = require("fs");
const input = fs.readFileSync("/dev/stdin").toString().split("\n");

const [v, e] = input.shift().split(" ").map(Number);
const start = +input.shift();
const graph = new Map<number, { node: number; distance: number }[]>();

// 그래프 초기화
for (let i = 1; i <= v; i++) {
  graph.set(i, []);
}

for (const line of input) {
  const [from, to, weight] = line.split(" ").map(Number);
  graph.get(from)?.push({ node: to, distance: weight });
}

class MinHeap {
  heap: { node: number; distance: number }[]; // 힙을 저장할 배열

  constructor() {
    this.heap = []; // 힙 초기화
  }

  insert(node: number, distance: number) {
    this.heap.push({ node, distance }); // 새로운 요소를 힙의 끝에 추가
    this.bubbleUp(); // 힙 속성을 유지하기 위해 위로 올림
  }

  extractMin() {
    const min = this.heap[0]; // 힙의 루트 요소 (가장 작은 값)
    const end = this.heap.pop(); // 힙의 마지막 요소를 꺼냄
    if (this.heap.length > 0 && end) {
      // 힙에 남은 요소가 있다면
      this.heap[0] = end; // 루트에 마지막 요소를 배치
      this.bubbleDown(); // 힙 속성을 유지하기 위해 아래로 내림
    }
    return min; // 가장 작은 값을 반환
  }

  bubbleUp() {
    let index = this.heap.length - 1; // 새로 추가된 요소의 인덱스
    const element = this.heap[index]; // 새로 추가된 요소

    while (index > 0) {
      let parentIndex = Math.floor((index - 1) / 2); // 부모 노드의 인덱스
      let parent = this.heap[parentIndex]; // 부모 노드

      if (element.distance >= parent.distance) break; // 부모 노드가 더 작거나 같으면 종료

      this.heap[index] = parent; // 부모 노드를 현재 위치로 이동
      this.heap[parentIndex] = element; // 새 요소를 부모 위치로 이동
      index = parentIndex; // 인덱스를 부모 위치로 갱신
    }
  }

  bubbleDown() {
    let index = 0; // 루트부터 시작
    const length = this.heap.length; // 힙의 길이
    const element = this.heap[0]; // 루트 요소

    while (true) {
      let leftChildIndex = 2 * index + 1; // 왼쪽 자식의 인덱스
      let rightChildIndex = 2 * index + 2; // 오른쪽 자식의 인덱스
      let leftChild, rightChild;
      let swap = null; // 교환할 위치

      if (leftChildIndex < length) {
        leftChild = this.heap[leftChildIndex]; // 왼쪽 자식
        if (leftChild.distance < element.distance) {
          swap = leftChildIndex; // 왼쪽 자식이 더 작다면 교환 대상 설정
        }
      }

      if (rightChildIndex < length) {
        rightChild = this.heap[rightChildIndex]; // 오른쪽 자식
        if (
          (swap === null && rightChild.distance < element.distance) || // 오른쪽 자식이 더 작다면
          (swap !== null && rightChild.distance < leftChild!.distance) // 교환 대상이 없거나 오른쪽 자식이 더 작다면
        ) {
          swap = rightChildIndex; // 교환 대상 설정
        }
      }

      if (swap === null) break; // 교환 대상이 없으면 종료

      this.heap[index] = this.heap[swap]; // 교환 대상과 위치 변경
      this.heap[swap] = element; // 현재 요소를 교환 위치로 이동
      index = swap; // 인덱스를 교환 위치로 갱신
    }
  }

  isEmpty() {
    return this.heap.length === 0; // 힙이 비었는지 확인
  }
}

function dijkstra(
  start: number,
  graph: Map<number, { node: number; distance: number }[]>,
  v: number
) {
  const distances = Array(v + 1).fill(Infinity); // 거리를 무한대로 초기화
  distances[start] = 0; // 시작점의 거리는 0

  const minHeap = new MinHeap(); // 최소 힙 생성
  minHeap.insert(start, 0); // 시작점을 최소 힙에 삽입

  while (!minHeap.isEmpty()) {
    const { node, distance } = minHeap.extractMin(); // 최소 거리의 노드 추출

    if (distances[node] < distance) continue; // 이미 최소 거리가 아니라면 스킵

    for (const neighbor of graph.get(node)!) {
      const cost = distance + neighbor.distance; // 현재 거리와 이웃 노드의 거리를 더함
      if (cost < distances[neighbor.node]) {
        // 이웃 노드로 가는 거리가 더 짧다면
        distances[neighbor.node] = cost; // 거리 갱신
        minHeap.insert(neighbor.node, cost); // 최소 힙에 삽입
      }
    }
  }

  return distances.slice(1); // 시작점은 포함하지 않으므로 잘라서 반환
}

const answer = dijkstra(start, graph, v);

console.log(answer.map((i) => (i === Infinity ? "INF" : i)).join("\n"));
```

### 풀이
매우 간단하고 기초적인 다익스트라 알고리즘 문제였지만 javascript 내장 함수에 최소힙 최대힙 생성기능이 없기에 
라이브러리를 직접 구현하느라 코드가 길어졌다.
최소힙 구현을 제외한 다익스트라 알고리즘의 기본 구현은 

1. 거리를 저장할 배열 생성 기본값은 Infinity로 갯수만큼 전부 채워넣어준다.
2. 시작점의 거리는 0으로 바꿈
3. 최소힙배열을 생성하고 시작점을 삽입
4. 최소힙 배열의 길이가 0이 될때까지 반복문 실행
5. 최소힙 배열에서 최소값을 가지고와서 이미 최소거리가 아니라면 스킵
6. 그렇지 않을경우 그래프에서 이웃노드들을 가지고와 현재거리와 이웃노드의 거리를 더함
7. 이웃노드로 가는 거리가 더 짧다면 거리를 갱신하고 최소힙에 삽입
8. 큐가 없어질때까지 반복


---

# [백준][2665번] 미로만들기

> 출제자 : NCookie</br>
> 풀이자 : Quarang

https://www.acmicpc.net/problem/2665

## 출제자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

public class Main {
    static int n;

    static int[][] map;
    static int[][] dist;

    static class Point {
        int x, y;

        public Point(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        n = Integer.parseInt(br.readLine());

        map = new int[n][n];
        dist = new int[n][n];

        for (int i = 0; i < n; i++) {
            String s = br.readLine();
            for (int j = 0; j < n; j++) {
                map[i][j] = s.charAt(j) - '0';
                dist[i][j] = Integer.MAX_VALUE;
            }
        }

        dijkstra();
        System.out.println(dist[n - 1][n - 1]);
    }

    private static void dijkstra() {
        int[] dx = {-1, 0, 1, 0};
        int[] dy = {0, 1, 0, -1};

        Queue<Point> q = new LinkedList<>();
        q.offer(new Point(0, 0));
        dist[0][0] = 0;

        while (!q.isEmpty()) {
            Point cur = q.poll();

            for (int i = 0; i < 4; i++) {
                int nx = cur.x + dx[i];
                int ny = cur.y + dy[i];

                // 좌표가 유효한지 확인
                if (nx >= 0 && nx < n && ny >= 0 && ny < n) {
                    // 현재 경로가 최단 거리가 아니라면 갱신하지 않는다.
                    if (dist[cur.x][cur.y] < dist[nx][ny]) {
                        // 다음 위치가 흰 방이라면 변경 횟수는 증가하지 않음
                        if (map[nx][ny] == 1) {
                            dist[nx][ny] = dist[cur.x][cur.y];
                        } else {
                            // 다음 위치가 검은 방이라면 변경 횟수 증가
                            dist[nx][ny] = dist[cur.x][cur.y] + 1;
                        }
                        q.offer(new Point(nx, ny));
                    }
                }
            }
        }
    }
}
```

### 풀이

BFS + 다익스트라를 활용하여 풀었다.

BFS를 사용하여 모든 경로를 탐색하면서 검은 방을 만날 때마다 흰 방으로의 변경 횟수를 1 증가시킨다. 만약 이동하려는 좌표가 현재 위치까지의 이동거리보다 작으면 경로를 갱신하지 않는다. (다익스트라)

## 풀이자 : Quarang

### 코드
```swift
let N = Int(readLine()!)!   
var graph = [[Int]]()       

(0..<N).forEach { _ in
    let row = readLine()!.compactMap { Int(String($0)) }
    graph.append(row)
}

var visit = Array(repeating: Array(repeating: 0, count: N), count: N)
visit[0][0] = 1

let dx = [1, -1, 0, 0]
let dy = [0, 0, -1, 1]

func dijkstra() {
    var heap = [(Int, Int, Int)]()
    heap.append((0, 0, 0))
    
    while !heap.isEmpty {
        heap.sort { $0.0 < $1.0 }
        let (cnt, x, y) = heap.removeFirst()
        
        if x == N - 1, y == N - 1 {
            print(cnt)
            return
        }
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if (0..<N) ~= nx,(0..<N) ~= ny,visit[nx][ny] == 0 {
                visit[nx][ny] = 1
                if graph[nx][ny] == 0 { heap.append((cnt + 1, nx, ny)) }
                else { heap.append((cnt, nx, ny)) }
            }
        }
    }
}
dijkstra()
```

### 풀이
```
이 문제는 시작점부터 도착점까지 이동을 하면서 방을 바꾸면서 이동한다. 그 방을 바꾼 횟수가 가장 적은 횟수를 출력하는 문제이다.

시작점과 끝점은 항상 일정하고 경로를 찾는 문제가 아니기 때문에 모든 경로를 다 검사해야한다. 그럼으로 평균적인 시간복잡도는 𝑂(𝐸𝑙𝑜𝑔𝐸)로 예상됨
```

> 과정
1. 입력 받은 맵의 방을 기준으로 2차원 배열 생성
2. 맵의 갯수 만큼 방문 배열도 2차원 배열로 생성
3. 시작 지점은 항상 방문중이기 때문에 1로 초기화
4. 좌표의 이동을 계산하기 위한 dx,dy을 이동 배열로 선언
5. 다익스트라 함수 실행
    5 - 1. 힙을 생성, 현제 좌표 및 방을 바꾼 횟수를 저장하기 위함
    5 - 2. 만약 도착지에 도착했다면 현재 방을 바꾼 횟수를 출력
    5 - 3. 현재 위치에서 상하 죄우 값을 루프로 돌림
    5 - 4. 만약 맵을 벗어나지 않았고 방문을 하지 않은 방이라면
    5 - 5. 방문 처리 진행
    5 - 6. 만약 흰 방이면 현제 상황을 힙에 저장하고 아닐 경우 방을 바꾼 횟수를 1 증가 시키고 힙에 저장
6. 이 과정을 반복하면 방을 바꾼 횟수가 작은 순서대로 우선순위 큐에 쌓이기 때문에 도착했을 때 당시 바꾼 횟수가 가장 작은 값의 요소를 출력할 수 있음
---

# [백준][13549번] 숨바꼭질 3

> 출제자 : KUN</br>
> 풀이자 : NCookie

https://www.acmicpc.net/problem/13549

## 출제자 : KUN

### 코드
```javascript
import * as readline from "readline";


// readline을 사용하여 입력을 받는 인터페이스를 설정
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// 입력을 한 줄씩 처리하는 이벤트 리스너
rl.on("line", (input: string) => {
  const [N, K] = input.split(" ").map(Number); // 입력을 받아서 N과 K로 변환
  console.log(dijkstra(N, K)); // 다익스트라 알고리즘을 실행하고 결과를 출력
  rl.close(); // 입력 인터페이스를 닫음
});

// 최소 힙 클래스 선언 (위 코드 참조)

class MinHeap {
  heap: { node: number; priority: number }[]; // 힙을 저장할 배열

  constructor() {
    this.heap = []; // 힙 초기화
  }

  insert(node: number, priority: number) {
    this.heap.push({ node, priority }); // 새로운 요소를 힙의 끝에 추가
    this.bubbleUp(); // 힙 속성을 유지하기 위해 위로 올림
  }

  extractMin() {
    const min = this.heap[0]; // 힙의 루트 요소 (가장 작은 값)
    const end = this.heap.pop(); // 힙의 마지막 요소를 꺼냄
    if (this.heap.length > 0 && end) {
      // 힙에 남은 요소가 있다면
      this.heap[0] = end; // 루트에 마지막 요소를 배치
      this.bubbleDown(); // 힙 속성을 유지하기 위해 아래로 내림
    }
    return min; // 가장 작은 값을 반환
  }

  bubbleUp() {
    let index = this.heap.length - 1; // 새로 추가된 요소의 인덱스
    const element = this.heap[index]; // 새로 추가된 요소

    while (index > 0) {
      let parentIndex = Math.floor((index - 1) / 2); // 부모 노드의 인덱스
      let parent = this.heap[parentIndex]; // 부모 노드

      if (element.priority >= parent.priority) break; // 부모 노드가 더 작거나 같으면 종료

      this.heap[index] = parent; // 부모 노드를 현재 위치로 이동
      this.heap[parentIndex] = element; // 새 요소를 부모 위치로 이동
      index = parentIndex; // 인덱스를 부모 위치로 갱신
    }
  }

  bubbleDown() {
    let index = 0; // 루트부터 시작
    const length = this.heap.length; // 힙의 길이
    const element = this.heap[0]; // 루트 요소

    while (true) {
      let leftChildIndex = 2 * index + 1; // 왼쪽 자식의 인덱스
      let rightChildIndex = 2 * index + 2; // 오른쪽 자식의 인덱스
      let leftChild, rightChild;
      let swap = null; // 교환할 위치

      if (leftChildIndex < length) {
        leftChild = this.heap[leftChildIndex]; // 왼쪽 자식
        if (leftChild.priority < element.priority) {
          swap = leftChildIndex; // 왼쪽 자식이 더 작다면 교환 대상 설정
        }
      }

      if (rightChildIndex < length) {
        rightChild = this.heap[rightChildIndex]; // 오른쪽 자식
        if (
          (swap === null && rightChild.priority < element.priority) || // 오른쪽 자식이 더 작다면
          (swap !== null && rightChild.priority < leftChild!.priority) // 교환 대상이 없거나 오른쪽 자식이 더 작다면
        ) {
          swap = rightChildIndex; // 교환 대상 설정
        }
      }

      if (swap === null) break; // 교환 대상이 없으면 종료

      this.heap[index] = this.heap[swap]; // 교환 대상과 위치 변경
      this.heap[swap] = element; // 현재 요소를 교환 위치로 이동
      index = swap; // 인덱스를 교환 위치로 갱신
    }
  }

  isEmpty() {
    return this.heap.length === 0; // 힙이 비었는지 확인
  }
}

// 다익스트라 알고리즘 함수
function dijkstra(N: number, K: number): number {
  const MAX = 100001; // 가능한 위치의 최대값을 설정
  const times = new Array(MAX).fill(Infinity); // 각 위치까지의 최소 시간을 무한대로 초기화
  times[N] = 0; // 시작 위치의 시간을 0으로 설정

  const minHeap = new MinHeap(); // 최소 힙 인스턴스 생성
  minHeap.insert(N, 0); // 시작 위치와 시간을 힙에 추가

  while (!minHeap.isEmpty()) {
    const { node: position, priority: time } = minHeap.extractMin(); // 힙에서 가장 작은 값을 꺼냄

    if (position === K) return time; // 현재 위치가 목표 위치라면 현재 시간을 반환

    const nextMoves = [
      { nextPosition: position * 2, nextTime: time }, // 순간 이동 (시간 증가 없음)
      { nextPosition: position + 1, nextTime: time + 1 }, // 앞으로 한 칸 이동 (시간 1 증가)
      { nextPosition: position - 1, nextTime: time + 1 }, // 뒤로 한 칸 이동 (시간 1 증가)
    ];

    for (const move of nextMoves) {
      if (
        move.nextPosition >= 0 &&
        move.nextPosition < MAX &&
        move.nextTime < times[move.nextPosition]
      ) {
        // 이동한 위치가 유효하고, 기록된 시간보다 작다면
        times[move.nextPosition] = move.nextTime; // 최소 시간을 갱신
        minHeap.insert(move.nextPosition, move.nextTime); // 힙에 새로운 위치와 시간을 추가
      }
    }
  }

  return -1; // 입력이 유효하다면 이 지점에 도달하지 않음 (예외 처리)
}
```

### 풀이
이문제도 간단하지만 최소힙 내부함수가  안되는 언어라 라이브러리구현 때문에 코드가 길어졌다.
일단 기본적인 문제의 구성은 저번에 bfs 문제에서 풀었던 숨바꼭질 2 와 동일하지만 노드간의 시간경과가 생겨 
시간경과가 제일 적은 순간이동(0초소요) 를 최대한 많이 사용한 경로의 소요시간을 출력 해주면된다. 
이를 다익스트라 알고리즘으로 구현하기위해 
1. 최소힙 라이브러리 구현
2. 나올수있는 최대 거리값 max, 각위치까지의 최소 소요시간값을 저장할 times 배열 선언
3. 시작위치 N 선언 시작위치의 시간값을 0으로 설정함
4. 최소힙 배열을 만들고 시작점과 시작시간을 배열에 더해줌
5. 반복문으로 들어가서 힙배열의 최솟값을 하나 가져옴
6. 현재위치가 === 목표값 k 라면 현재시간을 리턴
7. 아니라면 각이동값 +1 -1 *2(순간이동) 들을 수행하고 수행한 값 3개들을 유효한값인지 0 <= moved < max 시간이 최소값인지 확인후 최소시간보다 작다면 최소시간을 갱신하고 힙에 새로운 위치와 시간을 추가한다.
8. 반복문 반복

## 풀이자 : NCookie

### 코드

```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.Comparator;
import java.util.PriorityQueue;
import java.util.StringTokenizer;

public class Main {
    static int[] dist;
    static int MAX_VALUE = 100000;

    static private class Node {
        // 연결되는 정점
        int idx;
        // 비용
        int weight;

        public Node(int idx, int weight) {
            this.idx = idx;
            this.weight = weight;
        }
    }

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        StringTokenizer st = new StringTokenizer(br.readLine());

        int n = Integer.parseInt(st.nextToken());
        int k = Integer.parseInt(st.nextToken());

        int min;
        dist = new int[MAX_VALUE + 1];
        Arrays.fill(dist, Integer.MAX_VALUE);

        if (n > k) {
            min = n - k;
        } else {
            dijkstra(n);
            min = dist[k];
        }

        System.out.println(min);
    }

    private static void dijkstra(int start) {
        PriorityQueue<Node> pq = new PriorityQueue<>(Comparator.comparingInt(o -> o.weight));
        dist[start] = 0;
        pq.offer(new Node(start, 0));

        while (!pq.isEmpty()) {
            Node cur = pq.poll();

            if (dist[cur.idx] < cur.weight) {
                continue;
            }

            int next = cur.idx - 1;
            int nextWeight = cur.weight + 1;
            if (next >= 0 && nextWeight < dist[next]) {
                dist[next] = nextWeight;
                pq.offer(new Node(next, nextWeight));
            }

            next = cur.idx + 1;
            nextWeight = cur.weight + 1;
            if (next <= MAX_VALUE && nextWeight < dist[next]) {
                dist[next] = nextWeight;
                pq.offer(new Node(next, nextWeight));
            }

            next = cur.idx * 2;
            nextWeight = cur.weight;
            if (next <= MAX_VALUE && nextWeight < dist[next]) {
                dist[next] = nextWeight;
                pq.offer(new Node(next, nextWeight));
            }
        }
    }
}
```

### 풀이

하나의 노드에서는 세 개의 노드(x-1, x+1, x*2)로 이동할 수 있다. x-1, x+1 노드로 움직이려면 1초 걸리고 x*2 노드로 이동할 때에는 0초가 걸린다. 

이 때 임의의 숫자 n을 만들기 위한 경로는 여러 가지가 있을 수 있고 이 중 최단 경로를 구해야 하므로 다익스트라 알고리즘을 사용한다.
