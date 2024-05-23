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
