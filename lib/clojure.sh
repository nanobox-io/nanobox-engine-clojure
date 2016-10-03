# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

java_runtime() {
  echo $(nos_validate "$(nos_payload 'config_java_runtime')" "string" "oracle-jdk8")
}

java_condensed_runtime() {
  runtime="$(java_runtime)"
  echo ${runtime//[.-]/}
}

clojure_package() {
  echo "$(java_condensed_runtime)-clojure"
}

leiningen_package() {
  echo "$(java_condensed_runtime)-leiningen"
}

install_runtime() {
  pkgs=($(java_runtime) $(clojure_package) $(leiningen_package))

  nos_install ${pkgs[@]}
}

# Uninstall build dependencies
uninstall_build_packages() {
  # currently ruby doesn't install any build-only deps... I think
  pkgs=()

  # if pkgs isn't empty, let's uninstall what we don't need
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    nos_uninstall ${pkgs[@]}
  fi
}

lein_uberjar() {
  [[ -f $(nos_code_dir)/bin/build ]] && return
  [[ "$(grep -c :uberjar-name $(nos_code_dir)/project.clj)" -ge 1 ]] && (cd $(nos_code_dir); nos_run_process "lein uberjar" "lein uberjar")
}

lein_deps() {
  [[ -f $(nos_code_dir)/bin/build ]] && return
  (cd $(nos_code_dir); nos_run_process "lein deps" "lein deps")
}

custom_build_script() {
  [[ -f $(nos_code_dir)/bin/build ]] && (cd $(nos_code_dir); nos_run_process "build" "bin/build")
}

# Copy the compiled jars into the app directory to run live
publish_release() {
	if [[ -d $(nos_code_dir)/target/uberjar ]]; then
	  nos_print_bullet "Moving compiled jars into app directory..."
	  rsync -a $(nos_code_dir)/target/uberjar/ $(nos_app_dir)
	else
	  nos_print_bullet "Moving build into live code directory..."
	  rsync -a $(nos_code_dir)/ $(nos_app_dir)
	fi
}

lein_deps_dir() {
  [[ ! -f $(nos_code_dir)/.lein ]] && nos_run_process "make lein dir" "mkdir -p $(nos_code_dir)/.lein"
  [[ ! -s ${HOME}/.lein ]] && nos_run_process "link lein dir" "ln -s $(nos_code_dir)/.lein ${HOME}/.lein"
  [[ ! -f $(nos_code_dir)/.m2 ]] && nos_run_process "make m2 dir" "mkdir -p $(nos_code_dir)/.m2"
  [[ ! -s ${HOME}/.m2 ]] && nos_run_process "link m2 dir" "ln -s $(nos_code_dir)/.m2 ${HOME}/.m2"
}

create_profile_links() {
  mkdir -p $(nos_data_dir)/etc/profile.d/
  nos_template \
    "profile.d/clojure.sh" \
    "$(nos_data_dir)/etc/profile.d/clojure.sh" \
    "$(links_payload)"
}

links_payload() {
  cat <<-END
{
  "code_dir": "$(nos_code_dir)"
}
END
}