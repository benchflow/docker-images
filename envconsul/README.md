# What is envconsul? #

envconsul provides a convenient way to populate values from Consul into an child process environment using the envconsul daemon.

The daemon envconsul allows applications to be configured with environmental variables, without having knowledge about the existence of Consul. This makes it especially easy to configure applications throughout all your environments: development, testing, production, etc.

More information on the official envconsul documentation: https://github.com/hashicorp/envconsul

# Released images #

There are different versions of envconsul Docker Images, corresponding to the different folders of the repository. Currently available images are listed on the [Docker Hub registry](https://registry.hub.docker.com/u/benchflow/envconsul/tags/manage/). The Docker Image tag should be enough to identify the Image version you are interested in.

## Supported Tags/Releases

- `latest`, `v0.5.0`, `latest_ubuntu`, `v0.5.0_ubuntu` ([Dockerfile](https://github.com/benchflow/docker-images/blob/master/envconsul/ubuntu/14.04/Dockerfile))
- `latest_serverjre-7`, `v0.5.0_serverjre-7` ([Dockerfile](https://github.com/benchflow/docker-images/blob/master/envconsul/oracle-java/serverjre-7/Dockerfile))

# How this image works? #

The image specifies as entrypoint the ``docker-entrypoint.sh`` file. This file populate the *consul* configuration file with the provided environment variables, then starts *envconsul* as well as the provided ``CMD`` that runs your application.

The image accepts the following environment variables mapped to the specified *consul* configuration options. The image also defines default values for all the configurations (**Default**) options but *consul* that needs to be always defined through an environment variable.

## Options
| Option      | Environment Variable  | Description                                                                                                                                                                                                                                           |
|-------------|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `consul`*   | `ENVCONSUL_CONSUL`    | The location of the Consul instance to query (may be an IP address or FQDN) with port.                                                                                                                                             |
| `prefix`    | `ENVCONSUL_PREFIXES`^    | A prefix to watch in Consul. This may be specified multiple times if passed as option. It is possible to pass an array of prefixes by using the ENV variable, e.g.: ENVCONSUL_PREFIXES=\\[\"global\/time\"\\]". <br>**Default**: ["/"]                                                                                                                                                                               |
| `once` | `ENVCONSUL_ONCE` | Run envconsul once and exit (as opposed to the default behavior of daemon). <br>**Default**: disabled (false)                                                                                             |
| `max-stale` | `ENVCONSUL_MAX_STALE` | The maximum staleness of a query. If specified, Consul will distribute work among all servers instead of just the leader. The default value is 0 (none). <br>**Default**: "10m"                                                                                              |
| `token`     | `ENVCONSUL_TOKEN`     | The [Consul API token](http://www.consul.io/docs/internals/acl.html). There is no default value.                                                                                                                                                                                       |
| `wait`      | `ENVCONSUL_WAIT`      | The `minimum(:maximum)` to wait before rendering a new template to disk and triggering a command, separated by a colon (`:`). If the optional maximum value is omitted, it is assumed to be 4x the required minimum value. There is no official default value. <br>**Default**: "10s:40s" |
| `retry`     | `ENVCONSUL_RETRY`     | The amount of time to wait if Consul returns an error when communicating with the API. The official default value is 5 seconds. <br>**Default**: "10s"                                                                                                                                |
| `sanitize`  | `ENVCONSUL_SANITIZE`  | Replace invalid characters in keys to underscores. <br>**Default**: true                                                                                                                                                                                                     |
| `upcase`    | `ENVCONSUL_UPCASE`    | Convert all environment variable keys to uppercase. <br>**Default**: true                                                                                                                                                                                                    |
| `log-level` | `ENVCONSUL_LOG_LEVEL` | The log level for output. This applies to the stdout/stderr logging as well as syslog logging (if enabled). Valid values are "debug", "info", "warn", and "err". The default value is "warn". <br>**Default**: "warn"                                                         |

\* = Required parameter

\^ = The string must be escaped for the ubuntu shell special characters

# How do you use this image? #

This is a base image builded ``FROM ubuntu:15.10``. You can use this image to build your own image to run your application, after populating the environment with variables from specified *consul* prefixes. *envconsul* keeps the environment variables updated and if a change is detected, by default *envconsul* restarts the application (you can use the once option to change this behaviour). 

**Complete example - shows the retieved ENV variables:**
```bash
$ docker run -e "ENVCONSUL_CONSUL=demo.consul.io:80" \
             -e "ENVCONSUL_PREFIXES=\[\"global\/time\"\]" \
             -e "ENVCONSUL_MAX_STALE=20m" \
             -e "ENVCONSUL_TOKEN=" \
             -e "ENVCONSUL_WAIT=10s:40s" \
             -e "ENVCONSUL_RETRY=20s" \
             -e "ENVCONSUL_SANITIZE=true" \
             -e "ENVCONSUL_UPCASE=true" \
             -e "ENVCONSUL_LOG_LEVEL=err" \
             -e "ENVCONSUL_ONCE=true" \
             --rm \
             benchflow/envconsul:latest env
```

**Complete example - the same as the previous one but using additional CMDs instead of ENV variables:**

You can also directly issue parameters to envconsul additional ``CMD``s to be specified before the command and options running your application. The ``ENVCONSUL_CONSUL`` environment variable must be always specified.

```bash
$ docker run -e "ENVCONSUL_CONSUL=demo.consul.io:80" \
             --rm \
             benchflow/envconsul:latest \ 
			 -prefix=global/time \
			 -max-stale=20m \
			 -token= \
			 -wait=10s:40s \
			 -retry=20s \
			 -sanitize=true \
			 -upcase=true \
			 -log-level=err \
			 -once \
             env
```
