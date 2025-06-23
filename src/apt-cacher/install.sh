#!/bin/sh
set -e

echo "Activating feature 'apt-cacher'"

# GREETING=${GREETING:-undefined}
HOSTNAME=${HOSTNAME:-localhost}
echo "The provided hostname is: $HOSTNAME"

# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

# cat > /usr/local/bin/hello \
# << EOF
# #!/bin/sh
# RED='\033[0;91m'
# NC='\033[0m' # No Color
# echo "\${RED}${GREETING}, \$(whoami)!\${NC}"
# EOF

cat > /etc/apt/apt.conf.d/01proxy \
<< EOF
Acquire::HTTP::Proxy "http://172.17.0.1:3142";
Acquire::HTTPS::Proxy "false";
EOF

apt-get update

# chmod +x /usr/local/bin/hello