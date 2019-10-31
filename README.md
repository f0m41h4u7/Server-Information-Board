# Server-Information-Board

Collects data from local server and sends it to example.com

Server must respond with status 204. 
The server side can be generated from `openapi.json`

```shell
./begin.sh -t 60 -a http://example.com/monitor/v1/server-data?server-name=abc.com
```
Help: `./begin.sh -h`

###Installing

1. Download all the scripts .sh and put them into /opt/mon

2. Run:

```shell
sudo crontab -e 
```

3. Write into your crontab file:

```shell
SHELL=/bin/bash

*/1 * * * * /opt/mon/mon.sh http://example.com/server-data?server-name=abc.com
```
In this example the data is being collected every 1 minute.
