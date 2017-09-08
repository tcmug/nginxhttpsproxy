#!/bin/bash

certbot renew --pre-hook "killall nginx"
