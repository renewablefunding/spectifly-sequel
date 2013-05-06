# Spectifly Sequel Add-on

An add-on to Spectifly, which uses entity definitions based on YAML, to
create Sequel migrations and model files

## Caveat

This gem is not currently fit to be used - Migration text can be
generated, but it doesn't get written to anywhere.

Once that gets finished, more warnings:

This is very much a work in progress and any migrations generated from
the gem should be carefully scrutinized for correctness prior to
applying them to your database.  Right now, the gem's output is only
tested with Postgres and only creates new tables but does not update
schema that already exists (though ideally, that would be a future
feature).

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

Spectifly Sequel does not make any assumptions about where you put your
entity definitions or migrations.  In order for the gem to run
correctly, you'll need to specifly the path to a YAML file or set the
config directly via a hash.

```ruby
# to set via YAML file
Spectifly::Sequel.configure_with PATH_TO_CONFIG_YAML

# to set via hash
Spectifly::Sequel.configure {
  'migration_path' => PATH_TO_MIGRATION_DIRECTORY
  'entity_definition_path' => PATH_TO_ENTITY_DEFINITION_DIRECTORY
}
```

The YAML configuration file should look something like this:
```yaml
Sequel:
  Spectifly:
    migration_path: PATH_TO_MIGRATION_DIRECTORY
    entity_definition_path: PATH_TO_ENTITY_DEFINITION_DIRECTORY
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
