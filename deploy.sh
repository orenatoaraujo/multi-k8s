docker build -t renatoaraujo/multi-client:latest -t renatoaraujo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t renatoaraujo/multi-server:latest -t renatoaraujo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t renatoaraujo/multi-worker:latest -t renatoaraujo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push renatoaraujo/multi-client:latest
docker push renatoaraujo/multi-server:latest
docker push renatoaraujo/multi-worker:latest

docker push renatoaraujo/multi-client:$SHA
docker push renatoaraujo/multi-server:$SHA
docker push renatoaraujo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=renatoaraujo/multi-server:$SHA
kubectl set image deployments/client-deployment client=renatoaraujo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=renatoaraujo/multi-worker:$SHA
