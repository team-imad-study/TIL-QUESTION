출제일 : 2024/05/27 (DAY 7) </br>
풀이일 : 2024/05/31 (DAY 8)

---

# [백준][1719번] 택배

> 출제자 : Quarang</br>
> 풀이자 : PCYSB

https://www.acmicpc.net/problem/1719

## 출제자 : Quarang

### 코드

### 풀이

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
