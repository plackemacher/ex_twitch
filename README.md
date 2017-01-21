[![Build Status](https://travis-ci.org/plackemacher/ex_twitch.svg?branch=master)](https://travis-ci.org/plackemacher/ex_twitch)
[![Codecov master](https://img.shields.io/codecov/c/github/plackemacher/ex_twitch/master.svg)](https://codecov.io/gh/plackemacher/ex_twitch)
[![Inline docs](http://inch-ci.org/github/plackemacher/ex_twitch.svg)](http://inch-ci.org/github/plackemacher/ex_twitch)

# ExTwitch

Simple Elixir wrapper for the [Twitch V5 API](https://dev.twitch.tv/docs/).

This is still a work in progress but some aspects do work. **Use at your own risk.**

## Installation

The package can be installed by adding `ex_twitch` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_twitch, "~> 0.0.1"}]
end
```

## Currently Implemented

The checked items are the currently supported API calls. If you'd like to contribute to the implementation of one or
you've seen that Twitch has added another API, feel free to do a pull request to add it to the list and/or implement it. :grinning:

- [Channel Feed](https://dev.twitch.tv/docs/v5/reference/channel-feed/)
  - [ ] Get Multiple Feed Posts
  - [ ] Get Feed Post
  - [ ] Create Feed Post
  - [ ] Delete Feed Post
  - [ ] Create Reaction to a Feed Post
  - [ ] Delete Reaction to a Feed Post
  - [ ] Get Feed Comments
  - [ ] Create Feed Comment
  - [ ] Delete Feed Comment
  - [ ] Create Reaction to a Feed Comment
  - [ ] Delete Reaction to a Feed Comment
- [Channels](https://dev.twitch.tv/docs/v5/reference/channels/)
  - [x] Get Channel
  - [x] Get Channel by ID
  - [x] Update Channel
  - [ ] Get Channel Editors
  - [ ] Get Channel Followers
  - [ ] Get Channel Teams
  - [ ] Get Channel Subscribers
  - [ ] Check Channel Subscription by User
  - [ ] Get Channel Videos
  - [ ] Start Channel Commercial
  - [ ] Reset Channel Stream Key
- [Chat](https://dev.twitch.tv/docs/v5/reference/chat/)
  - [x] Get Chat Badges by Channel
  - [ ] Get Chat Emoticons by Set
  - [ ] Get All Chat Emoticons
- [Games](https://dev.twitch.tv/docs/v5/reference/games/)
  - [ ] Get Top Games
- [Ingests](https://dev.twitch.tv/docs/v5/reference/ingests/)
  - [ ] Get Ingest Server List
- [Search](https://dev.twitch.tv/docs/v5/reference/search/)
  - [ ] Search Channels
  - [ ] Search Streams
  - [ ] Search Games
- [Streams](https://dev.twitch.tv/docs/v5/reference/streams/)
  - [ ] Get Stream by Channel
  - [ ] Get All Streams
  - [ ] Get Followed Streams
  - [ ] Get Featured Streams
  - [ ] Get Streams Summary
- [Teams](https://dev.twitch.tv/docs/v5/reference/teams/)
  - [ ] Get All Teams
  - [x] Get Team
- [Users](https://dev.twitch.tv/docs/v5/reference/users/)
  - [x] Get User
  - [x] Get User by ID
  - [x] [Get User by User Name](https://dev.twitch.tv/docs/v5/guides/using-the-twitch-api/#translating-from-user-names-to-user-ids)
  - [x] Get User Emotes
  - [x] Check User Subscription by Channel
  - [x] Get User Follows
  - [ ] Check User Follows by Channel
  - [ ] Follow Channel
  - [ ] Unfollow Channel
  - [ ] Get User Block List
  - [ ] Block User
  - [ ] Unblock User
- [Videos](https://dev.twitch.tv/docs/v5/reference/videos/)
  - [ ] Get Video
  - [ ] Get Top Videos
  - [ ] Get Followed Videos
