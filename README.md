# Example Blog using Crystal and Amethyst [![Build
Status](https://travis-ci.org/drujensen/crystal-blog.svg)](https://travis-ci.org/drujensen/crystal-blog)

A blog that is written in Crystal using Amethyst.  This is a test to see how
close to a RoR's app I can get using the current libs, frameworks, etc.

I tried to replicate the same file structure as a Rails App.  There are some
minor differences but it should be fairly simple to see how I did this.

# Installation

This project requires Crystal 0.7.7 and either SQLite or a MySQL database. I
am including both drivers in the dependencies.

``` git clone git@github.com:drujensen/crystal-blog.git ```

Next setup the database.  The default is using SQLite so no setup is involved.
If you decide to use MySQL, update the config/database.yml to match your
settings and change the adapter in the models.

Install dependencies using `crystal deps`

Compile the code using `crystal build blog.cr`

Connect to the database and run `crystal /db/migrate.cr` to drop and create
the databases. 

# Usage

Run the blog using `crystal run blog.cr` and hitting http://localhost:8080
from your browser.

# Development

There are several features that are still needed.  I am trying to keep this
very simple and RoR'ish as much as possible.  Keep that in mind when
contributing.

# Roadmap

- Add Validation and Error Handling
- Add Comments with `has many` like syntax
- Add Capistrano
- Add Grunt/Gulp for Asset Compilation



