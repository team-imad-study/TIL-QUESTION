출제일 : 2024/05/22 (DAY 6) </br>
풀이일 : 2024/05/27 (DAY 7)

---

# [프로그래머스][84021번] 퍼즐 조각 채우기

https://school.programmers.co.kr/learn/courses/30/lessons/84021

> 출제자 : NCookie </br>
> 풀이자 : KUN

## 출제자 : NCookie

### 코드

```java
import java.util.*;

class Solution {
    static class Point {
        int x, y;

        public Point(int x, int y) {
            this.x = x;
            this.y = y;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Point)) return false;
            Point point = (Point) o;
            return x == point.x && y == point.y;
        }

        @Override
        public int hashCode() {
            return Objects.hash(x, y);
        }

        @Override
        public String toString() {
            return "(" + x + ", " + y + ")";
        }
    }
    
    static public int solution(int[][] gameBoard, int[][] table) {
        int answer = 0;

        List<List<Point>> emptyBlocks = extractBlocks(gameBoard, 0);
        List<List<Point>> puzzleBlocks = extractBlocks(table, 1);

        // 빈 블럭 순회
        for (List<Point> emptyBlock : emptyBlocks) {
            // 비교를 위해 정규화 수행
            List<Point> normalized = normarlize(emptyBlock);

            for (List<Point> puzzleBlock : puzzleBlocks) {
                if (emptyBlock.size() != puzzleBlock.size()) {
                    continue;
                }

                if (compareBlocks(normalized, puzzleBlock)) {
                    answer += emptyBlock.size();
                    puzzleBlocks.remove(puzzleBlock);

                    break;
                }
            }
        }

        return answer;
    }

    static private boolean compareBlocks(List<Point> emptyBlock, List<Point> puzzleBlock) {
        List<List<Point>> rotated = List.of(
                normarlize(puzzleBlock),
                normarlize(rotate90(puzzleBlock)),
                normarlize(rotate180(puzzleBlock)),
                normarlize(rotate270(puzzleBlock))
        );

        for (List<Point> rotatedBlock : rotated) {
            if (emptyBlock.equals(rotatedBlock)) {
                return true;
            }
        }

        return false;
    }


    // 추출한 블럭 저장
    static private List<List<Point>> blocks = new ArrayList<>();
    static boolean[][] visited;

    // 현재 위치 기준 상, 우, 하, 좌의 좌표
    static int[] dx = {-1, 0, 1, 0};
    static int[] dy = {0, 1, 0, -1};


    // 테이블에서 블럭 추출하기
    static private List<List<Point>> extractBlocks(int[][] table, int extractNum) {
        blocks = new ArrayList<>();
        visited = new boolean[table.length][table[0].length];

        for (int i = 0; i < table.length; i++) {
            for (int j = 0; j < table[0].length; j++) {

                // 방문했던 좌표이거나 추출하지 않을 블럭이라면 패스
                if (visited[i][j] || table[i][j] != extractNum) {
                    continue;
                }
                // DFS 구현
                List<Point> block = new ArrayList<>();
                dfs(table, i, j, extractNum, block);
                blocks.add(block);
                
                // BFS 구현
//                bfs(table, i, j, extractNum);
            }
        }

        return blocks;
    }

    private static void bfs(int[][] table, int i, int j, int extractNum) {
        // BFS 구현 시 사용
        Queue<Point> queue = new LinkedList<>();

        // 추출한 하나의 블럭 저장
        List<Point> block = new ArrayList<>();

        queue.offer(new Point(i, j));
        visited[i][j] = true;

        // 블럭 추출
        while (!queue.isEmpty()) {
            Point point = queue.poll();
            block.add(point);

            for (int dir = 0; dir < 4; dir++) {
                int nowX = point.x + dx[dir];
                int nowY = point.y + dy[dir];

                // 현재 위치 기준 상하좌우 좌표가 유효하면서 방문하지 않은 경우
                if (nowX >= 0 && nowX < table.length
                        && nowY >= 0 && nowY < table[0].length
                        && !visited[nowX][nowY]
                        && table[nowX][nowY] == extractNum) {
                    // 방문 여부 표시
                    visited[nowX][nowY] = true;

                    // 해당 좌표를 큐에 추가
                    queue.offer(new Point(nowX, nowY));
                }
            }
        }

        blocks.add(block);
    }

    private static void dfs(int[][] table, int i, int j, int extractNum, List<Point> block) {
        block.add(new Point(i, j));
        visited[i][j] = true;

        for (int dir = 0; dir < 4; dir++) {
            int nowX = i + dx[dir];
            int nowY = j + dy[dir];

            // 현재 위치 기준 상하좌우 좌표가 유효하면서 방문하지 않은 경우
            if (nowX >= 0 && nowX < table.length
                    && nowY >= 0 && nowY < table[0].length
                    && !visited[nowX][nowY]
                    && table[nowX][nowY] == extractNum) {
                dfs(table, nowX, nowY, extractNum, block);
            }
        }
    }

    private static List<Point> normarlize(List<Point> block) {
        int minX = Integer.MAX_VALUE;
        int minY = Integer.MAX_VALUE;

        for (Point p : block) {
            if (p.x < minX) minX = p.x;
            if (p.y < minY) minY = p.y;
        }

        List<Point> normalized = new ArrayList<>();
        for (Point p : block) {
            normalized.add(new Point(p.x - minX, p.y - minY));
        }

        // 정규화된 좌표 데이터를 정렬
        normalized.sort(Comparator.comparingInt((Point p) -> p.x).thenComparingInt(p -> p.y));
        return normalized;
    }

    private static List<Point> rotate90(List<Point> block) {
        List<Point> rotated = new ArrayList<>();
        for (Point p : block) {
            rotated.add(new Point(-p.y, p.x));
        }
        return rotated;
    }

    private static List<Point> rotate180(List<Point> block) {
        List<Point> rotated = new ArrayList<>();
        for (Point p : block) {
            rotated.add(new Point(-p.x, -p.y));
        }
        return rotated;
    }

    private static List<Point> rotate270(List<Point> block) {
        List<Point> rotated = new ArrayList<>();
        for (Point p : block) {
            rotated.add(new Point(p.y, -p.x));
        }
        return rotated;
    }
}
```

### 풀이

BFS/DFS 카테고리로 분류되는 문제이기는 하지만 다른 로직이 핵심이 되는 문제였다. 참고로 위 코드에서는 BFS와 DFS 모두 구현해두었다.

문제에서 핵심이 되는 전제 조건이 몇 가지 있다.
```
1. 조각은 뒤집을 수 없지만 회전시킬 수 있다.
2. 조각을 한 개 채워넣었을 때 인접한 칸(상하좌우)이 비어있으면 안 된다.
```

즉, 게임 보드의 빈 공간은 여러 개의 퍼즐 조각으로 채워넣는게 아니라 하나의 퍼즐 조각과 완전히 일치해야 한다. 또한 이를 비교하기 위해서는 퍼즐 조각의 원래 상태, 90도 회전, 180도 회전, 270도 회전 상태를 모두 확인해봐야 한다.

문제 풀이를 위해서는 다음과 같은 로직이 구현되어야 한다.

- 게임 보드 및 테이블로부터 빈 공간 / 퍼즐 조각 추출 (DFS 또는 BFS 사용)
- 블럭 회전 및 정규화
- 빈 공간과 퍼즐 조각 비교

**블럭 추출**

BFS 또는 DFS를 사용해서 블럭을 추출해낸다. 같은 블럭이 되기 위해서는 현재 위치 기준으로 상하좌우에 인접해있어야 하므로 dx, dy를 사용했다. 

처음 문제를 풀 때는 BFS만 알고 있는 상태이어서 나중에 DFS 코드를 추가했다.

```java
// 테이블에서 블럭 추출하기
static private List<List<Point>> extractBlocks(int[][] table, int extractNum) {
    blocks = new ArrayList<>();
    visited = new boolean[table.length][table[0].length];

    for (int i = 0; i < table.length; i++) {
        for (int j = 0; j < table[0].length; j++) {

            // 방문했던 좌표이거나 추출하지 않을 블럭이라면 패스
            if (visited[i][j] || table[i][j] != extractNum) {
                continue;
            }
            
            // DFS 구현
            List<Point> block = new ArrayList<>();
            dfs(table, i, j, extractNum, block);
            blocks.add(block);
            
            // BFS 구현
//                bfs(table, i, j, extractNum);
        }
    }

    return blocks;
}

private static void bfs(int[][] table, int i, int j, int extractNum) {
    // BFS 구현 시 사용
    Queue<Point> queue = new LinkedList<>();

    // 추출한 하나의 블럭 저장
    List<Point> block = new ArrayList<>();

    queue.offer(new Point(i, j));
    visited[i][j] = true;

    // 블럭 추출
    while (!queue.isEmpty()) {
        Point point = queue.poll();
        block.add(point);

        for (int dir = 0; dir < 4; dir++) {
            int nowX = point.x + dx[dir];
            int nowY = point.y + dy[dir];

            // 현재 위치 기준 상하좌우 좌표가 유효하면서 방문하지 않은 경우
            if (nowX >= 0 && nowX < table.length
                    && nowY >= 0 && nowY < table[0].length
                    && !visited[nowX][nowY]
                    && table[nowX][nowY] == extractNum) {
                // 방문 여부 표시
                visited[nowX][nowY] = true;

                // 해당 좌표를 큐에 추가
                queue.offer(new Point(nowX, nowY));
            }
        }
    }

    blocks.add(block);
}

private static void dfs(int[][] table, int i, int j, int extractNum, List<Point> block) {
    block.add(new Point(i, j));
    visited[i][j] = true;

    for (int dir = 0; dir < 4; dir++) {
        int nowX = i + dx[dir];
        int nowY = j + dy[dir];

        // 현재 위치 기준 상하좌우 좌표가 유효하면서 방문하지 않은 경우
        if (nowX >= 0 && nowX < table.length
                && nowY >= 0 && nowY < table[0].length
                && !visited[nowX][nowY]
                && table[nowX][nowY] == extractNum) {
            dfs(table, nowX, nowY, extractNum, block);
        }
    }
}
```

**블럭 회전 및 정규화**

이 부분과 블럭 비교 부분은 사람들마다 구현 방법이 다양해서 각자 편한 것을 선택하면 될 것 같다. 블럭을 90도씩 여러 번 회전시킬 수도 있겠지만 나 같은 경우에는 90도, 180도, 270도 마다 규칙을 찾아서 구현했다.

원래 블럭의 좌표가 (x, y)라고 할 때 90도 회전하면 (-y, x), 180도 회전하면 (-x, -y), 270도 회전하면 (y, -x)와 모양이 같다. 대신 이렇게 변환해버리면 좌표가 마이너스도 되기 때문에 모든 좌표를 통일성 있게 **정규화** 해줘야 한다.

모든 블럭들이 (0, 0)을 기준으로 정렬될 수 있도록 각 블럭의 가장 작은 x, y를 구해서 빼줬다. 이는 블럭 간의 비교에도 유용하게 쓰인다.

```java
private static List<Point> normarlize(List<Point> block) {
    int minX = Integer.MAX_VALUE;
    int minY = Integer.MAX_VALUE;

    for (Point p : block) {
        if (p.x < minX) minX = p.x;
        if (p.y < minY) minY = p.y;
    }

    List<Point> normalized = new ArrayList<>();
    for (Point p : block) {
        normalized.add(new Point(p.x - minX, p.y - minY));
    }

    // 정규화된 좌표 데이터를 정렬
    normalized.sort(Comparator.comparingInt((Point p) -> p.x).thenComparingInt(p -> p.y));
    return normalized;
}

private static List<Point> rotate90(List<Point> block) {
    List<Point> rotated = new ArrayList<>();
    for (Point p : block) {
        rotated.add(new Point(-p.y, p.x));
    }
    return rotated;
}

private static List<Point> rotate180(List<Point> block) {
    List<Point> rotated = new ArrayList<>();
    for (Point p : block) {
        rotated.add(new Point(-p.x, -p.y));
    }
    return rotated;
}

private static List<Point> rotate270(List<Point> block) {
    List<Point> rotated = new ArrayList<>();
    for (Point p : block) {
        rotated.add(new Point(p.y, -p.x));
    }
    return rotated;
}
```

**블럭 비교**

빈 공간과 일치하는 블럭을 찾는다. 마찬가지로 비교를 위해 빈 블럭에도 정규화 작업을 수행한다. 이제 두 블럭 간의 비교를 하고, 만약 일치하지 않는다면 퍼즐 조각 블럭을 회전시키거나 다음 블럭과 비교한다.

```java
public int solution(int[][] gameBoard, int[][] table) {
    int answer = 0;

    List<List<Point>> emptyBlocks = extractBlocks(gameBoard, 0);
    List<List<Point>> puzzleBlocks = extractBlocks(table, 1);

    // 빈 블럭 순회
    for (List<Point> emptyBlock : emptyBlocks) {
        // 비교를 위해 정규화 수행
        List<Point> normalized = normarlize(emptyBlock);

        for (List<Point> puzzleBlock : puzzleBlocks) {
            if (emptyBlock.size() != puzzleBlock.size()) {
                continue;
            }

            if (compareBlocks(normalized, puzzleBlock)) {
                answer += emptyBlock.size();
                puzzleBlocks.remove(puzzleBlock);

                break;
            }
        }
    }

    return answer;
}

static private boolean compareBlocks(List<Point> emptyBlock, List<Point> puzzleBlock) {
    List<List<Point>> rotated = List.of(
            normarlize(puzzleBlock),
            normarlize(rotate90(puzzleBlock)),
            normarlize(rotate180(puzzleBlock)),
            normarlize(rotate270(puzzleBlock))
    );

    for (List<Point> rotatedBlock : rotated) {
        if (emptyBlock.equals(rotatedBlock)) {
            return true;
        }
    }

    return false;
}
```

## 풀이자 : KUN

### 코드

### 풀이

---

# [프로그래머스][87946번] 피로도

https://school.programmers.co.kr/learn/courses/30/lessons/87946

> 출제자 : PCYSB </br>
> 풀이자 : NCookie

## 출제자 : PCYSB

### 코드

### 풀이

## 풀이자 : NCookie

### 코드

```java
class Solution {
    static boolean[] visited;
    static int answer = 0;

    public int solution(int k, int[][] dungeons) {
        visited = new boolean[dungeons.length];
        
        dfs(0, k, dungeons);
        
        return answer;
    }

    // 모든 경우의 수 탐색
    static private void dfs(int depth, int fatigue, int[][] dungeons) {
        for (int i = 0; i < dungeons.length; i++) {
            // 이미 방문했거나 최소 필요 피로도를 충족하지 못하면 패스
            if (visited[i] || fatigue < dungeons[i][0]) continue;

            // 방문 표시
            visited[i] = true;
            dfs(depth + 1, fatigue - dungeons[i][1], dungeons);

            // 재귀 스택이 종료될 때마다 방문 여부 해제
            // i번째 던전을 첫 번째로 탐색하는 경우의 수를 모두 순회했기 때문
            visited[i] = false;
        }

        answer = Math.max(answer, depth);
    }
}
```

### 풀이

백트래킹과 DFS를 사용해서 모든 경우의 수를 탐색한다. 던전에 방문할 때마다 최소 필요 피로도를 체크하고 소모 피로도만큼 차감시킨다. 한 번의 경로 탐색이 완료되었다면 `answer`를 가장 많은 방문수로 갱신한다.

---

# [프로그래머스][43164번] 여행경로

https://school.programmers.co.kr/learn/courses/30/lessons/43164

> 출제자 : KUN </br>
> 풀이자 : Quarang

## 출제자 : KUN

### 코드

### 풀이

## 풀이자 : Quarang

### 코드

### 풀이

---

# [프로그래머스][42839번] 소수 찾기

https://school.programmers.co.kr/learn/courses/30/lessons/42839

> 출제자 : Quarang </br>
> 풀이자 : PCYSB

## 출제자 : Quarang

### 코드

### 풀이

## 풀이자 : PCYSB

### 코드
```java
class Solution {
    var answer = 0 // answerSet에 들어있는 요소중 소수인 값만 카운팅
    var answerSet = mutableSetOf<Int>() // 저장된 모든 조합들
    
    fun solution(numbers: String): Int {
        var list = numbers.toCharArray()
        
        list.forEachIndexed { index, c ->
            dfs(c.toString(), list.filterIndexed {i, _ -> index != i})
        }
        
        answerSet.forEach {
            answerCount(it)
        }
        
        return answer
    }
    
    fun dfs(numbers: String, list: List<Char>){
        answerSet.add(numbers.toInt())
        if(list.isEmpty()) return //리스트가 비어있을 경우 재귀 탈출
        
        //들어온 숫자와 리스트의 인덱스 0번째를 붙이고, 붙인 해당 번째는 보내지 않는다.
        list.forEachIndexed { index, c ->
            dfs("$numbers$c", list.filterIndexed {i, _ -> index != i})
        }
    }
    
    fun answerCount(n: Int){
        if(n > 1 && (2 until n).none{n%it == 0}){
            answer++
        }
    }
}

```

### 풀이
1. 입력을 문자열의 형식으로 받기 때문에 해당 문자열을 변수 하나를 만들어 Char형 배열로 바꾸어 준다.

2. 해당 변수에서 0번째 인덱스 부터 마지막 인덱스까지 하나씩 넣어주고, 나머지 숫자들을 리스트 형태로 넣어 dfs 함수에 넣어준다.

3. 해당 dfs 함수에서 재귀 하여 가능한 조합의 모든 숫자를 Set 컬렉션에 넣어준다.

4. Set 컬렉션에서 소수인지 아닌지 확인하는 for문을 돌린다.

5. 결과값을 반환한다.

예시)
해당 코드에 "134"라는 문자열이 들어올 시 아래와 같은 결과로 작동 될 것이다.


```java
        list.forEachIndexed { index, c ->
            dfs(c.toString, list.filterIndexed {i, _ -> index != i})
        }
```
1. [1, 34]
2. [3, 14]
3. [4, 13]

```java
        list.forEachIndexed { index, c ->
            dfs("$numbers$c", list.filterIndexed {i, _ -> index ! = i})
        }
```
1. answer.add(1)
1-2. answer.add(13)
1-3. answer.add(134) //여기서는 리스트가 비어있기 때문에 return 되고
1-4. answer.add(14) //여기부터 다시 [1, 34]를 받은 부분에서 [14, 3]으로 넘어가게 된다.
1-5. answer.add(143)
