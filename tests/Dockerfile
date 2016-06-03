FROM nanobox/build

# Remove existing engines, we don't want to test those
RUN rm -rf /opt/engines/*

# Create folders for this engine
RUN mkdir -p /opt/engines/clojure/bin && \
    mkdir -p /opt/engines/clojure/lib && \
    mkdir -p /opt/engines/clojure/templates
    mkdir -p /opt/tests/sample-clojure

RUN curl https://codeload.github.com/nanobox-io/nanobox-engine-nodejs/tar.gz/master | \
    tar -xzC /opt/engines/clojure --strip-components 1

RUN curl https://codeload.github.com/nanobox-io/nanobox-engine-java/tar.gz/master | \
    tar -xzC /opt/engines/clojure --strip-components 1

# Add in this engine's files
ADD bin/. /opt/engines/clojure/bin
ADD lib/. /opt/engines/clojure/lib
ADD templates/. /opt/engines/clojure/templates
ADD tests/sample-clojure/src/. /opt/tests/sample-clojure