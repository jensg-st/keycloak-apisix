#!/bin/bash

curl http://127.0.0.1:9180/apisix/admin/routes/6 -H 'X-API-KEY: changeme' -X PUT -d '
{
  "uri": "/secure/*",
  "plugins":{
    "openid-connect":{
      "client_id": "demo",
      "client_secret": "KN7ac3NcvS9ihwmXZJMPBexnEKlxX7H2",
      "discovery": "http://127.0.0.1:8080/realms/demo/.well-known/openid-configuration",
      "bearer_only": false,
      "realm": "master",
      "redirect_uri": "/secure/redirect_uri",
      "post_logout_redirect_uri": "http://127.0.0.1:9080/index.html",
      "logout_path": "/secure/logout"
    }
  },
  "upstream":{
    "type": "roundrobin",
    "nodes":{
      "127.0.0.1:9999":1
    }
  }
}'



curl http://127.0.0.1:9180/apisix/admin/routes/7 -H 'X-API-KEY: changeme' -X PUT -d '
{
  "uri": "/index.html",
  "upstream":{
    "type": "roundrobin",
    "nodes":{
      "127.0.0.1:9999":1
    }
  }
}'