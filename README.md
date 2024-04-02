# Learner Management Service - Team KARV

![Example of adding an image](/media/app_screenshot.png)


<a name="readme-top"></a>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About The Project</a>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#planning">Planning</a></li>
    <li><a href="#biggest-challenges">Biggest Challenges</a></li>
    <li><a href="#wins">Wins</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About

A team project to build the cloud infrastructure and deploy a backend and frontend application for a learner management system and log-in portal, using a relational database to store credentials.

**Built With**

To build our project we used the following tools:

<div style="display: flex; flex-wrap: wrap; align-items: center; justify-content: start;">
  <img src="/media/Terraform.svg" alt="terraform" width="50" style="margin-right: 10px;"/>
  <img src="/media/AWS.svg" alt="aws" width="50" style="margin-right: 10px;"/>
  <img src="/media/Kubernetes.svg" alt="kubernetes" width="50" style="margin-right: 10px;"/>
  <img src="/media/Docker.svg" alt="docker" width="50" style="margin-right: 10px;"/>
  <img src="/media/Grafana.svg" alt="grafana" width="50" style="margin-right: 10px;"/>
  <img src="/media/PostgresSQL.svg" alt="postgres" width="50" style="margin-right: 10px;"/>
  <img src="/media/Prometheus.svg" alt="prometheus" width="50" style="margin-right: 10px;"/>
  <img src="/media/CircleCI.svg" alt="circleci" width="50" style="margin-right: 10px;"/>
  <img src="/media/ArgoCD.svg" alt="argocd" width="50" style="margin-right: 10px;"/>
</div>


<!-- GETTING STARTED -->

## Getting Started

**Set Up**

1. Fork and clone the repo
2. Create two AWS Secrets
 a. Go to AWS secrets manager
 b. Hit “Store a new secret”
 c. Hit “Other type of secret” --> “Key/value”
 d. Add a key of “username” and a value of your chosen username
 e. Set the secret name to “POSTGRES_USERNAME2”
 f. Then repeat steps b-e but this time to add:
    - “password” and value of your chosen password
    - Set the secret name to “POSTGRES_PASSWORD2”
    **NOTE:** You can set the secret names to whatever you want, so long as you change them in /[learner-management-service/RDS-terraform/terraform.tfvars](https://github.com/vnrosu/learner-management-service/blob/f3bbfccf3c75b9000e23e14d6911df2be80814ec/RDS-terraform/terraform.tfvars#L9)

3. CD into the base-terraform directory and run these commands to get the EKS spun up.
    - ```terraform init```
    - ```terraform apply```

4. CD into the RDS-terraform directory and run these commands to get the RDS spun up.
    - ```terraform init```
    - ```terraform apply```

5. Open CircleCI
  a. Create a Project referencing your repo
  b. Create the environment variables for your:
    - ```DOCKERHUB_USERNAME```
    - ```DOCKERHUB_PASSWORD```
  c. NEED TO UPDATE STEPS FOR THEM RUNNING AND CREATING DH IMAGES

6. Install NGINX
  a. Install ```ingress-nginx```
  b. ```kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/cloud/deploy.yaml```
  c. ```kubectl get svc -n ingress-nginx```
  d. Store the URL that is returned, you'll need this later

7. Amend the .yaml files
  a. Add the NGINX URL to [Ingress.yaml](https://github.com/vnrosu/learner-management-service/blob/d594eb03a3297468652448a0c762835bff90d7a3/kubernetes/ingress.yaml#L7)
  b. Edit the frontend-deployment.yaml [image name](https://github.com/vnrosu/learner-management-service/blob/d594eb03a3297468652448a0c762835bff90d7a3/kubernetes/frontend-deployment.yaml#L17) to match your image in DockerHub
  c. Edit the backend-deployment.yaml [image name](https://github.com/vnrosu/learner-management-service/blob/d594eb03a3297468652448a0c762835bff90d7a3/kubernetes/backend-deployment.yaml#L17C11-L17C49) to match your image in DockerHub

8. Create Kubernetes secrets
  a. For the frontend:
  ```kubectl create secret docker-registry docker-cred-frontend \
--docker-username=<YOUR DOCKER USERNAME> \
--docker-password=<YOUR DOCKER TOKEN> \
--namespace=default
```
  b. For the backend:
  ```kubectl create secret docker-registry docker-cred-backend \
--docker-username=<YOUR DOCKER USERNAME> \
--docker-password=<YOUR DOCKER TOKEN> \
--namespace=default
```

9. Run ArgoCD
  a. ```kubectl create namespace argocd```
  b. ```kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml```
  c. ```watch kubectl get pods -n argocd```
  d. Wait until you can see your pods up and running
  e. ```kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d```
  f. Make a note of the returned password
  g. ```kubectl port-forward svc/argocd-server -n argocd 8080:443```

10. Log in to ArgoCD
  a. Go to [https://localhost:8080/](https://localhost:8080/)
  b. Sign in with your credentials:
    - username: admin
    - password: (This was given in the last step)

11. Set up Repo and App in ArgoCD
  a. Settings --> Repositories --> Connect to Repository
    - Connect to your fork of the GH repo
  b. Applications --> New App
    - Add the settings from the screenshot below:
    ADDDD SCREENSHOT HERE
  c. Make sure it's Synced and Healthy

12. Test the functionality
  a. Access the app via your NGINX URL from earlier and test
  b. ADD TESTING STEPS

13. MONITORING AND ALERTING
  a. ADD FURTHER STEPS


**Running**

- Example bullet point
- Example bullet point
- Example bullet point
- Example bullet point

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->

## Project Brief

This was our final project for the Northcoders Cloud Engineering bootcamp and the brief set out some criteria we had to satisfy:

- All infrastructure and services should be created using infrastructure as code
- Frontend being built, tested and packaged in an automated CI fashion
- Backend being built, tested and packaged in an automated CI fashion
- An automated way of deploying the frontend in either a continuous delivery or continuous deployment fashion.
- An automated way of deploying the backend in either a continuous delivery or continuous deployment fashion.


## Planning


## MVP - Minimum Viable Product

- [x] EKS created with IAC
- [x] RDS created with IAC, which persists when EKS is destroyed
- [x] Frontend built, tested and packaged in CircleCI
- [x] Backend built, tested and packaged in CircleCI
- [x] Automated deployment using ArgoCD
- [x] Utilise InfraCost for AWS cost reporting


## NTH - Nice to have

- [ ] Monitoring and Alerting with Prometheus and Grafana
- [ ] Centralise our image registry in AWS ECR
- [ ] Create alternate IAC in Pulumi, as a Terraform alternative
- [ ] Slack and/or email notifications


<p align="right">(<a href="#readme-top">back to top</a>)</p>


## Biggest Challenges

- **Group work with AWS**
  We went down a bit of a rabbit-hole early on with setting up IAM credentials so that all of the team could have access to the EKS. After half a day of troubleshooting we couldn't seem to get it to work correctly, and then we decided to abandon that and instead just create our own EKS when needed for testing. This ultimately worked out to be fast enough for what we needed. 
- **Jenkins for Continuos Integration**
  The team pursued using JenkinsCI instead of CircleCI but after a day we determined that we'd stick with CircleCI, a product we were more familiar with, until we reached MVP. After moving forward with the project and reaching MVP we determined that the time was spent adding new functionality and so we abandoned using Jenkins.


## Wins

- **Example**
  Example filler text


<p align="right">(<a href="#readme-top">back to top</a>)</p>

