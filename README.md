# Dear Future Developer

I'm not really a rails developer, so I'm sure I've done a lot of stuff wrong.
I hope it doesn't cause you too much pain.

This is a pretty standard rails app.
It provides a sorta RESTful JSON api for the [rainworks-app](https://github.com/simonbw/rainworks-app) to talk to.
It uses [Administrate](https://github.com/thoughtbot/administrate) for the admin pages.
It uses PostgreSQL for storing data (you'll need to install that).

It's deployed on heroku at [rainworks-backend.herokuapp.com].
**Be careful:** This app is setup to deploy to production whenever you push to master.

Before you get started you will want to copy `.env.template` into `.env` and update the values.
These are the config values rails will use while running 
`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` should be the credentials for an AWS account with an S3 bucket to upload images into.
`S3_BUCKET` is the name of the bucket that images will be stored in.
`SENDGRID_USERNAME` and `SENDGRID_PASSWORD` are credentials for the sendgrid account we use to send emails.
`NOTIFICATIONS_TO_EMAIL` is the email address you want notifications sent to when someone submits or reports a rainwork.

Good Luck!