docker build -t hootielander/multi-client:latest -t hootielander/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hootielander/multi-server:latest -t hootielander/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hootielander/multi-worker:latest -t hootielander/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hootielander/multi-client
docker push hootielander/multi-server
docker push hootielander/multi-worker

docker push hootielander/multi-client:$SHA
docker push hootielander/multi-server:$SHA
docker push hootielander/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hootielander/multi-server:$SHA
kubectl set image deployments/client-deployment client=hootielander/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hootielander/multi-worker:$SHA