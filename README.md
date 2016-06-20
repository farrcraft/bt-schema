# Overview

The schema tool is used to create the initial database tables and apply subsequent table migrations.


# Usage

```sh
# Create user & db
$ bt-schema create --config /etc/brewtheory/schema.json
```

```sh
# Install initial tables & data
$ bt-schema install --config /etc/brewtheory/schema.json
```

```sh
# Apply updates
$ bt-schema update --config /etc/brewtheory/schema.json
```

# Design

The schema directory contains the base table definitions.  Each table is in its own named .sql file.

The config directory contains a JSON-formatted tables.json file.  This file contains a list of all tables in the database. Each table entry includes the name of the table, optional flag indicating an important system table that should be loaded first, a list of any dependent tables, and a version number.  If the version number is omitted, it is assumed to be 0.  Version 0 is the base schema.

The install command expects an empty database. It loads and runs all of the table files in the schema directory, starting with the tables flagged as system tables, and then the rest of the tables, making sure dependencies are created first.

The update command queries the **schema_version** system table and loads the tables.json file. The list of tables is parsed from the schema.json file. For any table where the schema.json entry has a smaller number than what is in the schema_version table, the schema file from the matching versions directory is run.  If there is no entry for the table in the schema_version table, then the base schema is loaded.

E.g., for the table **foobars** which has two migrations applied to it:

schema/foobars.sql
versions/1/foobars.sql
versions/2/foobars.sql

The database as a whole has no concept of a version number.  Instead, each table has its own version number.  Only when a table has a migration applied to it does its version number get incremented.
