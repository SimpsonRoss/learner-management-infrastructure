# Learner Management Service - Team KARV

![Northcoders portal screenshot](/media/app_screenshot.png)

<a name="readme-top"></a>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About The Project</a>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#planning">Planning</a></li>
    <li><a href="#biggest-challenges">Biggest Challenges</a></li>
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

1. **Fork and clone the repo**
2. **Create AWS secrets for database credentials**
    - Go to AWS secrets manager
    - Hit “Store a new secret”
    - Hit “Other type of secret” &rarr; “Key/value”
    - Add a key of “username” and a value of your chosen username
    - Set the secret name to “POSTGRES_USERNAME2”
    - Then repeat steps but this time to add:
      - “password” and value of your chosen password
      - Set the secret name to “POSTGRES_PASSWORD2”
      - **NOTE:** You can set the secret names to whatever you want, so long as you change them in /[learner-management-service/RDS-terraform/terraform.tfvars](https://github.com/vnrosu/learner-management-service/blob/f3bbfccf3c75b9000e23e14d6911df2be80814ec/RDS-terraform/terraform.tfvars#L9)

3. **Spin up the EKS**
    - cd into the base-terraform directory and run these commands to get the EKS set up.
      - `terraform init`
      - `terraform apply`

4. **Spin up the Database**
    - cd into the RDS-terraform directory and run these commands to get the RDS set up.
      - `terraform init`
      - `terraform apply`
      - Copy and store the returned 'rds_instance_endpoint' for accessing the database later on

5. **Set up CircleCI** - [https://app.circleci.com/](https://app.circleci.com/)
    - Create an account or log in
    - Create a project for the Frontend
        - Projects &rarr; Create Project &rarr; GitHub
        - Name your project and choose the forked repository
        - Hit 'Review configuration file' &rarr; 'Use Existing Config' &rarr; Start Building
        - Project Settings &rarr; 
            - Edit the Config Source &rarr; Change 'Config File Path' to ```frontend-app/.circleci/config.yml```
            - Create the environment variables: `DOCKERHUB_USERNAME` and `DOCKERHUB_PASSWORD`
    - Repeat the steps but this time for the Backend
        - Use 'Config File Path' to ```backend-app/.circleci/config.yml```

6. **Set up and Run ArgoCD**
    ```
    kubectl create namespace argocd
    ```
    ```
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```
    ```
    watch kubectl get pods -n argocd
    ```
    - Wait until you can see your pods all listed as 'Running'
    - Get the password 
    ```
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```
    - Make a note of the returned password
    - Port forward the service 
    ```
    kubectl port-forward svc/argocd-server -n argocd 8080:443
    ```

7. **Log in to ArgoCD**
   - Go to [https://localhost:8080/](https://localhost:8080/)
   - Sign in with your credentials:
      - username: admin
      - password: (This was given in the last step)

8. **Amend Deployment files**
    - Edit the frontend-deployment.yaml [image name](https://github.com/vnrosu/learner-management-service/blob/d594eb03a3297468652448a0c762835bff90d7a3/kubernetes/frontend-deployment.yaml#L17) and tag to match your image in DockerHub
    - Edit the backend-deployment.yaml [image name](https://github.com/vnrosu/learner-management-service/blob/d594eb03a3297468652448a0c762835bff90d7a3/kubernetes/backend-deployment.yaml#L17C11-L17C49) and tag to match your image in DockerHub

9. **Create Kubernetes secrets**

    - Replace the URL value of SPRING_DATASOURCE_URL with the URL that was outputted when you built your RDS with terraform (Step 4) and run:
      ```
      kubectl create secret generic spring-datasource-url --from-literal=SPRING_DATASOURCE_URL='jdbc:postgresql://terraform-20240327101142944900000002.cpgwwgu0sw2c.eu-west-2.rds.amazonaws.com:5432/mydatabase'
      kubectl create secret generic spring-datasource-username --from-literal=SPRING_DATASOURCE_USERNAME='postgres'
      kubectl create secret generic spring-datasource-password --from-literal=SPRING_DATASOURCE_PASSWORD='SuperSecurePassword'
      ```

    - Add in your Docker username and token and run:
      ```
      kubectl create secret docker-registry docker-cred \
      --docker-username=<YOUR DOCKER USERNAME> \
      --docker-password=<YOUR DOCKER TOKEN> \
      --namespace=default
      ```

10. **Set up Repsitory and Application in ArgoCD**
    - Settings &rarr; Repositories &rarr; Connect to your forked repository
    - Applications &rarr; New App
      - Set up Prometheus as a new Application
      - Set up a new Application for this project. Use the settings below:
      ![App Settings for Argo CD](/media/Argo-App-Settings.png)
      - Make sure it's Synced and Healthy, like this:
      ![How The App Looks When Healthy](/media/Argo-Healthy-Synced.png)
      

11. **Get the backend service load balancer**
    ```
    kubectl get svc
    ```
    - Update the URL in the frontend-app/.env file 
    - Commit and Push these changes to your forked repo

12. **Test the functionality**
    ```
    kubectl get svc
    ```
    - Grab the loadbalancer URL for your frontend
    - Visit the link, and test app behaviour:
      - Sign up
      - Log in

13. **Setup and Login to Grafana**
    ```
    kubectl port-forward svc/prometheus-grafana 9000:80
    ```
    - Go to [https://localhost:9000/](https://localhost:9000/)
      - Username: admin
      - Password: prom-operator


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

- [X] Monitoring and Alerting with Prometheus and Grafana
- [ ] Centralise our image registry in AWS ECR
- [X] Set up ZenDuty oncall rotation and link to Grafana alerts
- [ ] Create alternate IAC in Pulumi, as a Terraform alternative
- [ ] Slack and/or email notifications

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Biggest Challenges

- **Group work with AWS**
  We went down a bit of a rabbit-hole early on with setting up IAM credentials so that all of the team could have access to the EKS. After half a day of troubleshooting we couldn't seem to get it to work correctly, and then we decided to abandon that and instead just create our own EKS when needed for testing. This ultimately worked out to be fast enough for what we needed.
- **Jenkins for Continuos Integration**
  The team pursued using JenkinsCI instead of CircleCI but after a day we determined that we'd stick with CircleCI, a product we were more familiar with, until we reached MVP. After moving forward with the project and reaching MVP we determined that the time was spent adding new functionality and so we abandoned using Jenkins.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
