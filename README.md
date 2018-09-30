# Cronbox

This is a simple image to run a cron scheduler as a docker image. 


## Structure

```

<root>
    /bin                    # /bin is added to the $PATH during build
       <your_node_scripts>  # your scripts goes here
    cronbox_schedule        # crontab file used inside the image
    .env                    # environment variables used in scripts with `dotenv`

```

## Usage

### Add new scripts
Add scripts inside `bin` folder. The script should be self-executable. Remove any extension and add a shebang header with executable path (ex: `#!/usr/bin/env node` for node scripts).

Remember to change exec permission with `chmod +x bin/my_awesome_script`.



### Schedule your script in crontab

Reference your script inside `cronbox_schedule` file with `crontab` format. 

**Example:** 
```crontab
0 0/2 * * *  my_awesome_script   # run my_awesome_script every 2 hours
```

*NOTE:* If you are human and can't read/remember crontab format, use the wonderful [Crontab Guru](https://crontab.guru/)


