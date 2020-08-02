# README

## Everlywell Challenge Experts Directory Search Tool (JSON API only)

To ensure the url shortener functionality works, create an local_env.yml and add `BITLY_ACCESS_TOKEN`

Without this token, the app will still run but `short_url` will be `null` for all member entries

To get started:
1. Install specified rails and ruby version
2. Install & start postgres
3. `bundle install`
4. `rails db:create`
5. `rails server`

Runs locally at `localhost:3000`

Try it out!

| ENDPOINT       | ACTION          | DESCRIPTION                |
| -------------- | --------------- | -------------------------- |
| /members       | GET             | Lists all existing members |
| /members/:id   | GET             | Show single member and info |
| /members/:id   | POST            | Create a member with name and website |
| /members/:id   | PATCH           | Update friendship for a member with `friend_id` param |
| /members/:id/search   | GET           | Find someone in member's network matching `keywords` param in their profile |