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

### 풀이

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

### 풀이

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


### 풀이

---

# [백준][13549번] 숨바꼭질 3

> 출제자 : KUN</br>
> 풀이자 : NCookie

https://www.acmicpc.net/problem/13549

## 출제자 : KUN

### 코드

### 풀이

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
