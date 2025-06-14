

# serverpod
docker compose up -d
serverpod generate --experimental-features=all
dart bin/main.dart --apply-migrations
serverpod create-migration --experimental-features=all --force

docker compose down -v

#kubernaties

[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('пароль'))

# Проверим поды
kubectl get pods
kubectl get pods -w

# Проверим сервисы
kubectl get svc
kubectl get svc ts3-server-service -o yaml 

# логи приложения
kubectl logs -f -l app=ts3-server


# Тестируем endpoint для получения списка TestData
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method POST -ContentType "application/json" -Body '{"endpoint":"testData","method":"listTestDatas","params":{}}'

# Проверка доступности напрямую
Invoke-WebRequest -Uri "https://api5.my-points.ru/" -Method GET

# Проверим детали Ingress:
bashkubectl describe ingress sync2-server-ingress

docker login dbe81550-wise-chickadee.registry.twcstorage.ru
docker build -t dbe81550-wise-chickadee.registry.twcstorage.ru/ts3-server:latest -f Dockerfile.prod .
docker push dbe81550-wise-chickadee.registry.twcstorage.ru/ts3-server:latest

kubectl apply -f k8s/

kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/job.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
kubectl apply -f k8s/secret.yaml


#delete project
kubectl delete -f k8s/

kubectl delete service ts3-server-service
kubectl delete ingress ts3-server-ingress
kubectl delete configmap serverpod-config-ts3
kubectl delete job serverpod-migration-job-ts3
kubectl delete secret serverpod-secrets-ts3
kubectl delete deployment ts3-server-deployment

#restart deployment
kubectl rollout restart deployment ts3-server-deployment

kubectl create secret generic serverpod-secrets-ts3 --from-literal=database-password='пароль' --from-literal=redis-password='пароль' --from-literal=service-secret='пароль'
