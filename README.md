# quick and dirty squid proxy

**Important**

This docker container is a COMPLETELY OPEN forward proxy.

Use security groups or ACLs to allow access from specific
addresses only.

If you follow the instructions below, make sure you don't
skip past the section where you add your IP address to
the inbound rules in the security group.


# Quickstart

Steps to create:

First, create the docker machine:

```bash
docker-machine create \
    --driver amazonec2 \
    --amazonec2-region ap-southeast-2 \
    --amazonec2-request-spot-instance \
    hcm-proxy
```

Next, find the EC2 instance in the AWS console, and add tag
`Operating Schedule`: `24x7`.

Next, add the following inbound rule to the security group:
`Custom TCP Rule: TCP 3128 103.196.84.250/32`

(Replace `103.196.84.250` with the public IP of `mfmaster`
and `mfworker`. In this case, it was determined using
`curl -L http://whatsmyip.com`.)

Do use a specific host or subnet, not 0.0.0.0/0. You don't want
an open proxy.

While you're at it, consider locking down the other inbound
ports too, especially port 22 (ssh).

Finally, build and deploy the docker container:

```bash
docker build -t bennettp123/tas-squid:latest .
docker run -d -p 3128:3128 bennettp123/tas-squid:latest
```

