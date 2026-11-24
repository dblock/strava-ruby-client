# Releasing Strava-Ruby-Client

There're no hard rules about when to release strava-ruby-client. Release bug fixes frequently, features not so frequently and breaking API changes rarely.

Releases use [ruby-gem-release](https://github.com/dblock/ruby-gem-release) 0.9.0 through a manually dispatched [Release workflow](.github/workflows/release.yml). Keep the `ruby-gem-release` version in [Gemfile](Gemfile) and the reusable workflow pinned to the same release. The workflow publishes with RubyGems Trusted Publishing, so no RubyGems API key or one-time password is needed. It only runs from `master` in `dblock/strava-ruby-client`. The local `rake release`, `rake release:rubygem_push` and `rake release:source_control_push` tasks are disabled.

### One-Time Setup

Before the first automated release, a maintainer must:

1. Create the GitHub environment `release` and restrict its deployment branches to `master`, optionally with required reviewers.
2. Add a GitHub Actions trusted publisher at [strava-ruby-client's trusted publishers](https://rubygems.org/gems/strava-ruby-client/trusted_publishers) with repository owner `dblock`, repository `strava-ruby-client`, workflow filename `release.yml`, environment `release`, and workflow repository owner `dblock` and name `ruby-gem-release`.
3. Allow GitHub Actions to push release commits and `v*` tags to `master`.

Verify the setup without releasing.

```
gh workflow run release.yml --repo dblock/strava-ruby-client --ref master -f dry-run=true
```

See [ruby-gem-release's setup guidance](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/RELEASING.md#one-time-setup) for details.

### Prepare

Start with a clean, up-to-date `master` and check that the last [CI build](https://github.com/dblock/strava-ruby-client/actions/workflows/test.yml) succeeded for all supported platforms.

Check that `Strava::VERSION` in [lib/strava/version.rb](lib/strava/version.rb) matches the `### x.y.z (Next)` heading in [CHANGELOG.md](CHANGELOG.md). Increment the patch version for bug fixes, the minor version for features, and the major version for breaking changes, and describe breaking changes in [UPGRADING.md](UPGRADING.md). Keep `(Next)` and `* Your contribution here.`; the workflow dates the release and removes the placeholder.

Release automation requires MRI Ruby 3.3 or newer.

```
bundle install
bundle exec rake
```

### Release

Dispatch the checked-in version. This is a real release, not a dry run.

```
gh workflow run release.yml --repo dblock/strava-ruby-client --ref master
```

To release a different version, pass `-f version=x.y.z`.

The workflow dates the CHANGELOG section, runs tests and RuboCop, builds and publishes the gem, pushes the release commit and `v` tag, and creates a [GitHub release](https://github.com/dblock/strava-ruby-client/releases) with the release notes and gem. It then increments the patch version, adds a new `(Next)` section to CHANGELOG.md, and pushes to `master`. Don't merge into `master` while it runs.

Afterwards, verify the gem on [RubyGems](https://rubygems.org/gems/strava-ruby-client), the tag, the GitHub release, and the next development commit on `master`.

If a release fails partway, inspect what was published before retrying, never move tags, and see [recovery artifacts](https://github.com/dblock/ruby-gem-release/blob/v0.9.0/docs/actions/release.md#recovery-artifacts).
