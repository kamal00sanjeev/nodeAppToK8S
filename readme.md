
# check loggedin user profile
aws iam get-login-profile --user-name sanjeev

=================================

# create EKS cluster (eksctl takes default configuration to create resources)
eksctl create cluster --name my-eks-cluster --region ap-south-1

# view cluster nodes
kubectl get nodes -o wide

# View the workloads running on your cluster.
kubectl get pods -A -o wide

# delete cluster and nodes
eksctl delete cluster --name my-eks-cluster --region ap-south-1

=================================<1>.
# Create ECR repository
aws ecr create-repository \
    --repository-name test-ecr-repo \
    --image-scanning-configuration scanOnPush=true \
    --region ap-south-1

# Retrieve an authentication token and authenticate your Docker client to your ECR
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/s3k1y8m9

# Build your Docker image (Make sure Docker is running)
docker build -t test-ecr-repo .

# tag your image 
docker tag test-ecr-repo:latest public.ecr.aws/s3k1y8m9/test-ecr-repo:latest

# push this image to your newly create ECR
docker push public.ecr.aws/s3k1y8m9/test-ecr-repo:latest

====================================<2>.

# Create EKS Cluster using cludformation temlate
eksctl create cluster -f k8s/eks-cluster.yml

# check nodes
kubectl get nodes -o wide

# check pods
kubectl get pods -A -o wide

# deploy
kubectl create -f k8s/deployment.yml

# deploy service
kubectl apply -f k8s/service.yml

# ensure everything worked fine
kubectl get deploy
kubectl get pods

# List Service
kubectl get svc

D:\node-project-ws\nodeApp>kubectl get svc
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)          AGE
kubernetes        ClusterIP      10.100.0.1      <none>                                                                    443/TCP          20m
nodeapp-service   LoadBalancer   10.100.238.67   a917e592dc5d840ac9c0687da51f9879-341520782.ap-south-1.elb.amazonaws.com   8080:32460/TCP   6m48s

# Get Public IP
kubectl get nodes -o wide

# Access Application
http://a917e592dc5d840ac9c0687da51f9879-341520782.ap-south-1.elb.amazonaws.com:8082/

D:\node-project-ws\nodeApp>curl http://a917e592dc5d840ac9c0687da51f9879-341520782.ap-south-1.elb.amazonaws.com:8082/
Hello!! this is running...


===========================================<3>.
# Clean Up Kubernetes on AWS
# Delete service
kubectl delete -f k8s/service.yml

# Delete deployment
kubectl delete -f k8s/deployment.yml

# Delete EKS Cluster resouces
eksctl delete cluster -f k8s/eks-cluster.yml

