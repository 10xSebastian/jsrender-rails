# jsrender-rails

This gem adds jsrender (next generation of jQuery Templates) and a corresponding Sprockets engine to the asset pipeline for Rails >= 3.1 applications.

## Installation

Add it to your Gemfile and run `bundle` or run `gem install jsrender-rails`.

## Usage

jsrender tempaltes will be recognized by Sprockets with the `.tmpl` extension. Place them anywhere in the Sprockets load path.

```html
<!-- app/assets/javascripts/views/user.tmpl -->
<div class="user">{{>name}}</div>
```

In your JavaScript manifest file, require jsrender followed by your folder containing all your templates/views. The templates are compiled and named with their Sprockets logical path:

```javascript
<!-- app/assets/javascripts/application.js -->
//= require jsrender
//= require_tree ./views

$(body).append($.render["views/user"]({name:"Sebastian Pape"}));
```

## Configuration

If the path to all of your views/templates have a common prefix that you prefer is not included in the template's name, you can set this option in `config/application.rb`:

```ruby
config.jsrender.prefix = "views"
```

That would change the previous example to this:

```javascript
$(body).append($.render["user"]({name:"Sebastian Pape"}));
```

The prefix can also be a regular expression. For example, to use only the name of the file for the template name, regardless of directory structure:

```ruby
config.jsrender.prefix = %r{([^/]*/)*}
```

## Compatible with jQuery Templates?

For sure NOT!

## HAML

If you like to use haml in your jsrender templates I highly recommend [haml_assets](https://github.com/infbio/haml_assets).

## Acknowledgements

jsrender was created by [Boris Moore](https://github.com/BorisMoore).

The idea to easily adding jQuery templates to the Rails Asset-Pipeline comes from [jimmycuadra/jquery-tmpl-rails](https://github.com/jimmycuadra/jquery-tmpl-rails) and was adopted here to work with jsrender.

The Sprockets engine was originally derived from the [sprockets-jquery-tmpl](https://github.com/rdy/sprockets-jquery-tmpl) gem. If you want a similar mechanism for use outside of Rails, take a look at this project.
