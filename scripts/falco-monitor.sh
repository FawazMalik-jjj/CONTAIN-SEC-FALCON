#!/bin/bash
# Stream Falco alerts to CloudWatch
kubectl logs -f -l app=falco | \
grep 'CRITICAL' | \
aws logs put-log-events \
  --log-group-name "/falco/alerts" \
  --log-stream-name "$(hostname)" \
  --log-events -