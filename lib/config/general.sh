# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

create_boxfile() {
  template \
    "boxfile.mustache" \
    "-" \
    "$(boxfile_payload)"
}

boxfile_payload() {
    cat <<-END
{
  "has_bower": $(has_bower),
  "rackup": $(is_webserver rack),
  "unicorn": $(is_webserver unicorn),
  "thin": $(is_webserver thin),
  "puma": $(is_webserver puma),
  "is_rackup": $(is_rackup),
  "can_run": $(can_run),
  "app_rb": $(app_rb),
  "live_dir": "$(live_dir)",
  "etc_dir": "$(etc_dir)",
  "deploy_dir": "$(deploy_dir)"
}
END
}

app_name() {
  # payload app
  echo "$(payload app)"
}

live_dir() {
  # payload live_dir
  echo $(payload "live_dir")
}

deploy_dir() {
  # payload deploy_dir
  echo $(payload "deploy_dir")
}

etc_dir() {
  echo $(payload "etc_dir")
}

code_dir() {
  echo $(payload "code_dir")
}

runtime() {
  echo $(validate "$(payload 'boxfile_runtime')" "string" "openjdk8")
}

install_runtime() {
  install "$(runtime)"
}

install_leiningen() {
  install "leiningen"
}

js_runtime() {
  echo $(validate "$(payload "boxfile_js_runtime")" "string" "nodejs-0.12")
}

install_js_runtime() {
  install "$(js_runtime)"
}

lein_uberjar() {
  [[ -f $(code_dir)/bin/build ]] && return
  [[ "$(grep -c :uberjar-name $(code_dir)/project.clj)" -ge 1 ]] && (cd $(code_dir); run_subprocess "lein uberjar" "lein uberjar")
}

custom_build_script() {
  [[ -f $(code_dir)/bin/build ]] && (cd $(code_dir); run_subprocess "build" "bin/build")
}