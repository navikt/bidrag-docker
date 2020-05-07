const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {

    // Execute tag bash script
    await exec.exec(`bash ${__dirname}/../verify.sh`);

  } catch (error) {
    core.setFailed(error.message);
  }
}

// noinspection JSIgnoredPromiseFromCall
run();
