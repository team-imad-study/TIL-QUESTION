# DAY4
작성일 : 2024/03/15

> 범위
- 01 RAM의 특징과 종류
- 02 메모리의 주소공간
- 03 캐시 메모리

---

> 작성자 :

---

> 작성자 :

---

> 작성자 : NCookie

## 캐시 메모리의 최적화를 위한 코드 개선 (Ch06-3)

### 행렬 곱셈

![image](https://github.com/team-imad-study/study-question/assets/16646208/92765862-7caf-4075-a42c-d5d1374dd716)
![image](https://github.com/team-imad-study/study-question/assets/16646208/4aa67042-1994-4dd6-a8c2-389baa80a307)

```python
for i in 0..n
  for j in 0..m
    for k in 0..p
      C[i][j] = C[i][j] + A[i][k] * B[k][j];
```

위 코드에서 캐시 메모리에는 공간적 지역성에 의해 A[i][k] 배열이 있다. k가 마지막 차원에서 연속적으로 증가하기 때문이다. 

하지만 B[k][j]는 첫 번째 차원에서 k가 증가하므로 캐시 미스가 발생한다. 루프 인덱스 k가 증가할수록 B[k][j]를 참조하기 위해 m * sizeof(int)만큼 점프해야 하기 때문이다.

```python
for i in 0..n
  for k in 0..p
    for j in 0..m
      C[i][j] = C[i][j] + A[i][k] * B[k][j];
```

i와 k의 루프 순서를 바꾸는 것만으로 드라마틱한 속도 향상을 볼 수 있다. A[i][k]는 내부 루프에서 고정되어 있고, B[k][j]는 마지막 차원에서 j가 증가하므로 공간적 지역성을 충분히 활용하여 캐시 적중율을 높일 수 있다. 물론 순서만 다를뿐 결과는 수학적으로 동일하다.

이러한 성능 향상은 p의 값이 100,000이 넘거나 L1, L2 캐시 메모리가 감당하지 못할 정도로 크면 더욱 눈에 띈다.

### 코드 파티셔닝(Code Partitioning)

```c
int foo() {
    if (condition) {
        // Large code block 1
    } else {
        // Large code block 2
    }

    // more code
    return value;
}
```

CPU는 두 개의 코드 블록 중 하나인 code block 1 또는 2를 실행한다. 공간적 지역성에 따라 캐시는 두 블럭의 코드를 모두 저장할 수 있다. 여기서 Large code block 1이 매우 높은 확률로 실행되고 Large code block 2가 매우 드물게 실행되면 동적 메모리의 크기가 불필요하게 커져 캐시 활용도가 낮아진다.

```c
int foo() {
    if (condition) {
        // Large code block 1
    } else {
        Large_code_2();
    }

    // more code
    return value;
}
```

드물게 실행되는 Large code block 2를 별도의 함수로 분리했다. 이 함수의 코드는 메모리의 다른 곳에 위치하기 때문에 공간적 지역성은 더 이상 두 블록의 코드에서 강제되지 않는다. 이렇게 하면 동적 메모리 설치 공간이 줄어들어 캐시 사용률이 높아진다. 동일한 방법을 케이스문이 많은 스위치(switch)문에도 적용할 수 있다.

정리하자면, 많은 케이스가 존재하는 큰 함수를 가지고 있다면, 어떤 케이스가 자주 실행될 것인지 따져보고, 자주 실행되지 않는 케이스에서 다른 함수를 호출한다.

### 인라이닝(Inlining)

```c
#include <stdio.h>

#define SIZE 1000

int add(int a, int b) {
    return a + b;
}

int main() {
    int array[SIZE];
    int sum = 0;

    // 배열 초기화
    for (int i = 0; i < SIZE; ++i) {
        array[i] = i + 1;
    }

    // 배열 합 구하기
    for (int i = 0; i < SIZE; ++i) {
        sum = add(sum, array[i]);
    }

    printf("Sum: %d\n", sum);

    return 0;
}
```

부모 함수가 자식 함수를 호출하는 경우, 다음 두 가지 이유로 인한 결함이 존재한다. 

1. 자식 함수의 코드가 캐시에 존재하지 않는 경우 캐시 미스가 발생하여 프로세서가 중지된다.
2. 흐름 변경(COF, Change of Flow)이 발생하면, 파이프라인을 Flush 해야하므로 사이클에 상당한 결함이 발생할 수 있다.

이와 같은 경우를 `함수기반의 조각화(Function-Based Fragmentation)`이라고 한다.

> COF에는 예외 처리, 비동기 프로그래밍, 조건문, 반복문, 함수 호출과 같은 상황에서 발생할 수 있다.

```c
#include <stdio.h>

#define SIZE 1000

// 인라인 함수 정의
inline int add(int a, int b) {
    return a + b;
}

int main() {
    int array[SIZE];
    int sum = 0;

    // 배열 초기화
    for (int i = 0; i < SIZE; ++i) {
        array[i] = i + 1;
    }

    // 배열 합 구하기 (인라인 함수 사용)
    for (int i = 0; i < SIZE; ++i) {
        sum = add(sum, array[i]);
    }

    printf("Sum: %d\n", sum);

    return 0;
}
```

`인라인 함수(inline function)`는 컴파일러가 함수를 호출하는 대신, 그에 대응하는 함수 코드로 대체하여 호출되는 모든 장소에 삽입할 것을 요청할 수 있다.

인라인 함수는 `함수 기반의 조각화`를 줄이는데 유용하다. 한 함수를 다른 함수에 포함시킴으로써 흐름 변화(COF)를 줄이고 코드를 더 선형적으로 만들 수 있다.

> **인라인 함수의 장단점**
> 
> 장점은 무엇보다도 프로그램의 실행속도가 빨라진다는 점입니다. 함수는 호출될 때마다 처리해야 하는 작업이 상당히 많습니다. 함수 종료 후 반환할 위치를 알려줘야 하니 실행 중인 현재 명령어의 주소를 저장도 해야 하고 함수도 호출해야 합니다. 함수를 호출하려면 프로그램 실행 중 함수를 실행해야 하면 해당 함수의 주소로 점프시켰다가, 함수의 처리가 종결되면 다시 원래의 자리로 돌아오게 해야 하는데 이러한 과정에서 시간이 소요됩니다. 반면에 인라인 함수는 컴파일된 함수 코드가 프로그램의 코드 안에 직접 삽입되므로 이러한 과정이 필요가 없어 프로그램 속도 측면에서는 유리하다고 볼 수 있습니다.
> 
> 반대로 메모리 사용 측면에서는 인라인 함수가 일반 함수보다 불리합니다. 인라인 함수는 호출한 부분이 몇번이 되던 컴파일러는 인라인 함수의 사본을 호출한 부분에 계속해서 삽입해야 하기 때문에 그만큼 메모리의 낭비가 있을 수밖에 없습니다. 그러므로 인라인 함수를 사용하기에 적절한곳은 호출이 많이 일어나지 않는 함수이거나 함수 내부 코드의 양이 매우 실행 속도가 짧은데 비해 함수의 호출시간이 부담스럽다고 생각할 때만 인라인 함수로 만들어 활용하는 것이 적당합니다.

인라이닝은 코드가 커진다는 단점이 있기 때문에 때때로 역효과를 가지고 올 수 있다. 따라서 인라이닝을 사용할 때는 다음과 같은 체크리스트를 확인해야 한다.

- 함수의 크기는 어떻게 되는가?
- 그 함수를 호출하는 장소가 몇 개나 되는가?
- 함수가 자주 호출되는가? 아니면 코너 케이스인가?

## 참고

- [Locality of reference](https://en.wikipedia.org/wiki/Locality_of_reference)
- [캐시 메모리의 참조 지역성(Locality of Reference)과 코드 최적화(Partitioning, Inlining, Alignment)](https://blog.naver.com/techref/222251293739)
- [[C언어/C++] 인라인(inline) 함수 사용법 & 예제](https://coding-factory.tistory.com/694#:~:text=%EC%9D%B8%EB%9D%BC%EC%9D%B8%20%ED%95%A8%EC%88%98%EB%9E%80%3F%20%EC%9D%B8%EB%9D%BC%EC%9D%B8%20%ED%95%A8%EC%88%98%EB%8A%94%20%EC%A0%95%EC%9D%98%ED%95%9C%20%EC%BD%94%EB%93%9C%EB%93%A4%EC%9D%B4%20%EC%9D%B8%EB%9D%BC%EC%9D%B8%20%ED%95%A8%EC%88%98,%EC%95%84%EB%8B%88%EB%9D%BC%2C%20%ED%98%B8%EC%B6%9C%ED%95%98%EB%8A%94%20%EC%BD%94%EB%93%9C%20%EC%9E%90%EC%B2%B4%EA%B0%80%20%ED%95%A8%EC%88%98%20%EB%82%B4%EC%9A%A9%EC%9D%98%20%EC%BD%94%EB%93%9C%EA%B0%80%20%EB%90%A9%EB%8B%88%EB%8B%A4.)
- [캐시가 동작하는 아주 구체적인 원리](https://parksb.github.io/article/29.html)
