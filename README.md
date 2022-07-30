# GitHub contribution notifier

Notify your GitHub contribution count to Slack via GitHub Actions.

## Usage

1. Clone this repository
2. Go to repository settings, Security > Secrets > Actions
3. Add `TARGET_GITHUB_USERNAME` secret with your username
4. Add `SLACK_WEBHOOK_URL` with your incoming webhook URL for Slack
5. (Optional) Edit cron string at `.github/workflows/main.yml`

By default, everyday you receive Slack notification with your today's GitHub contribution count at 10pm, JST.

You can run this workflow manually by visiting Actions > Workflows > All workflows > Notifier.

## Motivation

I wanted to remind myself when I've not made any contribution on GitHub today so that I can keep contributing on GitHub every day.
