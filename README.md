[![Go](https://github.com/jjngx/coffeeshop/actions/workflows/go.yml/badge.svg?branch=main)](https://github.com/jjngx/coffeeshop/actions/workflows/go.yml)
![GitHub](https://img.shields.io/github/license/jjngx/coffeeshop)
![GitHub go.mod Go version](https://img.shields.io/github/go-mod/go-version/jjngx/coffeeshop)
[![Go Report Card](https://goreportcard.com/badge/github.com/jjngx/coffeeshop)](https://goreportcard.com/report/github.com/jjngx/coffeeshop)


# coffeeshop

`coffeeshop` is a tiny web service for testing NGINX Ingress Controller. It allows to serve a handful of endpoints and emulate response delays.

# Setting global latency

To setup a global latency export env var `COFFEESHOP_LATENCY`. For example,  `COFFEESHOP_LATENCY=10s` will make coffeeshop respond with 10s delay. Default latency is `100ms`.

# Running locally

From root dir:
```bash
$ COFFEESHOP_LATENCY=10s go run cmd/coffeeshop-api/main.go
```
