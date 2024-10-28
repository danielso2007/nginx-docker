# Estudo proxy reverso

Para iniciar, só executar `./start.sh`, mas antes faça o passo do item `Adicionar o nginx no host`.

Após iniciar, acesse [https://tomcat.example.com](https://tomcat.example.com) ou [https://apache.example.com](https://apache.example.com)

# Adicionar o nginx no host

```shell
sudo nano /etc/hosts
```

Verificar o IP do container `reverse` que é o nginx. Em seu docker compose, o ip foi fixado em `11.5.0.2`. Esse endereço não deve mudar podendo ficar no host.

Adicionado:

```shell
11.5.0.2 tomcat.example.com
11.5.0.2 apache.example.com
```

# Criando os certificados dos App

Caso você queira criar manualmente, mas já está incluído no `start.sh`.

#### tomcat:

```shell
cd apps/tomcat/certificado
./criar-certificado.sh -d tomcat.example.com -i 10.5.0.5 -s 123456
```

#### apache:

```shell
cd apps/tomcat/certificado
./criar-certificado.sh -d apache.example.com -i 10.6.0.6 -s 123456
```

# Obter o IP do proxy

```shell
docker inspect <nome_do_container> -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps --filter name=reverse -q)
```