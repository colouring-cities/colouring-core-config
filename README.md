# colouring-core-config
A server configuration for hosting an instance of The Colouring Cities Core Platform

Repository for software itself resides at https://github.com/colouring-cities/colouring-core.  
The scripts are subtly different from the config for [Colouring London](https://github.com/colouring-cities/colouring-london-config), to allow both platforms to be deployed and tested on the same server.

## Basic info

Colouring London site is deployed at Azure, with Ubuntu used as OS.

There is a staging instance and production instance.

Staging is used for final testing before deploying on production and for demo deployment of experimental features.

## Technology

Azure for cloud deployment

React for application architecture

pm2 runs application itself

Nginx proxies and serves traffic

Let's Encrypt + certbot for https certificate

## Authorization

Note that staging and production instances are configured with IP filtering, to connect new administrator one of steps will include allowing to access from their IP.

Login is done using public-private key pairs and needs to be configured using Azure account.

## SSH config

On Linux it is typically in `~/.ssh/config`  

```
Host cl-sta
   HostName cl-staging.uksouth.cloudapp.azure.com
   User cladmin
   IdentitiesOnly yes
   IdentityFile ~/.ssh/private_key_for_colouring_london.pem
Host cl-prod
   HostName cl-production.uksouth.cloudapp.azure.com
   User cladmin
   IdentitiesOnly yes
   IdentityFile ~/.ssh/private_key_for_colouring_london.pem
```


This allows to connect using `ssh cl-sta` and `ssh cl-prod` commands.

## Deployment

ssh to staging/production and then:

```
cd colouring-london #this is a folder with the repository
git pull
cd ..
cd scripts
./build.sh
./predeploy.sh # so there is no need to copy npm_modules around
./deploy.sh # "skipping non-regular-file" is normal
```

To see `pl2` status use

`pm2 status` - on staging
`pm2 logs` - on staging

`sudo -u nodeapp pm2 status` - on production
`sudo -u nodeapp pm2 logs` - on production

(it is a minor difference in setup between production and staging, it may be useful to remove it)

### Migrations

Migrations are applied manually.

`psql colouringlondondb cldbadmin < 022.community.up.sql`

### Links

Public staging site, anyone on internet can view it: https://cl-staging.uksouth.cloudapp.azure.com/

Production site: https://colouring.london/

## Updates

It is safe to run `sudo reboot`

System should continue to work after reboot without any further action.

## Email testing

On the staging server email are not actually being send.

They can be seen at [https://ethereal.email/](https://ethereal.email/)

configuration info, including login and password to [https://ethereal.email/](https://ethereal.email/) is in the `/var/www/colouring-london/ecosystem.config.js` file.

## Backups

TODO: who maintains backups?

TODO: when restore from backups was tested last time?
