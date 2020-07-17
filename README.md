# Tor-Proxy com Docker-Compose
Um cliente Tor e uma instância do privoxy para navegação através de HTTP.

## Detalhes 
O cliente Tor pode ser usado como proxy socks5 diretamente na porta 9150.
Se sua aplicação apenas utilizar o protocolo HTTP, utilize a porta 9151. O privoxy receberá a conexão e por sua vez usará o Tor como proxy, fazendo as requisições para a nuvem utilizarem o protocolo SOCKS5.

## Utilização

```shell
docker-compose up
```

Lembre-se de utilizar `&` no final do comando para fazer o processo rodar em background. Opicionalmente redirecione a saida.


