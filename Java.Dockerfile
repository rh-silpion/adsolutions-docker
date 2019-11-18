#
# --- Globals ---
#
ARG IMAGE_VERSION
ARG WORKDIR=/app



#
# --- Base ---
#
FROM ${IMAGE_VERSION} AS base

# Load global args
ARG WORKDIR

# Add the rsync command, this is needed to synchronize the node_modules folder
RUN apk add --no-cache rsync

# Copy target sync
COPY docker-scripts/syncTarget.sh /bin/syncTarget

# Set target sync executable rights
RUN chmod u+x /bin/syncTarget

# Copy shell aliases
COPY docker-scripts/aliases.sh /etc/profile.d/aliases.sh

# Force Alpine Ash shell to load everytime the aliases, not only as login shell "sh -l"
ENV ENV="/etc/profile"

# Set correct TimeZone
ENV TZ Europe/Berlin

# Set the working directory
WORKDIR $WORKDIR

# Define the start command
CMD ["sh", "-c", "./mvnw -P-webpack"]



#
# --- Gateway ---
#
FROM base AS gateway

# Load global args
ARG NODE_VERSION
ARG YARN_VERSION

# Install Node & Yarn
ENV NODE_VERSION $NODE_VERSION
ENV YARN_VERSION $YARN_VERSION

RUN addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && apk add --no-cache \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        curl \
    && ARCH= && alpineArch="$(arch)" \
      && case "${alpineArch##*-}" in \
        x86_64) \
          ARCH='x64' \
          ;; \
        *) ;; \
      esac; \
    set -eu; \
    curl -fsSLO --compressed "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz"; \
      tar -xJf "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
      && ln -s /usr/local/bin/node /usr/local/bin/nodejs; \
    rm -f "node-v$NODE_VERSION-linux-$ARCH-musl.tar.xz" \
    && apk del .build-deps \
    # Yarn
    && apk add --no-cache --virtual .build-deps-yarn curl tar \
       && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
       && mkdir -p /opt \
       && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
       && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
       && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
       && rm yarn-v$YARN_VERSION.tar.gz \
       && apk del .build-deps-yarn

# Copy node_modules sync
COPY docker-scripts/syncNodeModules.sh /bin/syncNodeModules

# Set node_modules sync executable rights
RUN chmod u+x /bin/syncNodeModules
