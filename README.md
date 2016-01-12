# Github PR assignment with Slack

Whenever a PR comes in, this Github webhook can randomly assign a member of your team to review it.

### Heroku deployment

1. Add an Incoming Webhook to Slack and copy the URL that is provided to you.
2. Create a new application on Heroku.
3. Add an environment variable called SLACK_ENDPOINT, and paste in your Slack webhook url.
4. Add an environment variable called SLACK_NAMES. It should be a comma-separated list of Slack usernames.
5. Push to Heroku.
6. Go to your app on Github > Settings > Webhooks > Add Webhook.
7. Enter the URL to your Heroku app in the Payload URL field.
8. Choose 'Let me select individual events' and choose only 'Pull Requests'.

You should be good to go!
