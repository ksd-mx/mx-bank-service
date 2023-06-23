
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 324654522070.dkr.ecr.us-east-1.amazonaws.com

ECR_REPOSITORY=$(aws ecr describe-repositories \
    --repository-names dev-mx-bank-service-repository \
    --query 'repositories[0].repositoryUri' \
    --output text)
IMAGE_TAG=$(openssl rand -hex 16)

docker build -t $ECR_REPOSITORY:latest .
docker tag $ECR_REPOSITORY:latest $ECR_REPOSITORY:$IMAGE_TAG
docker push $ECR_REPOSITORY:latest
docker push $ECR_REPOSITORY:$IMAGE_TAG
echo "::set-output name=image::$ECR_REPOSITORY:$IMAGE_TAG"

echo $ECR_REPOSITORY:$IMAGE_TAG
echo $ECR_REPOSITORY:latest