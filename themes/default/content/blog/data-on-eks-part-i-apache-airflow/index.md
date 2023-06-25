---
title: "Data on EKS, Part I - Apache Airflow"
date: 2023-06-20T15:17:06-04:00
meta_desc: "In this post, we'll show you how to use Pulumi to deploy a Kubernetes cluster on EKS and then deploy Apache Airflow to it via Helm."
meta_image: airflow-on-eks.png
authors:
    - josh-kodroff
tags:
    - aws
    - kubernetes
    - eks
    - apache-airflow
---

Amazon's Elastic Kubernetes Service (EKS) is a popular solution for running data processing pipelines on Kubernetes. In this post, we'll show you how to use Pulumi to deploy a Kubernetes cluster on EKS and then deploy Apache Airflow to it via [Helm](https://helm.sh/).

<!--more-->

## Introduction

Apache Airflow is a popular open-source tool for orchestrating complex workflows and data processing pipelines. Airflow organizes tasks into directed acyclic graphs (DAGs), with dependencies between tasks represented as edges in the graph. Airflow's web UI allows you to visualize your DAGs and monitor their progress. Airflow also has a rich ecosystem of plugins for interacting with various data sources and services.

EKS is AWS' managed Kubernetes solution. EKS saves you the trouble of managing your own Kubernetes control plane, but you still need to manage your own worker nodes. In this post, we'll show you how to use Pulumi to deploy a Kubernetes cluster on EKS and then deploy Apache Airflow to it.

## Creating a VPC and EKS Cluster

When creating the AWS infrastructure we need to run Airflow, we'll rely on [the VPC component](https://www.pulumi.com/registry/packages/awsx/api-docs/ec2/vpc/) in [Pulumi's AWSX package](https://www.pulumi.com/registry/packages/awsx/), and the [EKS cluster component](https://www.pulumi.com/registry/packages/eks/api-docs/cluster/) in [Pulumi's EKS package](https://www.pulumi.com/registry/packages/eks/). Both of these packages are part of Pulumi's [Crosswalk for AWS](https://www.pulumi.com/docs/guides/crosswalk/aws/) and contain components that encapsulate multiple resources which make deploying more advanced infrastructure much easier. For example, the `awsx.ec2.Vpc` component includes a fully-functional VPC with public and private subnets across three Availability Zones and all necessary egress and routes.

## Deploying Apache Airflow

The Airflow Helm chart deploys the following components to your cluster:

- A PostgreSQL database for storing Airflow's metadata
- A Redis instance for storing Airflow's task queue
- A web service for serving the Airflow web UI
- A scheduler service for running Airflow's scheduler
- A worker service for running Airflow's worker processes

The Airflow Helm chart also deploys a Kubernetes job that runs Airflow's database migrations. The job will run automatically when you first deploy the chart, and it will run again whenever you upgrade the chart to a new version.

## Testing the Airflow Deployment

The AirFlow Helm chart does not expose the web UI to the public internet by default. To access the web UI, you'll need to set up port forwarding to the Airflow web service. You can do this by running the following command:

```bash
kubectl port-forward svc/airflow-web 8080:8080
```

You should now be able to access the Airflow web UI at `http://localhost:8080`.
