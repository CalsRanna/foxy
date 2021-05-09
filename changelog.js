const fs = require("fs");
const md = require("markdown-it")();

fs.readFile("./CHANGELOG.md", (error, buffer) => {
  fs.writeFileSync("./changelog.html", md.render(buffer.toString()));
});
