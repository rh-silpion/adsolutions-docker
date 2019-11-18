#
# --- Globals ---
#
ARG IMAGE_VERSION



FROM ${IMAGE_VERSION} AS stage-local-development

# Add the rsync command, this is needed to synchronize the node_modules folder
RUN apk add --no-cache rsync

# Copy node_modules & target sync
COPY docker-scripts/syncNodeModules.sh /bin/syncNodeModules
COPY docker-scripts/syncTarget.sh /bin/syncTarget

# Set node_modules & target sync executable rights
RUN chmod u+x /bin/syncNodeModules \
    && chmod u+x /bin/syncTarget

# Copy shell aliases
COPY docker-scripts/aliases.sh /etc/profile.d/aliases.sh

# Force Alpine Ash shell to load everytime the aliases, not only as login shell "sh -l"
ENV ENV="/etc/profile"

# Set correct TimeZone
ENV TZ Europe/Berlin

# Set the working directory
WORKDIR /app

# Define the start command - the "& sh" at the end is a workaround to not stop the container if we kill the npm task.
# This will only work with "tty: true" & "stdin_open: true" together.
CMD ["sh", "-c", "yarn install && yarn start & sh"]
