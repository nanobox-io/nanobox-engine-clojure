# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

clojure_create_boxfile() {
  nos_template \
    "boxfile.mustache" \
    "-" \
    "$(clojure_boxfile_payload)"
}

clojure_boxfile_payload() {
    cat <<-END
{
  "has_bower": $(nodejs_has_bower)
}
END
}

clojure_runtime() {
  
}

clojure_install_runtime() {
  nos_install "$(clojure_runtime)"
}

clojure_install_leiningen() {
  nos_install "leiningen"
}

clojure_lein_uberjar() {
  [[ -f $(code_dir)/bin/build ]] && return
  [[ "$(grep -c :uberjar-name $(code_dir)/project.clj)" -ge 1 ]] && (cd $(code_dir); run_subprocess "lein uberjar" "lein uberjar")
}

clojure_custom_build_script() {
  [[ -f $(code_dir)/bin/build ]] && (cd $(code_dir); run_subprocess "build" "bin/build")
}