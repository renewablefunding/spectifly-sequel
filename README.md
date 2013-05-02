# Spectifly Sequel Add-on

An add-on to Spectifly, which uses entity definitions based on YAML, to
create Sequel migrations and model files

## Installation

Add this line to your application's Gemfile:

    gem 'spectifly-sequel'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spectifly-sequel

## Usage

The Spectifly markup language is a subset of YAML. Only one root node is allowed
per file (since a single `.entity` file represents a single business entity),
and there are other restrictions, as well as additional features, which we'll
discuss here.

Given a Spectifly entity defintion `lib/entities/widget.entity`:

```YAML
Widget:
  Description: A widget produced by WidgetCo
  Fields:
    Name*:
      Description: Display name of widget

    Created At:
      Description: When the widget was built
      Type: DateTime

    Awesome?:
      Description: Whether or not the widget is awesome
```
When `rake spectifly:sequel:generate['widget']` is run, the following
migration `db/migrate/001_create_widgets.rb` will be created.
```ruby
Sequel.migration do
  change do
    create_table(:widgets) do
      primary_key :id
      String :name, :null => false
      DateTime :created_at
      Boolean :awesome
    end
  end
end
```

## Configuration

Spectifly Sequel makes a few assumptions about where you put your entity
definitions and migrations.  By default, migrations are put into
`db/migrate` and entity definitions are read from `lib/entities`.  Both
these locations can be configured by adding settings to your
`~/.spectifly-sequel` file.  For example:

```ruby
# To change entity definitions paths
--entity-def-path RELATIVE_PATH_TO_ENTITY_DEFINITIONS

# To change where migations are added
--migration-path RELATIVE_PATH_TO_SEQUEL_MIGRATIONS
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
