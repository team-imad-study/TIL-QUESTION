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
```javascript
function solution(game_board, table) {
  const n = game_board.length; //세로
  const m = game_board[0].length; //가로
  let blanks = []; //빈칸저장
  let blocks = []; //블록저장
  const move = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1],
  ]; // 상하좌우 이동시 이동량

  const setBlock = (block) => {
    // 각각 얻어낸 block 의 값들은 모양은 같아도 절대값 좌표가 다르기에
    let minX = Math.min(...block.map((v) => v[0])); // block 요소들중 최소 x값
    let minY = Math.min(...block.map((v) => v[1])); // block 요소들중 최소 y값 을 구해내

    return block.map((v) => [v[0] - minX, v[1] - minY]).sort(); // 블록에서 빼내어 최대한 [0][0] 에 붙여준다
  };

  const bfsForBlanks = (start, game_board) => {
    //빈칸을 구하기위한 bfs
    let queue = start;
    let block = [];
    while (queue.length > 0) {
      let [column, row] = queue.shift(); // 큐한개 가져오기
      block.push([column, row]); // block에 좌표 추가

      for (let [c, r] of move) {
        // 새로 이동한 위치 변경
        let newColumn = column + c;
        let newRow = row + r;
        if (
          newColumn >= 0 && // 새로운 세로 값이 0보다 클때
          newColumn < n && // 새로운 세로 값이 세로 최댓값인 n 보다 작을때
          newRow >= 0 && // 새로운 가로 값이 0보다 클때
          newRow < m && // 새로운 가로 값이 가로 최댓값인 m 보다 작을때
          game_board[newColumn][newRow] === 0 // 새로 구성한 세로 가로 의 좌표값이 1이 아닌 0일때
        ) {
          queue.push([newColumn, newRow]); // 큐에 새로운 좌표 추가
          game_board[newColumn][newRow] = 1; // 방문 처리
        }
      }
    }
    return setBlock(block);
  };

  const bfsForBlocks = (start, table) => {
    // 블록을 구하기 위한 bfs
    let queue = start;
    let block = [];
    while (queue.length > 0) {
      let [column, row] = queue.shift(); // 큐한개 가져오기
      block.push([column, row]); // block에 좌표 추가

      for (let [c, r] of move) {
        // 새로 이동한 위치 변경
        let newColumn = column + c;
        let newRow = row + r;
        if (
          newColumn >= 0 && // 새로운 세로 값이 0보다 클때
          newColumn < n && // 새로운 세로 값이 세로 최댓값인 n 보다 작을때
          newRow >= 0 && // 새로운 가로 값이 0보다 클때
          newRow < m && // 새로운 가로 값이 가로 최댓값인 m 보다 작을때
          table[newColumn][newRow] === 1 // 새로 구성한 세로 가로 의 좌표값이 0이 아닌 1일때
        ) {
          queue.push([newColumn, newRow]); // 큐에 새로운 좌표 추가
          table[newColumn][newRow] = 0; // 방문 처리
        }
      }
    }
    return setBlock(block);
  };

  const rotate90 = (block) => {
    return block.map(([x, y]) => [-y, x]);
  };

  const rotate180 = (block) => {
    return block.map(([x, y]) => [-x, -y]);
  };

  const rotate270 = (block) => {
    return block.map(([x, y]) => [y, -x]);
  };

  const getAllRotations = (block) => {
    return [
      setBlock(block), // 0도 회전
      setBlock(rotate90(block)), // 90도 회전
      setBlock(rotate180(block)), // 180도 회전
      setBlock(rotate270(block)), // 270도 회전
    ];
  };
  for (let i = 0; i < game_board.length; i++) {
    for (let j = 0; j < game_board.length; j++) {
      if (game_board[i][j] === 0) {
        game_board[i][j] = 1;
        blanks.push(bfsForBlanks([[i, j]], game_board)); //반칸의 배열 저장
      }
    }
  }
  for (let i = 0; i < table.length; i++) {
    for (let j = 0; j < table.length; j++) {
      if (table[i][j] === 1) {
        table[i][j] = 0;
        const block = bfsForBlocks([[i, j]], table);
        blocks.push(getAllRotations(block)); // 회전까지 시킨 4방향의 배열을 전부 저장
      }
    }
  }

  const canPlaceBlock = (blank, block) => {
    // 인자를 받아 비교하는 함수
    if (blank.length !== block.length) return false; // 받아온 인자들의 길이가 다르면 들어갈수 없으므로 false
    for (let i = 0; i < blank.length; i++) {
      if (blank[i][0] !== block[i][0] || blank[i][1] !== block[i][1]) {
        // 각 인자의 값들이 다르다면 맞지않음으로 false
        return false;
      }
    }
    return true; // 그이외는 맞는 값이니 true 반환
  };

  let answer = 0; //정답 초기화
  const used = new Array(blocks.length).fill(false); // blocks 배열의 길이만큼 boolean 배열 생성

  for (const blank of blanks) {
    // blanks의 길이만큼 blank라는 이름으로 가져옴
    for (let i = 0; i < blocks.length; i++) {
      if (used[i]) continue; //boolean 배열의 [i] 값이 true 라면 이미 진행한 block이니 무시
      for (const block of blocks[i]) {
        // blocks[i] 안의 갯수만큼 block 으로 가져옴
        if (canPlaceBlock(blank, block)) {
          //비교함수 return이 true 라면
          answer += blank.length; // answer 에 blank.length = 채워지는 블록의 갯수이니 더해줌
          used[i] = true; // 방문처리
          break;
        }
      }
      if (used[i]) break; // 이미 맞는 값이 나왔으면 해당 블록의 더이상의 비교는 필요없으니 break
    }
  }

  return answer; //정답 리턴
}
```

### 풀이

DFS 로 풀기로 하였지만 아직 어려워 BFS 로 풀어버렸다.. 추후에 좀더 이해가 되고나면 DFS로 다시풀기로 하겠다.

일단 문제의 핵심 제한은
1. 블록을 회전은 가능하지만 반전은 줄수 없다는 것
2. 블록을 채웠을때 한칸이상 빈칸이 생기면 안됨
3. 한 빈칸에는 한블록만 채워넣을수 있음
4. 두블럭이나 빈칸이 상하좌우 1칸이내로 인접해있지 않음
   
이렇게라고 생각하고 문제를 풀었다.
일단

1. 저번 이동경로 찾기 문제에서 사용했던 BFS를 살짝 변형시켜 game_board 와 block 배열 의 각각 빈칸들과 블록을 추출한다.
2. 추출해낸 빈칸과 블록의 절대좌표가 달라 비교할수없으니 [0,0] 좌표로 최대한 땡겨와 정규화를 해준다.
3. 블록의 90도씩 회전한 좌표값을 얻어내기위해 블록배열에 회전한 값을 넣어주고 정규화를 한번 다시 해준다.(회전시 [0,0] 좌표에서 멀어지고 음수값이 나올수 있기 때문에)
4. 회전한 좌표값까지 들어있는 블록배열과 빈칸 배열을 비교하고 채워지는 블록수를 더해 출력한다.

---

# [프로그래머스][87946번] 피로도

https://school.programmers.co.kr/learn/courses/30/lessons/87946

> 출제자 : PCYSB </br>
> 풀이자 : NCookie

## 출제자 : PCYSB

### 코드
```java
class Solution {

    private val visited = BooleanArray(8)
    private var count = 0
    private var answer = 0

    fun solution(k: Int, dungeons: Array<IntArray>): Int {
        for (i in dungeons.indices) {
            dfs(k, i, dungeons)
        }
        return answer
    }

    private fun dfs(k: Int, current:Int, dungeons: Array<IntArray>) {
        visited[current] = true
        count++

        if (answer < count) {
            answer = count
        }

        for (i in dungeons.indices) {
            val newK = k - dungeons[current][1]
            if (!visited[i] && (dungeons[i][0] <= newK)) {
                dfs(newK, i, dungeons)
            }
        }

        visited[current] = false
        count--
    }
}
```

### 풀이
일반적인 dfs 방식을 통하여 만들 수 있는 모든 조합을 만들어 낸다.
예를 들어 던전 0, 1, 2 라는 던전 3개가 있을 때 solution 함수에서는 0, 1, 2 순서대로 처음 시작 노드를 dfs 함수로 보낸다.

dfs 함수에서는 해당 노드의 방문 여부를 확인하여 해당 시작 노드를 기준으로 나올 수 있는 모든 수를 만들며 count를 1씩 증가 시킨다. 해당 부분에서 가장 많은 count가 나올때 마다 해당 수를 answer에 저장하고 다시 모든 방문 지역을 false, count를 0으로 만들고 이를 반복하여 answer를 리턴한다.

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
```javascript
function solution(tickets) {
  let answer = [];
  const result = [];
  const visited = [];
  
  tickets.sort(); // 티켓을 알파벳 순으로 정렬
  
  const len = tickets.length;
  const dfs = (str, count) => {
    result.push(str); // 현재 위치를 경로에 추가
    
    if (count === len) {
      // 모든 티켓을 사용한 경우
      answer = result.slice(); // 현재 경로를 최종 경로로 설정
      return true; // 탐색 종료
    }
    
    for (let i = 0; i < len; i++) {
      // 모든 티켓을 순회
      if (!visited[i] && tickets[i][0] === str) {
        // 현재 티켓이 사용되지 않았고 출발지가 현재 위치와 같은 경우
        visited[i] = true; // 현재 티켓을 사용
        
        if (dfs(tickets[i][1], count + 1)) return true; // 도착지로 이동하여 DFS를 계속
        
        visited[i] = false; // 현재 티켓을 사용하지 않고 다음 경로를 탐색
      }
    }
    
    result.pop(); // 현재 위치를 경로에서 제거 (백트래킹)
    
    return false; // 유효한 경로를 찾지 못함
  }
  
  dfs("ICN", 0); // 인천에서 시작하여 탐색
  
  return answer; // 최종 경로 반환
}
```

### 풀이
일단 출발지가 동일한 티켓이 복수 존재시 알파벳순으로 티켓을 사용한다 하였으니 
sort() 함수를 사용해 티켓배열을 정렬해주었다. 
재귀 할때마다 카운트를 ++시켜주어 카운트가 티켓의 갯수만큼 반복되었다면 티켓을 전부 사용한것이니 함수를 종료하고 리턴해준다.
출발지는 ICN으로 고정이기에 첫 시작 여행지를 현재위치에 넣고 티켓을 순회하며 사용되지않은 티켓중에 출발지가 현재위치와 같은 티켓을 가지고와 visited 배열에서 사용처리를 해주고 재귀식에 도착지와 카운트를 추가해 함수를 재시작한다. 유효한 값을 찾지 못했을경우에 백트래킹을 하기위해 
현재 위치를 경로에서 제거 하는 return.pop() 해 이전경로에서 다른 티켓을 찾도록 설정해 주었다.

## 풀이자 : Quarang

### 코드
```swift
func solution(_ tickets:[[String]]) -> [String] {
    let tickets = tickets.sorted {$0[1] < $1[1]}
    var visited = [Bool](repeating: false, count: tickets.count)
    var route = [String]()
    
    func dfs(_ start:String){
        guard route.count != tickets.count else{
            route.append(start)
            return
        }
        for i in 0..<tickets.count{
            if tickets[i][0] == start,!visited[i]{
                visited[i] = true
                route.append(start)
                dfs(tickets[i][1])
                if route.count == tickets.count + 1{ return }
                route.removeLast()
                visited[i] = false
            }
        }
    }
    
    dfs("ICN")
    return route
}

print(solution([["ICN", "SFO"], ["ICN", "ATL"], ["SFO", "ATL"], ["ATL", "ICN"], ["ATL","SFO"]]))
```

### 풀이
```
해당 문제는 고정적인 한 노드로 시작해서 입력받은 배열을 모두 소진해 최적의 경로를 찾는 알고리즘
문제 특성 상 모든 노드끼리의 이동을 검색해야함으로 DFS로 구현
시간복잡도는 O(V+E)
```
> 과정
1. 티켓은 도착지를 기준으로 알파벳 순서가 앞인 도착지를 우선적으로 검색함으로 도착지를 기준으로 정렬을 하고 시작
2. 방문함을 기록할 bool 배열 선언
3. 실질적으로 여행 경로를 저장할 루트 배열 선언
4. dfs함수 실행
    4 - 1. 결과 배열의 수와 입력받은 티켓수가 같을 때 재개하고 아닐 경우 루트를 추가하며 재귀를 종료
    4 - 2. 티켓갯수만큼 루프를 돌리며, dfs함수에 들어온 시작값과 현재 티켓의 출발지가 같을 때와 방문한적이 없을 때 조건 이벤트 실행
    4 - 3. 방문처리를 하고 결과 배열에 출발지를 저장하고 dfs함수 실행
    4 - 4. 만약 결과 배열의 길이와 입력 배열의 길이 + 1이 같을 경우 재귀를 종료
    4 - 5. 만약 결과를 찾지 못했음을 데뷔해서 `백트래킹`을 사용해 이전 재귀를 다른 값으로 실행 시킬 수 있도록 함
5. 모든 과정이 끝나고 결과 배열을 출력


---

# [프로그래머스][42839번] 소수 찾기

https://school.programmers.co.kr/learn/courses/30/lessons/42839

> 출제자 : Quarang </br>
> 풀이자 : PCYSB

## 출제자 : Quarang

### 코드
```swift
import Foundation

func solution(_ numbers:String) -> Int {
   
    var numbers = numbers.map{String($0)}
    var numArr = [String]()
    
    //조합의 수 함수
    func combin(numbers:[String],num:String){
        if num != ""{ numArr.append(num)}
        for i in 0..<numbers.count{
            var numbers = numbers
            let node = numbers.remove(at: i)
            combin(numbers: numbers, num: num + node)
        }
        
    }
    //소수 찾기
    func isPrime(num:Int) -> Bool{
        guard num > 1 else{return false}
        for i in 2...Int(sqrt(Double(num))){
            if num % i == 0{ return false }
        }
        return true
    }
    
    combin(numbers: numbers, num: "")
    
    
    
    return Set(numArr.compactMap{Int($0)}).filter{isPrime(num: $0)}.count
}
```

### 풀이
```
해당 문제는 입력받은 문자열의 문자들로 만들 수 있는 소수의 갯수를 출력하는 문제
문제 특성 상 모든 노드를 검색해야함으로 DFS로 구현
시간복잡도는 O(V+E)
```

> 과정
1. 입력받은 문자열을 문자단위로 쪼개고, 정수로 변환해 정수형 배열로 변환
2. 결과를 저장할 문자열 배열 생성
3. 소수를 찾는 함수 실행
    3 - 1. 해당 수가 2 이상일때만 실행(아닌 경우는 무조건 소수이기 때문)
    3 - 2. 2부터 입력수의 루트값까지 루프 실행(이 과정으로 루프횟수를 감소할 수 있음)
    3 - 3. 만약 루프의 i로 입력값을 나눴을 때 0이 나올경우는 소수가 아님
    3 - 4. 루프를 모두 실행 시켰는데도 별다른 이벤트가 없었다면 소수임을 확인하고 true반환
4. dfs함수 실행
    4 - 1. 입력값이 비어있다면 결과 배열에 추가
    4 - 2. 문자열 배열 파라미터의 길이 만큼 루프 실행
    4 - 3. 파라미터 배열 중 i번째 인덱스를 가진 요소를 삭제하여 node에 저장
    4 - 4. 추출한 노드와 이전 노트를 합쳐 dfs함수 반복
5. 위 과정을 거치면 입력받은 값으로 만들 수 있는 모든 수가 담긴 결과 배열이 만들어짐
6. 만들어진 모든 결과들을 (3)번의 과정을 거쳐 소수를 걸러낸 후 그 배열의 길이를 출력

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
