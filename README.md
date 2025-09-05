[![Release](https://github.com/fgardt/factorio-mod-template/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/fgardt/factorio-mod-template/actions/workflows/release.yml)
<!--                           ^======[REPLACE THIS]======^                                                                          ^======[REPLACE THIS]======^  -->

# factorio-mod-template

A small Factorio Mod template which also contains GitHub Actions for automatic changelog generation, packaging and releasing to the [Factorio Mod Portal](https://mods.factorio.com)

# How it works

This template uses [semantic-release](https://github.com/semantic-release/semantic-release) to automate the changelog generation aswell as packaging and releasing of the mod. \
To achieve this it analyzes your commit messages to figure out what the new version should be and what to put into the changelog.
Packaging and releasing to the factorio mod portal is done with [this plugin](https://github.com/fgardt/semantic-release-factorio). \
Additionally the GitHub Action will also create a release in your repository on GitHub itself.

Once you push new commits to the main branch the release action will trigger. \
First it will analyze all commits since the last release (determined from the last tag) to figure out if a new version should be released and what version it should be. \
To make this possible you need to follow a commit message convention. The default convention this template uses is [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) with the following types:

| Commit type                 | Changelog section |
| --------------------------- | ----------------- |
| `feat` or `feature`         | `Features`        |
| `fix`                       | `Bugfixes`        |
| `perf` or `performance`     | `Optimizations`   |
| `compat` or `compatibility` | `Compatibility`   |
| `balance`                   | `Balancing`       |
| `graphics`                  | `Graphics`        |
| `sound`                     | `Sounds`          |
| `gui`                       | `Gui`             |
| `info`                      | `Info`            |
| `locale`                    | `Locale`          |
| `translate`                 | `Translation`     |
| `control`                   | `Control`         |
| `other`                     | `Changes`         |

Because a push to the main branch triggers the release action it is recommended to work on a separate branch until your work is done and then merge that branch into main to release it. \
_Or you just work locally and if you want to release you push your changes to main, up to you how you want to do it ;)_

# How to use

## Repository setup

Click the `Use this template` button and create your own repository.

Once you have your new repository you need to add a Factorio token as a GitHub Actions secret so that the mod releasing can work. \
To get the token go to [Factorio's website](https://factorio.com/login) and login with your account. \
Then you need to go to your [profile](https://factorio.com/profile) and generate a new API key. \
The API key needs `Upload Mods`, `Publish Mods` and `Edit Mods` permissions. Copy the generated key.

Now you need to go to your repository settings > `Secrets and variables` > `Actions` and add a new Repository secret called `FACTORIO_TOKEN` with your copied key as the secret.

## Mod setup

- Swap out the [`LICENSE`](LICENSE) to your own liking _**(especially change out my name for yours)**_
- Populate the [`info.json`](info.json) file with correct values _(the `version` field gets updated automatically)_
- Add the corresponding text into [`locale.cfg`](locale/en/locale.cfg)
- Add a `thumbnail.png` to the root of the repository

More details about a mods structure can be found in the [documentation](https://lua-api.factorio.com/latest/auxiliary/mod-structure.html).

# Moshine Start

Adds support for starting in [Moshine](https://mods.factorio.com/mod/Moshine), via [Any Planet Start](https://mods.factorio.com/mod/any-planet-start).

## Changes

- Mixed ore mines faster.
- Mixed ore also includes stone. This allows automated production of Military Science, Production Science, both furnaces and concrete (without Foundry) .
- A burner Steam Extractor is added for early game use of the Steam geysers.
- A Steam Hammer building is added, for pressing Molten Iron into plates without a Foundry.

# Credits

Steam Extractor is the [BZ Natural Gas](https://mods.factorio.com/mod/bzgas)'s Gas Extractor.

Boiler technology icon is from [KS Power](https://mods.factorio.com/mod/KS_Power).