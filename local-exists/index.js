const core = require("@actions/core");
const exec = require("@actions/exec");

async function run() {
  try {
    const imageId = core.getInput('image_id');

    // Execute tag bash script
    await exec.exec(`bash ${__dirname}/../exists.sh ${imageId}`);

  } catch (error) {
    core.setFailed(error.message);
  }
}

// noinspection JSIgnoredPromiseFromCall
run();
