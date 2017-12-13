# A quick and dirty squid proxy

This was created for a buggy plugin that for some reason
requires an HTTP proxy. 


## Important Note

**This container creates a COMPLETELY OPEN forward proxy.**

Use security groups or ACLs to allow access from specific
addresses only.

If you follow the instructions below, make sure you don't
skip past the section where you add your IP address to
the inbound rules in the security group.


# Quickstart

1. Create the docker host:

    ```bash
docker-machine create \
    --driver amazonec2 \
    --amazonec2-region ap-southeast-2 \
    --amazonec2-request-spot-instance \
    hcm-proxy
```

2. Find the EC2 instance in the AWS console, and add the following tag(s):

    ```
Operating Schedule: 24x7
```

3. Next, add the following inbound port(s) to the security group:

    ```
src 103.196.84.250/32 dst tcp 3128
```

    Replace `103.196.84.250` with the public IP of `mfmaster`
    and `mfworker`. In this case, it was determined using
    `curl https://api.ipify.org`.

    Do use a specific host or subnet, not 0.0.0.0/0. You don't want
    an open proxy.

    While you're at it, consider locking down the other inbound
    ports too, especially port 22 (ssh).

4. Finally, build and deploy the docker container:

    ```bash
docker build -t bennettp123/tas-squid:latest .
docker run -d -p 3128:3128 bennettp123/tas-squid:latest
```

Once complete, update any DNS records, if necessary.
