# -*- mode: bash; tab-width: 2; -*-
# vim: ts=2 sw=2 ft=bash noet

# source nodejs
. ${engine_lib_dir}/nodejs.sh

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

  if [[ "$(is_nodejs_required)" = "true" ]]; then
    pkgs+=("$(nodejs_dependencies)")
  fi

  nos_install ${pkgs[@]}
}

# Uninstall build dependencies
uninstall_build_packages() {
  # currently ruby doesn't install any build-only deps... I think
  pkgs=()

  # if nodejs is required, let's fetch any node build deps
  if [[ "$(is_nodejs_required)" = "true" ]]; then
    pkgs+=("$(nodejs_build_dependencies)")
  fi

  # if pkgs isn't empty, let's uninstall what we don't need
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    nos_uninstall ${pkgs[@]}
  fi
}

lein_uberjar() {
  [[ -f $(nos_code_dir)/bin/build ]] && return
  [[ "$(grep -c :uberjar-name $(nos_code_dir)/project.clj)" -ge 1 ]] && (cd $(nos_code_dir); nos_run_process "lein uberjar" "lein uberjar")
}

lein_install() {
  [[ -f $(nos_code_dir)/bin/build ]] && return
  (cd $(nos_code_dir); nos_run_process "lein install" "lein install")
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