var fs = require('fs');
var jade = require('jade');

var args = process.argv.slice(2);

var writeFilename = './public/dist/view.js';

fs.writeFileSync(writeFilename,'var pre = {' , {flag: 'a'});

args.forEach(function(filename) {
  var realFilename = './client/views/' + filename + '.jade';
  data = fs.readFileSync(realFilename, 'utf8');  
  var fn = jade.compile(data, {filename: realFilename, pretty: true, client: true, compileDebug: false});
  
  var str;
  // "filename": function(...){...}, 
  str = '"' + filename + '": ' 
  str += fn.toString().replace('anonymous', '');
  str += ',';

  fs.writeFileSync(writeFilename, str, {flag: 'a'});
});

fs.writeFileSync(writeFilename,'};' , {flag: 'a'});
