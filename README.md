<p align="center">
<a href="https://hub.docker.com/r/deercloud/socat">
<img src="https://user-images.githubusercontent.com/2666735/50724637-e5e88e80-112b-11e9-82af-828a58687ba9.png" />
</a>
</p>

<h1 align="center">socat</h1>

<p align="center">Multipurpose relay for binary protocols.</p>

<p align=center>
<a href="https://hub.docker.com/r/deercloud/socat">Docker Hub</a> ·
<a href="http://www.dest-unreach.org/socat/">Project Source</a> ·
<a href="https://t.me/linuxUpdate">Telegram Channel</a>
</p>

***

## latest version

|version|
|---|
|deercloud/socat:latest|
|deercloud/socat:current|
|deercloud/socat:1.7.3.2|


## environment variables

|name|value|
|---|---|
|LISTEN_PORT|8000|
|**FORWARD_HOST**|-|
|**FORWARD_PORT**|-|

***

### Pull the image

```bash
$ docker pull deercloud/socat
```

### Start a container

```bash
$ docker run -p 8000:8000 -p 8000:8000/udp -d \
  -e FORWARD_HOST=1.1.1.1 \
  -e FORWARD_PORT=80 \
  --restart always --name=socat deercloud/socat
```

### Display logs

```bash
$ docker logs socat

0.0.0.0:8000 <-- udp --> 1.1.1.1:80
0.0.0.0:8000 <-- tcp --> 1.1.1.1:80
```

### Example of OpenDNS

query OpenDNS with 443 port

```bash
$ dig www.google.com @208.67.222.222 -p 443

; <<>> DiG 9.10.6 <<>> www.google.com @208.67.222.222 -p 443
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 62620
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.google.com.			IN	A

;; ANSWER SECTION:
www.google.com.		300	IN	A	216.58.203.36

;; Query time: 360 msec
;; SERVER: 208.67.222.222#443(208.67.222.222)
;; WHEN: Sat Jan 05 21:00:46 CST 2019
;; MSG SIZE  rcvd: 59
```

forward 443 --> 53

```bash
$ docker run -p 53:8000/udp -d \
  -e FORWARD_HOST=208.67.222.222 \
  -e FORWARD_PORT=443 \
  --restart always --name=opendns deercloud/socat
```

query DNS with local port 53

```bash
$ dig www.google.com @127.0.0.1  

; <<>> DiG 9.10.6 <<>> www.google.com @127.0.0.1
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 46344
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.google.com.			IN	A

;; ANSWER SECTION:
www.google.com.		300	IN	A	216.58.203.36

;; Query time: 343 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Sat Jan 05 21:04:27 CST 2019
;; MSG SIZE  rcvd: 59
```
