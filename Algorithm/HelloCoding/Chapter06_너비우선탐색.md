출제일 : 2024/04/18 (DAY 5) </br>
풀이일 : 2024/05/22 (DAY 6)

---

# [프로그래머스][1844번] 게임 맵 최단거리

> 출제자 : KUN </br>
> 풀이자 : NCookie

https://school.programmers.co.kr/learn/courses/30/lessons/1844

## 출제자 : KUN

### 코드

### 풀이

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

### 풀이

---

# [백준][2606번] 바이러스

> 출제자 : PCYSB </br>
> 풀이자 : Quarang

https://www.acmicpc.net/problem/2606

## 출제자 : PCYSB

### 코드

### 풀이

## 풀이자 : Quarang

### 코드

### 풀이

---


# [프로그래머스][43163번] 단어변환

> 출제자 : Quarang </br>
> 풀이자 : KUN

https://school.programmers.co.kr/learn/courses/30/lessons/43163

## 출제자 : Quarang

### 코드

### 풀이

## 풀이자 : KUN

### 코드

### 풀이

---
