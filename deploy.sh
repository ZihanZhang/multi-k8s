docker build -t zihan42/multi-client:latest -t zihan42/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zihan42/multi-server:latest -t zihan42/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zihan42/multi-worker:latest -t zihan42/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zihan42/multi-client:latest
docker push zihan42/multi-server:latest
docker push zihan42/multi-worker:latest

docker push zihan42/multi-client:$SHA
docker push zihan42/multi-server:$SHA
docker push zihan42/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=zihan42/multi-server:$SHA
kubectl set image deployments/client-deployment client=zihan42/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zihan42/multi-worker:$SHA