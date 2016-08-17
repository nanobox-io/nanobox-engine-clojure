# Clojure

This is a Clojure engine used to launch Clojure apps on [Nanobox](http://nanobox.io).

## Usage
To use the Clojure engine, specify `clojure` as your `engine` in your boxfile.yml.

```yaml
code.build:
  engine: clojure
```

## Build Process
When [running a build](https://docs.nanboox.io/cli/build/), this engine compiles code by doing the following:

- `lein uberjar`
- `bin/build`

*Custom build scripts should be included in bin/build*

## Basic Configuration Options

This engine exposes configuration options through the [boxfile.yml](http://docs.nanobox.io/app-config/boxfile/), a yaml config file used to provision and configure your app's infrastructure when using Nanobox.

#### Overview of Basic Boxfile Configuration Options
```yaml
code.build:
  config:
    # Java Settings
    java_runtime: oraclejdk8

    # Node.js Settings
    nodejs_runtime: nodejs-4.4
```

##### Quick Links
[Java Settings](#java-settings)  
[Node.js Settings](#nodejs-settings)

---

### Java Settings
The following setting allows you to define your Java runtime environment.

---

#### java_runtime
Specifies which Java runtime and version to use. The following runtimes are available:

- openjdk7
- openjdk8
- oraclejdk8 *(default)*
- sun-jdk6
- sun-jdk7
- sun-jdk8

```yaml
code.build:
  config:
    java_runtime: sun-jdk8
```

---

### Node.js Settings
Many applications utilize Javascript tools in some way. This engine allows you to specify which Node.js runtime you'd like to use.

---

#### nodejs_runtime
Specifies which Node.js runtime and version to use. You can view the available Node.js runtimes in the [Node.js engine documentation](https://github.com/nanobox-io/nanobox-engine-nodejs#runtime).

```yaml
code.build:
  config:
    nodejs_runtime: nodejs-4.4
```

---

## Help & Support
This is a Clojure engine provided by [Nanobox](http://nanobox.io). If you need help with this engine, you can reach out to us in the [#nanobox IRC channel](http://webchat.freenode.net/?channels=nanobox). If you are running into an issue with the engine, feel free to [create a new issue on this project](https://github.com/nanobox-io/nanobox-engine-clojure/issues/new).
