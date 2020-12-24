const express = require('express');
const fs = require('fs')
const path = require('path')

const app = express();
const port = 4200;

app.set('etag', false);

/*
// the index.html must have no cache to refresh the hash codes
app.get(/^\/(index.html)*$/, (req, res) => {
  // https://stackoverflow.com/questions/49547/how-do-we-control-web-page-caching-across-all-browsers
  res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
  res.setHeader("Pragma", "no-cache"); // HTTP 1.0
  res.setHeader("Expires", "0"); // Proxies
  res.sendFile('dist/index.html', { root: __dirname });
});

app.use(express.static('dist', {
  index: false,
  etag: false,
  setHeaders: (res, path) => {
    // https://stackoverflow.com/questions/49547/how-do-we-control-web-page-caching-across-all-browsers
    // A nice inter-galactic 1000-year cache
    res.set("Cache-Control", "public, max-age=31556926000"); // HTTP 1.1
    res.set("Expires", new Date(Date.now() + 31556926000000).toUTCString()); // HTTP 1.0, Proxies
  }
}));
*/

app.use(express.static('data', {
  index: false,
  etag: false,
  setHeaders: (res, path) => {
    // https://stackoverflow.com/questions/49547/how-do-we-control-web-page-caching-across-all-browsers
    res.set("Cache-Control", "public, max-age=0"); // HTTP 1.1
    res.set("Expires", new Date(Date.now()).toUTCString()); // HTTP 1.0, Proxies
  }
}));



// for https
// https://stackoverflow.com/questions/11744975/enabling-https-on-express-js
// iOS needs a special certificate
// https://stackoverflow.com/questions/58011737/ios-13-tls-issue

// the self-signed certificates were created using the linux command openssl
// https://wiki.debian.org/Self-Signed_Certificate
// openssl req -new -x509 -nodes -out local.pem -keyout local.key -days 36500
// -nodes removes the passphrase
// to check the end date:
// cat sslcert/local.pem | openssl x509 -noout -enddate
// the .cer file can be exported by Chrome when visiting the website

// if ever non-HTTPS is needed, uncomment this
// but note that many things can behave differently when not using HTTPS
// and android needs a new option for clear text
if (typeof process.env.USE_HTTPS !== 'undefined') {
  app.listen(port, () => console.log(`The app is running at http://localhost:${port}`));
} else {
  var http = require('http');
  var https = require('https');
  var privateKey  = fs.readFileSync('sslcert/key.pem', 'utf8');
  var certificate = fs.readFileSync('sslcert/certificate.crt', 'utf8');

  var credentials = { key: privateKey, cert: certificate };

  var httpsServer = https.createServer(credentials, app);

  httpsServer.listen(port, () => console.log(`The app is running at https://localhost:${port}`));
}
