# Capo

Reverse Proxy with Basic Authentication

## Usage

Start it with:

```bash
$ go build
$ cat >> config.yaml <<EOL
users:
  - username: admin
    password: pass
EOL
$ ./capo start
```

Use it like:

```bash
$ curl http://localhost:6634/
Unauthorized
$ curl http://admin:pass@localhost:6634/
{
  "args": {},
  "headers": {
    "Accept": "*/*",
    "Accept-Encoding": "gzip",
    "Authorization": "Basic dGVzdDp0ZXN0MQ==",
    "Host": "httpbin.org",
    "User-Agent": "curl/8.4.0",
    "X-Amzn-Trace-Id": "Root=1-65f8675b-7f79a49a4d55a63170385c81"
  },
  "origin": "142.122.13.19",
  "url": "https://httpbin.org/get"
}
```
