I think this is a good opportunity to let me familiar with AWS environment. Therefore, I have chosen ECS cluster + Fargate rather than K8s cluster (also cheaper :D ).
Also, I have chosen to use multiple AWS service to implement this system (eg. CodeBuild, CodePipeline, RDS).

#### Endpoints:
```
GET http://url-shortener-lb-1711713777.us-east-1.elb.amazonaws.com/471f77


POST http://url-shortener-lb-1711713777.us-east-1.elb.amazonaws.com/newurl
Content-Type: application/json

{
  "url": "https://google.com"
}
```


## - Infrastructure
### CI/CD:
For the CI/CD part, I have used 2 of the AWS Services ( CodeBuild & CodePipeline)

#### Pipeline flow:
Source (GitHub)     ->    Build(CodeBuild)        ->   Deploy(ECS)
![CodePipeline](https://i.imgur.com/Um4ulPc.png)

#### Infrastructure Design
![SystemDesign](https://i.imgur.com/e9wVRus.png)

* Running as an ECS cluster + Fargate.
* Set up an application load balancer to traffic down to the service (HTTP only because I cannot request a certificate for Amazon-owned domain names).
* Running multiple tasks with same task definition in different regions.
* Use ElastiCache to cache and speed up the GET request (Currently, I have ran my own redis as a sidecar container in the task. 
  The reason is that the app cannot connect to the elasticache private endpoint due to some reasons (e.g. security group). Due to limited time, I just temporarily use the sidecar redis.)
* Use RDS (Aurora MySQL Cluster) to do the actual storage
* Use AWS SSM to keep the sensitive data secret and load to the container as environment variable
* Use Terraform to provision all the resources above.

## - System Design

##### Assumption1:  READ request much more than WRITE request => 100:1

##### Assumption2:  6 digits is enough, otherwise set expiration to the link
* lower case A-Z = 26
* upper case a-z = 26
* 0-9 = 10
* 6-digits strings = (26 + 26 + 10) ^ 6 = 56800235584 (combination)
* if 1000 Write Requests / s ->  1 day = 86400 * 1000 = 86400000
i.e. assuming there is enough room to save the hashing, otherwise expire the link

##### Design
```MD5(long_url + UUID)```

I want to keep the design as simple as possible. Therefore, I have appended a unique key (UUID) to the original URL and hashed it. Take the first 6 digits and save to DB. Then, check if there has duplicate entry. 
* If no duplicate entry, insert in and return
* If yes, re-hash and retry inserting into DB (Retry: 10 times)

Although it may lower the insert speed and there are some risk cannot insert after retrying 10 times, this design is simple.

There are some approaches I would also like to introduce.
#### 1. Pre-Generate Hash 
This approach can make sure there are no collision of hash. The only thing is pre-generating the hash and save it. When the request has arrived, give it a hash.
#### 2. Range Hashing
Each microservice ask for the hashing vacancies and take responsibility for a range of hashing. For example, service A may produce hashing within 1-1000 and service B may produce hashing within 1001-2000. That make sure there is not collision.
#### 3. Zookeeper
Use Zookeeper as a centralized DB. Let Zookeeper to distribute the unique counter to the service. However, this approach introduce more complexity to the system.



  

