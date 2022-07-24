# Labtastic Apps

A collection of Selfhosted Apps for your homelab/selfhosting needs

If you are a Comcast subscriber please view the warning below

## Install

1. Clone labtastic repo
2. Change to the labtastic directory
3. run `./labtastic init` (defaults to /srv/labtastic for app data)
4. follow printed instructions

```bash
git clone https://github.com/labtastic/labtastic.git labtastic
cd labtastic
./labtastic init
```

## Additional Tasks
### Setup ACME CA Authority

Run the following command inside labtastic directory

```bash
docker compose -p labtastic -f apps/base/docker-compose.yml exec labtastic-ca bash
```

Run the following inside of the labtastic-ca container
```
step ca provisioner add acme --type ACME
```

### (Optional) Add Labtastic CA to trusted CA's
copy the root ca at `$APP_DATA/base/ca/certs/root_ca.crt` to any machine that needs to access services via https and follow your distros instructions for adding the CA to trusted roots.

#### NOTE: Google Chrome 

Google Chrome manages its own trust store and so you will need to import it via the browser to get chrome to trust the CA.

---
## Avaliable Apps

- [base](/apps/base/README.md)
- [monitoring](/apps/monitoring/README.md)


---


## Comcast and Other Transparent DNS Proxy ISP Subscribers

*Verified issue if using rental hardware*

*Solution will work for any provider that uses a transparent DNS proxy*

Due to Comcast's use of a transparent DNS proxy all port 53 queries on the network are redirected to their own DNS servers.

This breaks the ability to provide DNS for services launched with Labtastic since the query will never reach the dns container.

### Solution
The solution is put your Comcast modem in bridge mode and then put your own router infront of it and point DNS to the labtastic server IP. Then you will need to change the DNS server settings to use either DoH or DoT to ensure that your selected recursive servers are used instead of still being intercepted by Comcast