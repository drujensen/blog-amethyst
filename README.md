# Example Blog using Crystal and Amethyst

A blog that is written in Crystal using Amethyst.  This is a test to see how
close to a RoR's app I can get using the current libs, frameworks, etc.

I tried to replicate the same file structure as a Rails App.  There are some
minor differences but it should be fairly simple to see how I did this.

One of the biggest differences is that there is no ORM as of yet. I created a
simple DAO layer for the model to use.  This should be pretty flexible and
allow for most scenarios needed.

# Installation

This project requires Crystal 0.7.5 and a MySQL server installed.

```
git clone git@github.com:drujensen/crystal-blog.git
```

Next setup the database by creating a "blog_development" schema.  Connect to
the database and run the /db/migrate/* scripts manually. Update the
config/database.yml to match your settings.

Install dependencies using `crystal deps`

Compile the code using `crystal build blog.cr`

# Usage

Run the blog using `crystal run blog.cr` and hitting http://localhost:8080
from your browser.

# Development

There are several features that are still needed.  I am trying to keep this very
simple and RoR'ish as much as possible.  Keep that in mind when contributing.

# Roadmap

- Add Specs
- Support PUT and DELETE Restful methods
- Add Comments with has_many like syntax
- Add Endless Paging
- Add Tagging
- Add DB Migration Tools
- Add Capistrano
- Add Grunt/Gulp for Asset Compilation



