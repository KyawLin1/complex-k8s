# Build images for production
docker build -t kyawlin/complex-client:latest -t kyawlin/complex-client:$GIT_SHA ./client
docker build -t kyawlin/complex-server:latest -t kyawlin/complex-server:$GIT_SHA ./server
docker build -t kyawlin/complex-worker:latest -t kyawlin/complex-worker:$GIT_SHA ./worker
# Push images to Docker with tag:latest
docker push kyawlin/complex-client:latest
docker push kyawlin/complex-server:latest 
docker push kyawlin/complex-worker:latest
# Push images to Docker with tag:$GIT_SHA
docker push kyawlin/complex-client:$GIT_SHA
docker push kyawlin/complex-server:$GIT_SHA
docker push kyawlin/complex-worker:$GIT_SHA
kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=kyawlin/complex-client:$GIT_SHA
kubectl set image deployments/server-deployment server=kyawlin/complex-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=kyawlin/complex-worker:$GIT_SHA