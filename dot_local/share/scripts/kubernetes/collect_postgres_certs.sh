mkdir -p ~/.postgresql/apps-cluster
mkdir -p ~/.postgresql/data-cluster
kubectl -n cnpg-apps get secret apps-cluster-user-cert -o jsonpath='{.data.tls\.crt}' | base64 -d >~/.postgresql/apps-cluster/user.crt
kubectl -n cnpg-apps get secret apps-cluster-user-cert -o jsonpath='{.data.tls\.key}' | base64 -d >~/.postgresql/apps-cluster/user.key
kubectl -n cnpg-apps get secret apps-cluster-user-cert -o jsonpath='{.data.ca\.crt}' | base64 -d >~/.postgresql/apps-cluster/apps-ca.crt
kubectl -n data get secret data-cluster-user-cert -o jsonpath='{.data.tls\.crt}' | base64 -d >~/.postgresql/data-cluster/user.crt
kubectl -n data get secret data-cluster-user-cert -o jsonpath='{.data.tls\.key}' | base64 -d >~/.postgresql/data-cluster/user.key
kubectl -n data get secret data-cluster-user-cert -o jsonpath='{.data.ca\.crt}' | base64 -d >~/.postgresql/data-cluster/data-ca.crt
chmod 600 ~/.postgresql/user.key
