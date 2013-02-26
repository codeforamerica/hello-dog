# Hello Dog!

Hello dog is a version of Github's Campfire bot, hubot.  He's pretty cool

You can say hello to dog on irc.freenode.net #codeforamerica

![Dog](http://imgace.com/wp-content/uploads/2011/10/hello-yes-this-is-dog.png)

## Adapters

Adapters are the interface to the service you want your hubot to run on. This
can be something like Campfire or IRC. There are a number of third party
adapters that the community have contributed. Check the
[hubot wiki][hubot-wiki] for the available ones.

If you would like to run a non-Campfire or shell adapter you will need to add
the adapter package as a dependency to the `package.json` file in the
`dependencies` section.

Once you've added the dependency and run `npm install` to install it you can
then run hubot with the adapter.

    % bin/hubot -a <adapter>

Where `<adapter>` is the name of your adapter without the `hubot-` prefix.

[hubot-wiki]: https://github.com/github/hubot/wiki

## hubot-scripts

Take a look at the scripts in the `./scripts` folder for examples.
Delete any scripts you think are silly.  Add whatever functionality you
want hubot to have.

There will inevitably be functionality that everyone will want. Instead
of adding it to hubot itself, you can submit pull requests to
[hubot-scripts][hubot-scripts].

To enable scripts from the hubot-scripts package, add the script name with
extension as a double quoted string to the hubot-scripts.json file in this
repo.

[hubot-scripts]: https://github.com/github/hubot-scripts

## Deployment

Hello-dog is hosted on Heroku

If you run into any problems, checkout Heroku's [docs][heroku-node-docs].

You'll need to edit the `Procfile` to set the name of your hubot.

More detailed documentation can be found on the
[deploying hubot onto Heroku][deploy-heroku] wiki page.


[hubot-wiki]: https://github.com/github/hubot/wiki

## Restart the bot

You may want to get comfortable with `heroku logs` and `heroku restart`
if you're having issues.

[![Code for America Tracker](http://stats.codeforamerica.org/codeforamerica/hello-dog.png)](http://stats.codeforamerica.org/projects/hello-dog)
