# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_boxfile() {
  nos_template \
    "boxfile.mustache" \
    "-" \
    "$(boxfile_payload)"
}

boxfile_payload() {
    cat <<-END
END
}

runtime() {
  echo "$(java_condensed_runtime)-clojure"
}

install_runtime() {
  nos_install "$(runtime)"
}

install_leiningen() {
  nos_install "leiningen"
}

lein_uberjar() {
  [[ -f $(code_dir)/bin/build ]] && return
  [[ "$(grep -c :uberjar-name $(code_dir)/project.clj)" -ge 1 ]] && (cd $(code_dir); run_subprocess "lein uberjar" "lein uberjar")
}

custom_build_script() {
  [[ -f $(code_dir)/bin/build ]] && (cd $(code_dir); run_subprocess "build" "bin/build")
}