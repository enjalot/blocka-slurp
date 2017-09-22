const fs = require('fs');
const d3 = require('d3');
const async = require('async');
const request = require('request');

const gh = require('./github');

const parse = function(err, body) {
  if (err) {
    return null;
  }
  try {
    return JSON.parse(body);
  } catch (e) {
    return null;
  }
};

const username = process.argv[2];
const startIndex = process.argv[3];
// example usage startIndex=5004
// node validate-users.js '' 5004
if (username) {
  gh.getUser(username, function(err, response, body) {
    const u = parse(err, body);
    return console.log(u.login, u.public_gists);
  });
} else {
  const existingUsers = [];
  let newUsers = [];
  // we keep track of which users we already had and which are new
  try {
    const euStr = fs.readFileSync('data/usables.csv').toString();
    const eu = d3.csv.parse(euStr);
    eu.forEach(u => existingUsers.push(u.username));
    console.log(`${existingUsers.length} existing users`);
  } catch (error) {
    const e = error;
    console.log("couldn't read existing usables.csv");
  }

  const usersString = fs.readFileSync('data/users-combined.csv').toString();
  let users = d3.csv.parse(usersString);
  if (startIndex) {
    users = users.slice(startIndex);
  }
  let usables = [];
  async.eachLimit(
    users,
    5,
    (user, userCb) =>
      gh.getUser(user.username, function(err, response, body) {
        if (err) {
          console.log(user.username, err);
        }
        const u = parse(err, body);
        console.log(user.username, u != null ? u.public_gists : undefined);
        console.log(
          'x-ratelimit-remaining:',
          response != null
            ? response.headers['x-ratelimit-remaining']
            : undefined
        );
        if (
          (response != null
            ? response.headers['x-ratelimit-remaining']
            : undefined) <= 1
        ) {
          return;
        }
        if (!u) {
          return userCb();
        }
        //console.log err, response, u
        if (u.public_gists > 0 && usables.indexOf(u.login) < 0) {
          if (existingUsers.indexOf(u.login) < 0) {
            newUsers.push(u.login);
          }
          usables.push(u.login);
        }
        //if u.public_gists == 0
        //  console.log "no gists", u.login
        return setTimeout(() => userCb(), 50);
      }),
    function() {
      usables = usables.sort();
      let str = `username\n${usables.join('\n')}`;
      console.log(`${usables.length} have at least 1 gist`);
      fs.writeFileSync('data/usables.csv', str);

      newUsers = newUsers.sort();
      str = `username\n${newUsers.join('\n')}`;
      console.log(`${newUsers.length} new users`);
      return fs.writeFileSync('data/new-usables.csv', str);
    }
  );
}
