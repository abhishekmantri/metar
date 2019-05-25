# MetarInfo

## Installation

* Install ruby and rails (rails must be installed in project folder i.e. Anaek directory)
https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rvm-on-ubuntu-16-04
* Ruby and rails version must be same as mentioned in Gemfile(if installed version is different then update in Gemfile)

* Use bundler to install the gems required

```bash
bundle install
```

* Start redis server
```bash
redis-server
```

* Start rails server
```bash
rails server
```

* Visit your local server shown in starting rails server and run APIs.

## Assumption

* Response from the METAR link must be in same format as mentioned in PDF
* As the link was redirecting to another link that is taken care of.