# Server-Information-Board

Collects data from local server and sends it to example.com

Server must respond with status 204. 
OpenAPI spec: `openapi.json`

### Installing

1. Download mon-1-0.src.rpm

2. If you use CentOS/RHEL, run:

```shell
sudo rpm –i mon-1-0.src.rpm
```

If you use Ubuntu/Debian, run:

```shell
sudo apt-get install alien dpkg-dev debhelper build-essential
```

```shell
sudo alien mon-1-0.src.rpm
```

```shell
sudo dpkg -i mon-1-0.src.deb
```

3. Run:

```shell
sudo crontab -e 
```

4. Write into your crontab file:

```shell
SHELL=/bin/bash

*/1 * * * * /opt/mon/mon.sh http://example.com/server-data?server-name=abc.com
```
In this example the data is being collected every 1 minute, but you can set any other time interval.
