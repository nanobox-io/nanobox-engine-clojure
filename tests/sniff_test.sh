echo running tests for clojure
UUID=$(cat /proc/sys/kernel/random/uuid)

pass "Unable to start the $VERSION container" docker run --privileged=true -d --name $UUID nanobox/build-clojure sleep 365d

defer docker kill $UUID

pass "Unable to create code folder" docker exec $UUID mkdir -p /opt/code

fail "Detected something when there shouldn't be anything" docker exec $UUID bash -c "cd /opt/engines/clojure/bin; ./sniff /opt/code"

pass "unable to remove code folder" docker exec $UUID rm -rf /opt/code

pass "Failed to copy test project" docker exec $UUID cp -r /opt/tests/sample-clojure /opt/code

pass "Failed to detect" docker exec $UUID bash -c "cd /opt/engines/clojure/bin; ./sniff /opt/code"