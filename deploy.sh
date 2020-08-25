docker build -t jaredzhang09/multi-client:latest -t jaredzhang09/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jaredzhang09/multi-server:latest -t jaredzhang09/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jaredzhang09/multi-worker:latest -t jaredzhang09/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push jaredzhang09/multi-worker:latest
docker push jaredzhang09/multi-server:latest
docker push jaredzhang09/multi-client:latest

docker push jaredzhang09/multi-worker:$GIT_SHA
docker push jaredzhang09/multi-server:$GIT_SHA
docker push jaredzhang09/multi-client:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=jaredzhang09/multi-server:$GIT_SHA
kubectl set image deployment/worker-deployment worker=jaredzhang09/multi-worker:$GIT_SHA
kubectl set image deployment/client-deployment client=jaredzhang09/multi-wokrer:$GIT_SHA