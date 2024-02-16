# DAY13
작성일 : 2024/02/16

> 범위

- 51 클라우드 구조
- 52 서버 가상화
- 53 분산 기술
- 54 IaaS/PaaS/SaaS/Dass

---

> 작성자 Quarang

## 서버를 인프라 구축 방식들과 그 방식에 대해 설명하시오

> 온 프레미스방식(On-Premiss)
- 각 기업에서 자체적으로 데이터센터를 보유하고 관리하는 운영방식
- 장점 : 보안적으로 클라우드 시스템 보다 뛰어나다.
- 단점 : 서버 용량을 늘릴 시 물리적인 잇슈 방생 즉, 확장성이 떨어짐(구매의 번거로움, 공간 낭비 등)
- 여건이 되지 않아 클라우드로 마이그레이션을 해야하는 경우가 발생함

> 퍼블릭 클라우드

- 업체에서 리소스를 공급해주며 인터넷을 기반으로 모든 사용자들이 서버를 사용할 수 있도록 운영하는 방식
- 장점 : 탄력적인 운영방식(필요한 만큼 임대 가능,사용한 만큼 가격 지불)으로 낭비와 비용을 절감 가능
- 단점 : 클라우드 사용자(서버를 호스팅한 개인이나 기업)의 범위가 제한적임, 상황에 따른 성능의 변화(트레픽양에 따라 느려질수 있음)

> 프라이빗 클라우드

- 특정 클라이언트를 대상하르호나 클라우드
- 방화벽 내에 위치하며 액세스 권한이 있는 사람만 이용 가능한 클라우드
- 장점 : 퍼블릭 클라우드에 비해 높은 보안성과 설능(트래픽)
- 단점 : 높은 비용과 낮은 확장성(복잡성 및 보안 수준 강화의 어려움 등)

> 하이브리드 클라우드

- 퍼블릭 클라우드와 프라이빗의 장점을 각각 합쳐 탄생한 클라우드
- 프라이빗 클라우드를 사용하다가 사용량이 급장하여 메모리가 부족할 경우 퍼블릭 클라우드를 사용하여 리소스를 보완
- 우선순위를 나눠 더 민감한 정보를 프라이빗, 다음 퍼블릭으로 처리함
- 장점 : 프라이빗의 단점인 확장성을 처리하여 비용을 절감
- 단점 : 프라이빗과 퍼블릭을 결합하는 과정에서 복잡성이 증대

> 멀티 클라우드

- 다수의 클라우드 업체의 서비스를 결합한 환경
- AWS + Azure, AWS + Azure + GCP 등

> 참고 : https://www.redhat.com/ko/topics/cloud-computing/public-cloud-vs-private-cloud-and-hybrid-cloud
> 참고 : https://notepad96.tistory.com/121

--- 

> 작성자 : KUN

--- 

> 작성자 : PCYSB

--- 

> 작성자 : NCookie

## AWS는 IaaS, PaaS, SaaS 중 어디에 해당할까?

AWS(Amazon Web Services)는 `IaaS(Infrastructure as a Service)`와 `PaaS(Platform as a Service)`를 제공한다. 

직접적으로 `SaaS(Software as a Service)`를 제공하지는 않는다. AWS는 클라우드 인프라를 제공하여 기업이 자체적으로 애플리케이션을 구축, 배포 및 관리할 수 있도록 도와주는데, 이는 SaaS와는 조금 다르다.

### EC2와 RDS는?

#### EC2

`Amazon Elastic Compute Cloud(Amazon EC2)`는 Amazon Web Services(AWS) 클라우드에서 온디맨드 확장 가능 컴퓨팅 용량을 제공한다. 원하는 수의 가상 서버를 구축하고 보안 및 네트워킹을 구성하며 스토리지를 관리할 수 있다. 트래픽 및 컴퓨팅 성능에 따라 용량을 늘리거나 줄일 수 있다.

따라서 `EC2`는 가상 서버, 스토리지, 네트워킹 및 기타 컴퓨팅 리소스와 같은 기본적인 인프라를 제공하는 `IaaS`에 해당한다. 

#### RDS

`Amazon Relational Database Service(Amazon RDS)`는 AWS 클라우드에서 관계형 데이터베이스를 더 쉽게 설치, 운영 및 확장할 수 있는 웹 서비스다. 이 서비스는 산업 표준 관계형 데이터베이스를 위한 경제적이고 크기 조절이 가능한 용량을 제공하고 공통 데이터베이스 관리 작업을 관리한다. Amazon RDS를 사용하면 번거로운 수동 작업을 처리할 필요가 없어 애플리케이션과 사용자에게 집중할 수 있다.

PaaS에서는 제공업체가 자체 인프라에서 하드웨어와 소프트웨어를 호스팅하고 이러한 플랫폼을 사용자에게 통합 솔루션, 솔루션 스택 또는 인터넷을 통한 서비스로 제공한다. 주로 개발자와 프로그래머에게 유용한 PaaS를 통해 사용자는 자체 애플리케이션을 개발, 실행 및 관리할 수 있으며, 이 과정에서 일반적으로 이러한 프로세스와 관련된 인프라 또는 플랫폼을 구축하고 유지 관리할 필요가 없다. 따라서 `RDS`는 `PaaS`에 해당한다.

#### 그 외 AWS의 서비스

EC2, S3 등은 IaaS에, Elastic Beanstalk, AWS Lambda 등이 PaaS에 해당한다.

> 참고
> - [AWS 기반 서비스형 소프트웨어(SaaS)](https://aws.amazon.com/ko/saas/)
> - [서비스형 인프라(IaaS)란 무엇인가요?](https://aws.amazon.com/ko/what-is/iaas/)
> - [IaaS, PaaS 및 SaaS 비교](https://www.redhat.com/ko/topics/cloud-computing/iaas-vs-paas-vs-saas)
> - [Amazon EC2란 무엇인가요?](https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/concepts.html)
> - [Amazon Relational Database Service(Amazon RDS)란 무엇입니까?](https://docs.aws.amazon.com/ko_kr/AmazonRDS/latest/UserGuide/Welcome.html)
