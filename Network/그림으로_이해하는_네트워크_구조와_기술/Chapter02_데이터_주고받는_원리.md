# DAY2
작성일 : 2024/01/16

> 범위
- 05 프로토콜
- 06 네트워크 계층
- 07 네트워크 모델
- 08 TCP/IP
- 09 IP 주소
- 10 IPv4/IPv6

> 작성자 : ncookie

## Q1. IMAD에서 채택 중인 REST API는 프로토콜인가? 그 이유는?

REST(RESTful, Representational State Transfer)는 프로토콜이 아니라 아키텍처 스타일이다. 이러한 REST 아키텍처를 스타일의 제약 조건을 준수하고 RESTful 웹 서비스와 상호 작용할 수 있도록 하는 애플리케이션 프로그래밍 인터페이스(API)를 REST API라고 부른다.

REST는 웹 기반 시스템에서 리소스 간 상태 전이를 나타내기 위한 아키텍처적인 원칙의 모음이며 주로 HTTP 프로토콜을 기반으로 한다. 그러나 일반적으로 HTTP에서 쓰일 뿐 종속적인 것은 아니다.

> 참고 : [REST API란?](https://www.redhat.com/ko/topics/api/what-is-a-rest-api)

## Q2. TCP/UDP의 사용 예시와 그 이유

### TCP
- 누락되는 데이터가 있으면 안 되고 안정적인 통신을 원할 때 사용
- 파일 전송(FTP), 이메일(SMTP, POP3), 웹 브라우징(HTTP) 등

### UDP
- 데이터의 신뢰성보다는 속도(실시간 통신)가 중요하고 패킷이 누락되어도 감수할 수 있는 경우 사용
- 실시간 스트리밍, 온라인 게임, 보이스톡 등

![Alt text](image-3.png)

## Q3. 스마트폰에서 모바일 데이터(LTE/5G)를 사용했을 때 할당받는 IP는 공인 IP일까 사설 IP일까? 그 이유는?

일반적으로 모바일 통신 사업자가 데이터 네트워크를 사용하는 스마트폰 이용자들에게 할당하는 IP 주소는 공인 IP 주소가 아닌 사설 IP 주소다. 이는 IP 주소의 한계와 효율성을 고려하여 구현된 방식 중 하나다.

공인 IP(글로벌 IP 주소)는 약 43억 개로 제한되어 있기 때문에 대륙별, 국가별, 이동통신 사업자(통신사)별로 할당하여 사용되고 있다. 통신사는 네트워크 주소 변환(Network Address Translation, NAT)을 통해 사용자들이 사설 IP 주소로부터 외부 인터넷과 통신할 수 있도록 한다. (이 때 여러대의 클라이언트(기기)들이 하나의 IP를 실시간으로 공유하는 경우가 많다.)

NAT는 여러 사용자를 하나의 공인 IP 주소로 연결하고, 통신 패킷의 출발지 주소를 변환하여 인터넷에서의 고유한 출발지 주소를 숨긴다.

> 참고 : [How are cellphone IP addresses assigned?](https://serverfault.com/questions/60361/how-are-cellphone-ip-addresses-assigned)
