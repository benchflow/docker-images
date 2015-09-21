#!/bin/bash
set -e

# Exit if the required ENVCONSUL_CONSUL it is not defined
if [ -z "$ENVCONSUL_CONSUL" ]; then
    echo "Need to set ENVCONSUL_CONSUL"
    exit 1
fi  

# Configure envconsul using environment variables

# Handle the once flag (the empty string keeps the default one)
once=""
if [ "$ENVCONSUL_ONCE" ]; then
    var="ENVCONSUL_ONCE"
	val="${!var}"
	if [ "$val" = true ] ; then
		once="-once"
	fi
fi  

for hcl in \
		prefixes \
		sanitize \
		upcase \
; do
		var="ENVCONSUL_${hcl^^}"
		val="${!var}"
		
		if [ "$val" ]; then
			sed -ri 's/^(# )?('"$hcl"' =).*/\2 '"$val"'/' "$ENVCONSUL_CONFIG/envconsul-config.hcl"
		fi
done

for hcl in \
		max_stale \
		token \
		wait \
		retry \
		log_level \
; do
		var="ENVCONSUL_${hcl^^}"
		val="${!var}"
		
		if [ "$val" ]; then
			sed -ri 's/^(# )?('"$hcl"' =).*/\2 '\""$val"\"'/' "$ENVCONSUL_CONFIG/envconsul-config.hcl"
		fi
done

# -prefix= is present because expected by envconsul. It is overridden by the prefixes specified in $ENVCONSUL_CONFIG/envconsul-config.hcl
exec /usr/bin/envconsul -consul=${ENVCONSUL_CONSUL} -config=$ENVCONSUL_CONFIG/envconsul-config.hcl -prefix= $once "$@"