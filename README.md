# java-tekton-demo
Tekton is a powerful yet flexible Kubernetes-native open-source framework for creating continuous integration and delivery (CI/CD) systems. It lets you build, test, and deploy across multiple cloud providers or on-premises systems by abstracting away the underlying implementation details. This repository lets you build, push and deploy a simple Java app using Tekton. For a detailed Tekton101, you can visit [this repo](https://github.com/dewan-ahmed/Tekton101/blob/master/1%20-%20An%20overview%20of%20Tekton%20Pipelines.md).

## Pre-requisites

- Basic knowledge around Docker, Kubernetes and OpenShift.
- Access to a Kubernetes/OpenShift cluster (this demo uses [OpenShift Playground](https://learn.openshift.com/playgrounds/openshift44/)).

## Setup

- Connect to your K8s/OpenShift cluster. If you don't have one, use [OpenShift Playground](https://learn.openshift.com/playgrounds/openshift44/). 
- Clone this repository.
- This demo pushes the image to a docker registry and sends a slack notification. Export the following values as environment variables:
  - DOCKER_USERNAME
  - DOCKER_PASSWORD
  - WEBHOOK_SLACK ([learn how to create a slack webhook](https://api.slack.com/messaging/webhooks)) 
 
## Steps

Navigate to **.tekton** folder and perform the following steps.

0. Make changes to reflect your own docker registry:

Make changes to **pipeline-run.yaml** and **deploy.yaml** and replace the lines with the docker-hub url with your own docker registry information. If you don't make these changes, you'll get a permission-error for pushing the image during pipeline-run.

1. Create the docker and webhook secrets:

```
kubectl apply -f docker-secret.yaml
```

```
kubectl apply -f webhook-secret.yaml
```

2. Create the service account:

```
kubectl apply -f service-account.yaml
```

3. Create the pipelineresource:

```
kubectl apply -f git-resource.yaml
```

4. Create the Tekton tasks:

```
kubectl apply -f task-build-src.yaml
```

```
kubectl apply -f task-deploy.yaml
```

```
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/master/task/send-to-webhook-slack/0.1/send-to-webhook-slack.yaml
```

5. Create the Tekton pipeline:

```
kubectl apply -f pipeline.yaml
```

6. Create the Tekton pipelinerun:

```
kubectl apply -f pipeline-run.yaml
```

7. Create a route to your application:

From OpenShift web console, switch to Administrator view and go to Networking --> Routes. If you haven't created a project, you probably are on **default** project. Make sure the correct project is selected from the drop-down. Create a new route by giving the route a name, selecting "app" as the service name and 8080 as the port number (all from drop-downs).

## Monitoring

1. You can use the Tekton CLI tkn to view tasks, pipeline and pipelinerun. Some useful commands:

List all tasks:

```
tkn t ls
```

Delete all tasks:

```
tkn t delete --all
```

List all pipelines:

```
tkn p ls
```

Delete all pipelines:

```
tkn p delete --all
```

List pipelineruns:

```
tkn pr ls
```

Describe pipelinerun (more detailed than list):

```
tkn pr describe <name-of-pipelinerun>
```

Logs for pipelinerun:

```
tkn pr logs <name-of-pipelinerun>
```

2. Alternatively, you can go to OpenShift web console, switch to developer perspective and ensure you're on the correct project. Then go to **Pipelines** tab and you will see the pipeline and pipelineruns including detailed logs. From the **Topology** tab, you can see your running application and clicking the circle will launch the application. Besides seeing the **Hello World** greeting, you can append "?name=<yourName>" at the end of the greeting endpoint and the page will display "Hello, <yourName>". 
  
3. Log on to your docker registry and you should be seeing a recently pushed image for a Java application.

If you've enjoyed this demo and/or if you have any question, please [drop me a note](www.dewanahmed.com).
