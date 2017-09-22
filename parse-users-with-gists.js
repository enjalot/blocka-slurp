const fs = require('fs');
const d3 = require('d3');

const gistCountsString = fs
  .readFileSync('data/gist-counts-by-user.csv')
  .toString();
const gistCounts = d3.csv.parse(gistCountsString);

const knownUsersString = fs.readFileSync('data/usables-prior.csv').toString();
const knownUsers = d3.csv.parse(knownUsersString);

const knownUserHash = {}
knownUsers.forEach(d => knownUserHash[d.username] = true);

let usersWithGists = [];
let newUsersWithGists = [];

gistCounts.forEach(d => {
  if (typeof d.gistCount !== 'undefined' && d.gistCount > 0) {
    usersWithGists.push(d.username);
    if (typeof knownUserHash[d.username] === 'undefined') {
      newUsersWithGists.push(d.username);
    }
  }
});

// write out a file of all users with gists
usersWithGists = usersWithGists.sort();
let csvString = `username\n${usersWithGists.join('\n')}`;
console.log(`${usersWithGists.length} have at least 1 gist`);
fs.writeFileSync('data/usables.csv', csvString);

// write out a file of all users with gists
// who are also new to our index
newUsersWithGists = newUsersWithGists.sort();
csvString = `username\n${newUsersWithGists.join('\n')}`;
console.log(`${newUsersWithGists.length} new users have at least 1 gist`);
fs.writeFileSync('data/new-usables.csv', csvString);
