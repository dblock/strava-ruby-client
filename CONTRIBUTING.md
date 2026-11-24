# Contributing to Strava-Ruby-Client

This project is work of [many contributors](https://github.com/dblock/strava-ruby-client/graphs/contributors).

You're encouraged to submit [pull requests](https://github.com/dblock/strava-ruby-client/pulls), [propose features and discuss issues](https://github.com/dblock/strava-ruby-client/issues).

In the examples below, substitute your Github username for `contributor` in URLs.

### Fork the Project

Fork the [project on Github](https://github.com/dblock/strava-ruby-client) and check out your copy.

```
git clone https://github.com/contributor/strava-ruby-client.git
cd strava-ruby-client
git remote add upstream https://github.com/dblock/strava-ruby-client.git
```

### Bundle Install and Test

Ensure that you can build the project and run tests.

```
bundle install
bundle exec rake
```

Rubocop uses its own `gemfiles/rubocop.gemfile`, kept separate so its pinned version doesn't constrain the main Gemfile's dependency resolution.

```
BUNDLE_GEMFILE=gemfiles/rubocop.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/rubocop.gemfile bundle exec rubocop
```

This gem is tested against multiple `json` and `hashie` gem versions using [Appraisal](https://github.com/thoughtbot/appraisal), defined in `Appraisals`. To run the test suite against a specific dependency version, e.g. to reproduce [#113](https://github.com/dblock/strava-ruby-client/issues/113):

```
BUNDLE_GEMFILE=gemfiles/json_3.gemfile bundle install
BUNDLE_GEMFILE=gemfiles/json_3.gemfile bundle exec rake spec
```

If you add or change a runtime/test dependency in the main `Gemfile`, regenerate the appraisal gemfiles.

```
bundle exec appraisal generate
```

### Run Benchmarks

Benchmark the client end to end, from the HTTP response through JSON parsing and model construction, against responses replayed from the VCR cassettes in `spec/fixtures`. No network access or Strava token is needed.

```
bundle exec rake benchmark
```

Run selected scenarios with `bundle exec ruby benchmark/client.rb activity club_events`. Set `BENCHMARK_SAVE` to a file path to compare results across runs, e.g. before and after a change, and `BENCHMARK_TIME` to change the measurement time in seconds.

## Contribute Code

### Obtain a Strava Token

Recording new VCR cassettes or running `bin/strava-activities.rb` requires a token with access to your activities. Get `STRAVA_CLIENT_ID` and `STRAVA_CLIENT_SECRET` from [My API Application](https://www.strava.com/settings/api), then complete the OAuth workflow in the browser window that opens.

```bash
export STRAVA_CLIENT_ID=...
export STRAVA_CLIENT_SECRET=...

bundle exec ruby bin/strava-oauth-token
```

Set `STRAVA_ACCESS_TOKEN` to the displayed `access_token` and save the `refresh_token`. When the access token expires, get a new one with the refresh token.

```bash
STRAVA_API_REFRESH_TOKEN=... bundle exec ruby bin/strava-refresh-token
```

### Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

### Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build. Add tests to [spec](spec).

We definitely appreciate pull requests that highlight or reproduce a problem, even without a fix.

### Write Code

Implement your feature or bug fix.

Ruby style is enforced with [RuboCop](https://github.com/rubocop/rubocop). Run `BUNDLE_GEMFILE=gemfiles/rubocop.gemfile bundle exec rubocop` and fix any style issues highlighted, auto-correcting them when possible with `-a`.

Make sure that `bundle exec rake` completes without errors.

### Write Documentation

Document any external behavior in the [README](README.md) or the [usage documentation](docs/USAGE.md).

### Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md) under *Next Release*. Don't remove *Your contribution here*.

Make it look like every other line, including a link to the issue being fixed, your name and link to your Github account.

### Commit Changes

Make sure git knows your name and email address:

```
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```
git add ...
git commit
```

### Push

```
git push origin my-feature-branch
```

### Make a Pull Request

Go to https://github.com/contributor/strava-ruby-client and select your feature branch. Click the 'Pull Request' button and fill out the form. Pull requests are usually reviewed within a few days.

### Update CHANGELOG Again

Update the [CHANGELOG](CHANGELOG.md) with the pull request number. A typical entry looks as follows.

```
* [#123](https://github.com/dblock/strava-ruby-client/pull/123): Reticulated splines - [@contributor](https://github.com/contributor).
```

Amend your previous commit and force push the changes.

```
git commit --amend
git push origin my-feature-branch -f
```

### Rebase

If you've been working on a change for a while, rebase with upstream/master.

```
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```

### Check on Your Pull Request

Go back to your pull request after a few minutes and see whether it passed muster with Travis-CI. Everything should look green, otherwise fix issues and amend your commit as described above.

### Be Patient

It's likely that your change will not be merged and that the nitpicky maintainers will ask you to do more, or fix seemingly benign problems. Hang on there!

## Thank You

Please do know that we really appreciate and value your time and work. We love you, really.
