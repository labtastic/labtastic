# Labtastic Apps

A collection of Selfhosted Apps for your homelab/selfhosting needs

If you are a Comcast subscriber please view the warning below

## Usage

## Avaliable Apps



# Comcast and Other Transparent DNS Proxy ISP Subscribers

*Verified issue if using rental hardware*

*Solution will work for any provider that uses a transparent DNS proxy*

Due to Comcast's use of a transparent DNS proxy all port 53 queries on the network are redirected to their own DNS servers.

This breaks the ability to provide DNS for services launched with Labtastic since the query will never reach the dns container.

## Solution
The solution is put your Comcast modem in bridge mode and then put your own router infront of it and point DNS to the labtastic server IP. Then you will need to change the DNS server settings to use either DoH or DoT to ensure that your selected recursive servers are used instead of still being intercepted by Comcast