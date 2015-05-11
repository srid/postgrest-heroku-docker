FROM heroku/cedar:14

# Install Haskell and Cabal
RUN apt-get update && \
    apt-get -y install haskell-platform wget libncurses5-dev && \
    apt-get clean
RUN cabal update && cabal install cabal-install
ENV PATH /root/.cabal/bin:$PATH

# Using my fork for --db-uri and basic auth support
ENV POSTGREST_REPO "https://github.com/srid/postgrest.git -b heroku"

RUN git clone ${POSTGREST_REPO} /app/postgres
WORKDIR /app/postgres
RUN cabal install

# Startup scripts for heroku
RUN mkdir -p /app/.profile.d
RUN echo "export PATH=\"/app/bin:\$PATH\"" > /app/.profile.d/appbin.sh
RUN echo "cd /app" >> /app/.profile.d/appbin.sh

ENV PORT 3000
EXPOSE 3000

#
# ----------
#

ONBUILD RUN mkdir -p /app/bin && cp /root/.cabal/bin/postgrest /app/bin/
ONBUILD RUN rm -rf /app/postgres
ONBUILD ADD Procfile /app/
ONBUILD WORKDIR /app/
