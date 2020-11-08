

# Dev Ops CI Challenge

A development team would like help adding CI / CD to their project.  They have a simple REST application that serves 
data from a PostgreSQL database.

For the first phase, they would like a simple CI script that runs their unit tests.  They have already set their project
up in this repository so would prefer to use that.  Everything else is up to you.

They've also requested a diagram of the infrastructure you feel would best serve the application.  They are open to other clear ways to represent it.

Finally, they would like code to provision the infrastructure in the tool of your choice.  They've heard
great things about `terraform` but are eager for other opportunities that you feel may be better.


## Deliverables:

1. A configuration file (`.gitlab-ci.yml`) that controls GitLab CI
1. A Merge Request with a successful GitLab CI pipeline running tests
1. A diagram of your planned infrastructure to deploy the application
1. A sub-directory with your infrastructure, defined as code.

**NOTE**: The CI in this task can be completed within GitLab CI.  You do not need to stand up any external 
infrastructure.  You will get an invite to GitLab.com which includes 2,000 free hours of CI runtime.

**Optional** Goals for the GitLab CI file:
1. Code Coverage in merge requests
1. JUnit Summaries in the merge requests
1. A dockerfile that can be used to run their software in container orchestration

# Background on the Program

## Prerequisites

Java is required to be installed.  We recommend Java 11 and use Corretto locally:
https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/downloads-list.html

## Gradle - build structure

Gradle can be run with `./gradlew <command>` (or `gradlew.bat` on windows), it will download the required dependencies 
for this project.

You can run the program with `./gradlew bootRun`.  This requires the database to exist as described in the Postgres 
subsection.

Gradle commands can be chained and sometimes have dependencies.  To see a list of gradle commands run `gradlew tasks`.
The important tasks here are:
1. `flywayClean` - cleans the database so it can be re-initialized
1. `flywayMigrate` - runs the database setup scripts located in `src/resources/db/migration`
1. `build` - builds the application
1. `test` - runs the applications unit tests
1. `clean` - cleans the build cache

For example, to do a fresh run:
`gradlew flywayMigrate build test`

Will initialize the database,  build the application and run its tests.

## Postgres

This project should be compatible with any SQL database, but has been tested with PostgreSQL.  An off the shelf docker 
image can be found here:

[Postgres Docker Page](https://hub.docker.com/_/postgres)

This has been tested with PostgreSQL **12.1**, which a tag currently exists for.

```bash
docker run --name some-postgres -p 5432:5432 postgres:12.1
```

**Note**: There are two files controlling access to the postgres database, both allow overriding the host name by defining 
`POSTGRES_HOST`.  The two files are:
1. src/main/resources/application.properties
1. build.gradle (flyway block)

### Flyway

Flyway is responsible for initializing the database schema.  It expects the user `postgres` to exist without a password.

The database **structure** can be initialized with `./gradlew flywayMigrate`.  It requires an existing database on port
`5432`.  If needed, `flywayClean` will clear the current schema so `flywayMigrate` will re-create it when run.

## Rest

A single REST endpoint is available at `http://localhost:8080/parts`.  The unit tests are configured to test against a 
random port.

# Resources

GitLab CI documentation is here:
1. https://docs.gitlab.com/ee/ci/
1. https://docs.gitlab.com/ee/ci/yaml/

Postgres docker image is here:
1. https://hub.docker.com/_/postgres


