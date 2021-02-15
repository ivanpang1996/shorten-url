
# Q1 : 
please see Q1A & Q1B & Q1C under "sh" directory

# Q2 : 
please see Q2 under "sh" directory

# Q3 :

## - Infrastructure
### CI/CD:
For the CI/CD part, I have used 2 of the AWS Services ( CodeBuild & CodePipeline)

#### Pipeline flow:
Source (GitHub)     ->    Build(CodeBuild)        ->   Deploy(ECS)
![CodePipeline](https://i.imgur.com/Um4ulPc.png)

#### Infrastructure Design
![SystemDesign](https://i.imgur.com/e9wVRus.png)

* Running as an ECS cluster.
* Set up an application load balancer to traffic down to the service.
* Running multiple tasks with same task definition in different regions.
* Use ElastiCache to cache and speed up the GET request
* Use RDS to do the actual storage

## - System Design

##### Assumption1:  READ request : WRITE request = 100:1

##### Assumption2:  6 digits is enough, otherwise expire the link
* lower case A-Z = 26
* upper case a-z = 26
* 0-9 = 10
* 6-digits strings = (26 + 26 + 10) ^ 6 = 56800235584 (combination)
* 1000 Requests / s ->  1 day = 86400 * 1000 = 86400000
i.e. assuming there is enough room to save the hashing, otherwise expire the link

##### Design
```MD5(long_url + UUID)```

I want to keep the design as simple as possible. Therefore, I have made use of MD5 hash with a unique key (UUID) and save to DB. Then, check if there has duplicate entry. 
* If no duplicate entry, insert in and return
* If yes, re-hash and retry inserting into DB (Retry: 10 times)

Although it may lower the insert speed and there are some risk cannot insert after retrying 10 times, this design is simple.

There are some approaches I would like to introduce.
1. #### Pre-Generate Hash 
This approach can make sure there are no collision of hash. The only thing is pre-generating the hash and save it. When the request has arrived, give it a hash.
2. #### Range Hashing
Each microservice ask for the hashing vacancies and take responsibility for a range of hashing. For example, service A may produce hashing within 1-1000 and service B may produce hashing within 1001-2000. That make sure there is not collision.
3. #### Zookeeper
Use Zookeeper as a centralized DB. Let Zookeeper to distribute the unique counter to the service. However, this approach introduce more complexity.



  

