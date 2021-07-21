# Sitemap

## Runtime installation
*Please note that this assumes a Linux/Unix/OSX system*

1. Install a ruby version manager if you don't have one already (I prefer [rbenv](https://github.com/rbenv/rbenv).
2. Install the verison of ruby our project is using (3.0.1, or whatever is specified at `<project-root>/.ruby-version`. This can be easily achieved using [ruby-build](https://github.com/rbenv/ruby-build#readme)
3. Install the dependencies using the `bundle` command

### copy/paste for mac users
*(this assumes you are in the project directory)*
```
brew install rbenv

# (please follow the instructions printed after rbenv init)
rbenv init
# (please follow the instructions printed after rbenv init)

brew install ruby-build

rbenv install # installs our version of ruby
bundle # install our dependencies
```

# Running this program
```
ruby sitemap.rb [optional URL] [optional depth to search]
```

The sitemap will be output to the relative path `./sitemap.json`
