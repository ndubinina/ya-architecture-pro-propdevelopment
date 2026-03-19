## воспроизведение

1) cp ./configs/audit-policy.yaml ~/.minikube/files/etc/ssl/certs

2) запускаем minikube:
minikube start \
    --extra-config=apiserver.audit-policy-file=/etc/ssl/certs/audit-policy.yaml \
    --extra-config=apiserver.audit-log-path=/var/log/audit.log

3) запускаем симулятор:
bash ./simulate-incident.sh

4) копируем файл аудита и запускаем фильтр событий
./filter_audit.sh >> audit-extract.json

## результат
   - [analysis.md](./analysis.md)
   - [audit-extract.json](./audit-extract.json)
   - [filter_audit.sh](./filter_audit.sh)