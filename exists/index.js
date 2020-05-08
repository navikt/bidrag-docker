const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    const imageName = core.getInput('image_name');

    // Execute tag bash script
    await exec.exec(`bash ${__dirname}/../exists.sh ${imageName}`);

  } catch (error) {
    core.setFailed(error.message);
  }
}

// noinspection JSIgnoredPromiseFromCall
run();
