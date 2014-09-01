# GoogleTaskAdder

Command-line app to add a new task to a Google Tasks list. Requires
a Google account. Uses OAuth2 for account authentication.

## Installation

After cloning this project to a local directory:

1. Obtain a client_secrets.json file from your Google Developer Account:

  a. Visit https://console.developers.google.com/project.
  b. Click "Create Project". Complete dialog.
  c. Click "APIs & auth: APIs" page, enable "Tasks API".
  c. Click "APIs & auth: Credentials" page.
  d  Click "Create new Client ID".
  e. Select "Installed Application" option, click "Create Client ID" to complete dialog.
  f. Click "Download JSON" for the new Client ID, saving as `~/.google_task_adder/client_secrets.json`.

2. Build and install the gem:

    $ rake install

## Usage

    $ gt-add <item> <list>

Example:

    $ gt-add "Go for a bike ride" "Things To Do Today"

First-time use will require user to authenticate via Google OAuth2
process. A browser window will open to login to Google Account and
authorize this Google app to manage the user's Task lists.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/google_task_adder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Google Tasks API references:
  - https://developers.google.com/google-apps/tasks/
  - http://www.rubydoc.info/github/google/google-api-ruby-client/frames