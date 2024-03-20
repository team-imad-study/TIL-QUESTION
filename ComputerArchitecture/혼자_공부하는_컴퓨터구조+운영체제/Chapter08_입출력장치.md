# DAY5
작성일 : 2024/03/20

> 범위
- 01 장치 컨트롤러와 장치 드라이버
- 02 다양한 입출력 방법

---

> 작성자 : 

---

> 작성자 : NCookie

## DMA 종류 중 하나로 채널 방식이라는 것이 있다. 이는 DMA에 비해 어떤 이점이 있을까? (Ch08-2)

![image](https://github.com/team-imad-study/study-question/assets/16646208/c2ff91dd-0998-4931-b4e8-4df3e6eddc07)

`DMAC(DMA Controller)`의 경우 CPU는 모든 단일 IO 작업을 시작하는데 관여한다. DMA 방식은 Programmed I/O, 인터럽트 기반 I/O보다 우수하지만 CPU에서 간단한 시작 명령으로 전체 I/O를 처리하는 설계 방법이 있으면 전체 시스템 성능을 향상시킬 수 있다. `IOP(I/O Processor)` 설계는 이 요구 사항을 지원한다.

IOP는 I/O 작업의 DMA 개념을 확장한 것이다. IOP는 자체 메모리가 있으며 I/O 명령을 해석하고 실행할 수 있다. 이러한 명령어는 주기억장치에서 가져온다. 데이터 전송은 메모리를 통해 직접 발생한다. 즉, *IOP는 CPU에서 최소한의 시작 명령만으로 IO 작업을 상당 부분 제어할 수 있다.*

### 채널 통신 종류

- Selecter Channel : 각 Channel에 고정적으로 연결되어 사용하며, Disk Driver와 같이 고속의 전송에 사용된다.
- Multiplexer Channel : 각 Channel에 연결된 장치를  정해진 시간 마다 1개씩 할당하여 사용하며, Termianl이나 Printer와 같은 저속의 장치에 주로 사용한다


## 참고

- [Direct Memory Access controller and I/O Processor](https://witscad.com/course/computer-architecture/chapter/dma-controller-and-io-processor#:~:text=The%20I%2FO%20devices%20are%20connected%20to%20the%20DMA,the%20CPU%20responding%20with%20DMA%20HOLD%20ACK%20signal.)
- [DMA의 동작원리](https://gomsik.tistory.com/82)

---
