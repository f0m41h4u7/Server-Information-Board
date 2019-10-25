# Server-Information-Board

Collect data from local server and send it to example.com 

```shell
./parse.sh http://example.com/monitor/v1/server-data?server-name=abc.com
```
Server must respond with status 204.
The server side can be generated from `openapi.json` on http://editor.swagger.io
