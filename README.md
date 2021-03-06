# Exogenesis

A collection of classes that help you install, update and teardown package managers and other things useful for your dotfiles. It's something like a meta package manager (package manager is the wrong word... still searching for a better one). You can use it to install/update/teardown your dotfiles or to create a single `update` command to update everything on your computer.

It creates a beautiful output if you want it to (see Configuration). For a little [demonstration](http://ascii.io/a/2491) see this asciicast of my `rake install` running on my (already installed :wink:) system.

**Please read the source code of this gem before you use it. I give no guarantee that this will not destroy your computer entirely.**

## How to use it

The current best practice is to create a Rakefile in your dotfile repo that looks something like this:

```ruby
#!/usr/bin/env rake
require "yaml"
require "rubygems"
require "exogenesis"

# Configure your output here (see Configuration)
Output.fancy

# Load the lists of brews you want to install for example
packages = YAML.load_file "packages.yml"

# Create an array of all the initialized package managers
package_managers = [
  Dotfile.new,
  OhMyZSH.new("moonglum"),
  Homebrew.new(packages["brews"]),
  Vundle.new,
  Rvm.new(packages["rubies"])
]

desc "Setup the dotfiles"
task :setup do
  package_managers.each(&:setup)
end

# ...and corresponding Rake tasks for the other methods
```

You can find a list of real-world usage of this gem [here](https://github.com/moonglum/exogenesis/wiki/List-of-Users). There are links to the actual install files there, so you can see how they did it.

## Configuration

You can configure the output of Exogenesis via the `Output` class:

* `Output.activate_centering` centers the output
* `Output.activate_decoration` makes parts of the output colored and bold
* `Output.activate_utf8` uses UTF8 'icons' for certain outputs
* `Output.fancy` activates all options mentioned above at once.

## The Interface of the classes

Every class has the following methods (with the exception of `initialize` they all take no arguments):

* `initialize`: The arguments are arbitrary, please see the individual files for it
* `setup`: Installs the package manager itself
* `install`: Installs all packages (the list has to be provided in the initialize method)
* `update`: Updates the package manager itself and all packages
* `cleanup`: Starts a clean-up process
* `teardown`: Uninstalls all packages and the package manager itself

Not all package managers will need all of the methods. Just do not implement them.

## Supported Managers

* **Dotfile:** Link/Unlink your dotfiles
* **Fonts:** Manage your fonts
* **Homebrew:** Install/Uninstall/Update Homebrew and its packages
* **OhMyZSH:** Install/Uninstall OhMyZSH
* **RVM:** Install/Uninstall/Update RVM and Rubies
* **Vundle:** Install/Uninstall/Update Vundle and its packages

## Contributing

Additions of new classes are more than welcome, even if they are complimentary to the ones already provided. If you want to contribute a new class, please see the interface section and inherit from `AbstractPackageManager`. Please use the Executor singleton for communicating the status with the user and for executing shell scripts.
Your code has to work on Ruby 1.8.7, because the dotfile installers should work on Mac OS without installing a new Ruby version (and Mac OS still ships with 1.8.7)

So far, the following people have contributed to the project:

* Bodo Tasche aka bitboxer
