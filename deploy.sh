docker build -t ytk007/multi-client:latest -t ytk007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ytk007/multi-server:latest -t ytk007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ytk007/multi-worker:latest -t ytk007/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ytk007/multi-client:latest
docker push ytk007/multi-server:latest
docker push ytk007/multi-worker:latest

docker push ytk007/multi-client:$SHA
docker push ytk007/multi-server:$SHA
docker push ytk007/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ytk007/multi-server:$SHA
kubectl set image deployments/client-deployment client=ytk007/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ytk007/multi-worker:$SHA
