echo running tests for clojure
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "Unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-clojure sleep 365d

defer docker kill $UUID

pass "Failed to run cleanup script" docker exec $UUID bash -c "cd /opt/engines/clojure/bin; ./cleanup '$(payload default-cleanup)'"