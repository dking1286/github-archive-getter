# Github Archive Getter
A CLI to create a leaderboard of Github Activity

## Setup
### Prerequisites
These setup instructions will assume that you have the following
installed already:
* Ruby
* Bundler
### Installation
After forking and cloning the project, install the dependencies
as follows:
```bash
bundle install
```
Now you are ready to use the Github Archive Getter!

## Usage
### Examples
List the 20 repositories that have had the most PushEvents from Nov 1 2012 to Nov 2 2012:
```bash
./gh_repo_stats --after 2012-11-01T13:00:00Z --before 2012-11-02T03:12:14-03:00 --event PushEvent --count 20
```
Result:
```bash
sakai-mirror/melete - 178 events
runningforworldpeace/feeds - 106 events
chapuni/llvm-project - 90 events
chapuni/llvm-project-submodule - 90 events
gtr32x/ece254_lab2 - 86 events
klange/tales-of-darwinia - 74 events
bcomdlc/bcom-homepage-archive - 73 events
artmig/artmig.github.com - 71 events
sakai-mirror/test-center - 71 events
sakai-mirror/mneme - 70 events
sakai-mirror/ambrosia - 70 events
Frameset91/untitled0815 - 63 events
mozilla/mozilla-central - 58 events
josmera01/juanrueda-internation - 57 events
pardus-anka/2013 - 56 events
gnuhub/gnuhub_server - 56 events
tbondwilkinson/Digital-Collator - 49 events
ehsan/mozilla-history-tools - 49 events
dekmabot/Asterix-CMS - 47 events
imamatha/search-2 - 43 events
```

### API
To run the Github Archive Getter, use the command `./gh_repo_stats`.
This command accepts the following arguments:
* `--after`: The date to begin counting events. Defaults to `2011-02-12T00:00:00Z`.
* `--before`: The date to stop counting events. Defaults to the current date.
* `--event`: The type of event to count. Defaults to counting all events if not provided.
* `--count`: The number of repositories to list in the output. Defaults to 100.